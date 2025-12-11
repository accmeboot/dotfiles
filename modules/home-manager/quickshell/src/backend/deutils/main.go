package main

import (
	"encoding/json"
	"fmt"
	"os"
	"path/filepath"
	"strings"

	"gopkg.in/ini.v1"
)

type DesktopEntry struct {
	ID          string   `json:"id"`
	Name        string   `json:"name"`
	GenericName string   `json:"genericName,omitempty"`
	Comment     string   `json:"comment,omitempty"`
	Icon        string   `json:"icon,omitempty"`
	Exec        string   `json:"exec,omitempty"`
	Terminal    bool     `json:"terminal"`
	Categories  []string `json:"categories,omitempty"`
	Keywords    []string `json:"keywords,omitempty"`
	NoDisplay   bool     `json:"noDisplay"`
	Hidden      bool     `json:"hidden"`
	Path        string   `json:"path"`
}

func getDesktopDirs() []string {
	dirs := []string{}

	// User directory
	if home, err := os.UserHomeDir(); err == nil {
		dirs = append(dirs, filepath.Join(home, ".local/share/applications"))
	}

	// System directories
	dirs = append(dirs, "/usr/share/applications")
	dirs = append(dirs, "/usr/local/share/applications")

	// Flatpak directories
	dirs = append(dirs, "/var/lib/flatpak/exports/share/applications")
	if home, err := os.UserHomeDir(); err == nil {
		dirs = append(dirs, filepath.Join(home, ".local/share/flatpak/exports/share/applications"))
	}

	// Snap directory
	dirs = append(dirs, "/var/lib/snapd/desktop/applications")

	// Additional XDG_DATA_DIRS
	if xdgDirs := os.Getenv("XDG_DATA_DIRS"); xdgDirs != "" {
		for _, dir := range strings.Split(xdgDirs, ":") {
			appDir := filepath.Join(dir, "applications")
			// Avoid duplicates
			isDuplicate := false
			for _, existing := range dirs {
				if existing == appDir {
					isDuplicate = true
					break
				}
			}
			if !isDuplicate {
				dirs = append(dirs, appDir)
			}
		}
	}

	// Filter out non-existent directories
	existingDirs := []string{}
	for _, dir := range dirs {
		if _, err := os.Stat(dir); err == nil {
			existingDirs = append(existingDirs, dir)
		}
	}

	return existingDirs
}

func parseDesktopFile(path string) (*DesktopEntry, error) {
	cfg, err := ini.Load(path)
	if err != nil {
		return nil, err
	}

	section := cfg.Section("Desktop Entry")
	if section == nil {
		return nil, fmt.Errorf("no [Desktop Entry] section found")
	}

	// Skip non-application entries
	entryType := section.Key("Type").String()
	if entryType != "Application" && entryType != "" {
		return nil, fmt.Errorf("not an application entry")
	}

	entry := &DesktopEntry{
		ID:          strings.TrimSuffix(filepath.Base(path), ".desktop"),
		Name:        section.Key("Name").String(),
		GenericName: section.Key("GenericName").String(),
		Comment:     section.Key("Comment").String(),
		Icon:        section.Key("Icon").String(),
		Exec:        section.Key("Exec").String(),
		Terminal:    section.Key("Terminal").MustBool(false),
		NoDisplay:   section.Key("NoDisplay").MustBool(false),
		Hidden:      section.Key("Hidden").MustBool(false),
		Path:        path,
	}

	// Parse categories
	if categories := section.Key("Categories").String(); categories != "" {
		entry.Categories = strings.Split(strings.TrimSuffix(categories, ";"), ";")
	}

	// Parse keywords
	if keywords := section.Key("Keywords").String(); keywords != "" {
		entry.Keywords = strings.Split(strings.TrimSuffix(keywords, ";"), ";")
	}

	// Use localized name if available
	locale := os.Getenv("LANG")
	if locale != "" {
		// Try full locale (e.g., en_US.UTF-8)
		localeName := section.Key("Name[" + strings.Split(locale, ".")[0] + "]").String()
		if localeName == "" {
			// Try language only (e.g., en)
			lang := strings.Split(locale, "_")[0]
			localeName = section.Key("Name[" + lang + "]").String()
		}
		if localeName != "" {
			entry.Name = localeName
		}
	}

	return entry, nil
}

func findDesktopFiles() []*DesktopEntry {
	entries := []*DesktopEntry{}
	seen := make(map[string]bool) // Track seen desktop IDs to handle overrides

	dirs := getDesktopDirs()

	// Process directories in order (user dirs first for proper override behavior)
	for _, dir := range dirs {
		files, err := filepath.Glob(filepath.Join(dir, "*.desktop"))
		if err != nil {
			continue
		}

		for _, file := range files {
			desktopID := strings.TrimSuffix(filepath.Base(file), ".desktop")

			// Skip if we've already seen this ID (respect override order)
			if seen[desktopID] {
				continue
			}
			seen[desktopID] = true

			entry, err := parseDesktopFile(file)
			if err != nil {
				continue
			}

			// Skip hidden or no-display entries
			if entry.Hidden || entry.NoDisplay {
				continue
			}

			// Skip entries without names or exec
			if entry.Name == "" {
				continue
			}

			entries = append(entries, entry)
		}
	}

	return entries
}

func main() {
	var cmd string
	if len(os.Args) > 1 {
		cmd = os.Args[1]
	}

	switch cmd {
	case "list", "":
		entries := findDesktopFiles()
		output, err := json.Marshal(entries)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error encoding JSON: %v\n", err)
			os.Exit(1)
		}
		fmt.Print(string(output))

	case "search":
		if len(os.Args) < 3 {
			fmt.Fprintf(os.Stderr, "Usage: %s search <query>\n", os.Args[0])
			os.Exit(1)
		}
		query := strings.ToLower(os.Args[2])
		entries := findDesktopFiles()
		matches := []*DesktopEntry{}

		for _, entry := range entries {
			// Search in name, generic name, comment, and keywords
			searchText := strings.ToLower(entry.Name + " " + entry.GenericName + " " + entry.Comment + " " + strings.Join(entry.Keywords, " "))
			if strings.Contains(searchText, query) {
				matches = append(matches, entry)
			}
		}

		output, err := json.Marshal(matches)
		if err != nil {
			fmt.Fprintf(os.Stderr, "Error encoding JSON: %v\n", err)
			os.Exit(1)
		}
		fmt.Print(string(output))

	case "launch":
		if len(os.Args) < 3 {
			fmt.Fprintf(os.Stderr, "Usage: %s launch <desktop-id>\n", os.Args[0])
			os.Exit(1)
		}
		// For launching, you'd typically use xdg-open or parse the Exec field
		// This is just a placeholder
		fmt.Printf("Would launch: %s\n", os.Args[2])

	default:
		fmt.Fprintf(os.Stderr, "Unknown command: %s\n", cmd)
		fmt.Fprintf(os.Stderr, "Available commands: list, search <query>, launch <id>\n")
		os.Exit(1)
	}
}

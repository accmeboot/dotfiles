{ pkgs, config, ... }: {
  home.packages = let
    colors = config.lib.stylix.colors;
    dwm = pkgs.dwm.override {
      conf = ''
        /* See LICENSE file for copyright and license details. */
        #include <X11/XF86keysym.h>

        /* appearance */
        static const unsigned int borderpx = 1; /* border pixel of windows */
        static const unsigned int gappx = 0;    /* gaps between windows */
        static const unsigned int snap = 16;    /* snap pixel */
        static const int showbar = 1;           /* 0 means no bar */
        static const int topbar = 1;            /* 0 means bottom bar */
        static const int horizpadbar = 0;       /* horizontal padding for statusbar */
        static const int vertpadbar = 10;       /* vertical padding for statusbar */
        static const char* fonts[] = {"SFProDisplay Nerd Font:size=12"};
        static const char dmenufont[] = "SFProDisplay Nerd Font:size=12";
        static unsigned int baralpha = 0xe6;
        static unsigned int borderalpha = OPAQUE;
        static const char col_gray1[] = "#${colors.base00}";
        static const char col_gray2[] = "#${colors.base03}";
        static const char col_gray3[] = "#${colors.base04}";
        static const char col_gray4[] = "#${colors.base05}";
        static const char col_cyan[] = "#${colors.base0D}";
        static const char* colors[][3] = {
            /*               fg         bg         border   */
            [SchemeNorm] = {col_gray4, col_gray1, col_gray2},
            [SchemeSel] = {col_gray1, col_cyan, col_cyan},
            [SchemeTitle] = {col_gray4, col_gray1, col_gray2},
        };

        /* tagging */
        static const char* tags[] = {"1", "2", "3", "4", "5", "6", "7", "8", "9"};

        static const Rule rules[] = {
            /* class      instance    title       tags mask     isfloating   monitor */
            {"SystemMenuFloat", NULL, NULL, 0, 1, -1},
        };

        /* layout(s) */
        static const float mfact = 0.55; /* factor of master area size [0.05..0.95] */
        static const int nmaster = 1;    /* number of clients in master area */
        static const int resizehints =
            1; /* 1 means respect size hints in tiled resizals */
        static const int lockfullscreen =
            1; /* 1 will force focus on the fullscreen window */
        static const int refreshrate =
            120; /* refresh rate (per second) for client move/resize */

        static const Layout layouts[] = {
            /* symbol     arrange function */
            {"[]=", tile}, /* first entry is default */
            {"><>", NULL}, /* no layout function means floating behavior */
            {"[M]", monocle},
        };

        /* key definitions */
        #define MODKEY Mod4Mask
        #define TAGKEYS(KEY, TAG)                                        \
          {MODKEY, KEY, view, {.ui = 1 << TAG}},                         \
              {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}}, \
              {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},          \
              {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

        /* helper for spawning shell commands in the pre dwm-5.0 fashion */
        #define SHCMD(cmd)                                      \
          {                                                     \
            .v = (const char*[]) { "/bin/sh", "-c", cmd, NULL } \
          }

        /* commands */
        static char dmenumon[2] =
            "0"; /* component of dmenucmd, manipulated in spawn() */
        static const char* dmenucmd[] = {"rofi", "-show", "menu", NULL};
        static const char* termcmd[] = {"wezterm", NULL};

        /* screenshot commands */
        static const char* screenshot_full[] = {
            "sh", "-c",
            "mkdir -p ~/Screenshots && filename=\"$HOME/Screenshots/$(date "
            "+'%Y-%m-%d-%H%M%S_screenshot.png')\" && scrot \"$filename\" && xclip "
            "-selection clipboard -t image/png < \"$filename\" && notify-send -a "
            "'Screenshot' 'Screenshot' \"Full screen captured\\nSaved to: "
            "$filename\\nCopied to clipboard\" -i \"$filename\"",
            NULL};
        static const char* screenshot_select[] = {
            "sh", "-c",
            "sleep 0.1 && mkdir -p ~/Screenshots && "
            "filename=\"$HOME/Screenshots/$(date "
            "+'%Y-%m-%d-%H%M%S_screenshot.png')\" && scrot -s \"$filename\" && xclip "
            "-selection clipboard -t image/png < \"$filename\" && notify-send -a "
            "'Screenshot' 'Screenshot' \"Area selection captured\\nSaved to: "
            "$filename\\nCopied to clipboard\" -i \"$filename\"",
            NULL};

        /* volume control */
        static const char* vol_mute[] = {"wpctl", "set-mute", "@DEFAULT_AUDIO_SINK@",
                                         "toggle", NULL};
        static const char* vol_down[] = {"wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@",
                                         "1%-", NULL};
        static const char* vol_up[] = {"wpctl", "set-volume", "@DEFAULT_AUDIO_SINK@",
                                       "1%+", NULL};
        static const char* mic_mute[] = {"wpctl", "set-mute", "@DEFAULT_AUDIO_SOURCE@",
                                         "toggle", NULL};

        /* brightness control */
        static const char* bright_down[] = {"brightnessctl", "set", "5%-", NULL};
        static const char* bright_up[] = {"brightnessctl", "set", "5%+", NULL};

        static const Key keys[] = {
            /* modifier                     key        function        argument */
            {MODKEY, XK_p, spawn, {.v = dmenucmd}},
            {MODKEY | ShiftMask, XK_Return, spawn, {.v = termcmd}},
            {MODKEY, XK_b, togglebar, {0}},
            {MODKEY, XK_j, focusstack, {.i = +1}},
            {MODKEY, XK_k, focusstack, {.i = -1}},
            {MODKEY, XK_i, incnmaster, {.i = +1}},
            {MODKEY, XK_d, incnmaster, {.i = -1}},
            {MODKEY, XK_h, setmfact, {.f = -0.05}},
            {MODKEY, XK_l, setmfact, {.f = +0.05}},
            {MODKEY, XK_Return, zoom, {0}},
            {MODKEY, XK_Tab, view, {0}},
            {MODKEY | ShiftMask, XK_c, killclient, {0}},
            {MODKEY, XK_t, setlayout, {.v = &layouts[0]}},
            {MODKEY, XK_f, setlayout, {.v = &layouts[1]}},
            {MODKEY, XK_m, setlayout, {.v = &layouts[2]}},
            {MODKEY, XK_space, setlayout, {0}},
            {MODKEY | ShiftMask, XK_space, togglefloating, {0}},
            {MODKEY | ShiftMask, XK_e, togglefullscr, {0}},
            {MODKEY, XK_0, view, {.ui = ~0}},
            {MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},
            {MODKEY, XK_comma, focusmon, {.i = -1}},
            {MODKEY, XK_period, focusmon, {.i = +1}},
            {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
            {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
            TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
                TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5) TAGKEYS(XK_7, 6) TAGKEYS(XK_8, 7)
                    TAGKEYS(XK_9, 8){MODKEY | ShiftMask, XK_q, quit, {0}},

            /* Screenshot bindings */
            {0, XK_Print, spawn, {.v = screenshot_full}},
            {MODKEY, XK_Print, spawn, {.v = screenshot_select}},

            /* Media keys */
            {0, XF86XK_AudioMute, spawn, {.v = vol_mute}},
            {0, XF86XK_AudioLowerVolume, spawn, {.v = vol_down}},
            {0, XF86XK_AudioRaiseVolume, spawn, {.v = vol_up}},
            {0, XF86XK_AudioMicMute, spawn, {.v = mic_mute}},
            {0, XF86XK_MonBrightnessDown, spawn, {.v = bright_down}},
            {0, XF86XK_MonBrightnessUp, spawn, {.v = bright_up}},
        };

        /* button definitions */
        /* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
         * ClkClientWin, or ClkRootWin */
        static const Button buttons[] = {
            /* click                event mask      button          function argument */
            {ClkLtSymbol, 0, Button1, setlayout, {0}},
            {ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]}},
            {ClkWinTitle, 0, Button2, zoom, {0}},
            {ClkStatusText, 0, Button2, spawn, {.v = termcmd}},
            {ClkClientWin, MODKEY, Button1, movemouse, {0}},
            {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
            {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
            {ClkTagBar, 0, Button1, view, {0}},
            {ClkTagBar, 0, Button3, toggleview, {0}},
            {ClkTagBar, MODKEY, Button1, tag, {0}},
            {ClkTagBar, MODKEY, Button3, toggletag, {0}},
        };
      '';
      patches = [
        ./patches/dwm-titlecolor-20210815-ed3ab6b4.diff
        ./patches/dwm-alpha-20250918-74edc27.diff
        ./patches/dwm-statuspadding-6.3.diff
        ./patches/dwm-alwayscenter-20200625-f04cac6.diff
        ./patches/dwm-actualfullscreen-20211013-cb3f58a.diff
        ./patches/dwm-fullgaps-6.4.diff
      ];
    };
  in with pkgs; [ dwm ];

  home.file.".xinitrc" = {
    source = ./.xinitrc;
    executable = true;
  };
}

# gamescope -W 2560 -H 1440 --force-grab-cursor --adaptive-sync --force-composition -f -- %command%

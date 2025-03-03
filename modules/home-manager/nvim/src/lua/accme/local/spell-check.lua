local function get_suggestions()
	local suggestions = vim.fn.spellsuggest(vim.fn.expand("<cword>"))

	if #suggestions == 0 then
		suggestions = { "No suggestions" }
	end

	-- Add 2 spaces to the beginning of each line for padding
	for i, suggestion in ipairs(suggestions) do
		suggestions[i] = "  " .. suggestion
	end

	return suggestions
end

local function get_win_dimenstions(suggestions)
	local width = 0
	local height = #suggestions

	for _, suggestion in ipairs(suggestions) do
		local length = #suggestion
		if length > width then
			width = length
		end
	end

	local win_height = vim.api.nvim_win_get_height(0)

	if height > math.floor(win_height / 4) then
		height = math.floor(win_height / 4)
	end

	return width + 2, height -- 2 is padding, the same is done in get_suggestions
end

local function set_window_options(win)
	local hint_hl = vim.api.nvim_get_hl_by_name("Search", true)
	local hint_bg = hint_hl["background"]
	local hint_fg = hint_hl["foreground"]

	if hint_bg and hint_fg then
		hint_bg = string.format("%x", hint_bg)
		hint_fg = string.format("%x", hint_fg)
		vim.cmd("highlight SpellSuggestionLine guibg=#" .. hint_bg .. " guifg=#" .. hint_fg)
		vim.api.nvim_win_set_option(win, "cursorlineopt", "line")
		vim.api.nvim_win_set_option(win, "winhighlight", "CursorLine:SpellSuggestionLine")
	end

	vim.api.nvim_win_set_option(win, "cursorline", true)
end

local function is_fit(height)
	local win_height = vim.api.nvim_win_get_height(0)
	local cursor = vim.api.nvim_win_get_cursor(0)
	local cursor_row = cursor[1]
	local first_visible_line = vim.fn.line("w0")
	local space_below = win_height - (cursor_row - first_visible_line + 3)

	return space_below >= height
end

local function get_win_options(width, height)
	local win_options = {}
	local anchor = "NW"
	local row = 1

	if not is_fit(height) then
		anchor = "SW"
		row = 0
	end

	win_options.relative = "cursor"
	win_options.border = "rounded"
	win_options.style = "minimal"
	win_options.col = 0
	win_options.anchor = anchor
	win_options.row = row
	win_options.width = width
	win_options.height = height

	return win_options
end

local function create_floating_window(width, height)
	local buf = vim.api.nvim_create_buf(false, true)
	local win = vim.api.nvim_open_win(buf, true, get_win_options(width, height))

	set_window_options(win)

	return buf
end

local function set_buf_env(buf, suggestions)
	vim.api.nvim_buf_set_lines(buf, 0, -1, false, suggestions)
	vim.api.nvim_buf_set_option(buf, "modifiable", false)
	vim.api.nvim_buf_set_keymap(
		buf,
		"n",
		"<CR>",
		"<Cmd>lua replace_word_from_spell_suggestion_window()<CR>",
		{ noremap = true, silent = true }
	)
	vim.api.nvim_buf_set_keymap(
		buf,
		"n",
		"<Esc>",
		"<Cmd>lua close_spell_suggestion_window()<CR>",
		{ noremap = true, silent = true }
	)
end

-- Global for autocmd
function _G.close_spell_suggestion_window()
	local buf = vim.api.nvim_get_current_buf()
	vim.api.nvim_win_close(0, true)
	vim.api.nvim_buf_delete(buf, { force = true })
end

function _G.replace_word_from_spell_suggestion_window()
	local buf = vim.api.nvim_get_current_buf()
	local line = vim.api.nvim_buf_get_lines(buf, vim.fn.line(".") - 1, vim.fn.line("."), false)[1]
	close_spell_suggestion_window()
	-- Remove leading spaces
	line = string.gsub(line, "^%s*(.-)%s*$", "%1")
	vim.cmd("normal ciw" .. line)
end

function _G.open_spell_suggestion_window()
	local suggestions = get_suggestions()
	local width, height = get_win_dimenstions(suggestions)
	local buf = create_floating_window(width, height)

	set_buf_env(buf, suggestions)
end

vim.cmd("command! -nargs=0 SpellSuggestions lua open_spell_suggestion_window()")

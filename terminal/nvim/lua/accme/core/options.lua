local opt = vim.opt -- options gloabals variable

vim.g.have_nerd_font = true

-- line numbers
-- opt.number = true -- Show current line number
opt.relativenumber = true -- Show relative line numbers

-- tabs & indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- line wrapping
opt.wrap = false

-- search settings
opt.ignorecase = true
opt.smartcase = true
-- cursor
opt.cursorline = true

-- appearance
opt.termguicolors = true
-- opt.background = "transparent" -- doesn't work this way
opt.signcolumn = "yes" -- adds to the termguicolor something

-- backspace
opt.backspace = "indent,eol,start" --- I HAVE NO IDEA WHAT IT

-- clipboard
opt.clipboard:append("unnamedplus") -- for copy/paste from the outside

--[[ Every wrapped line will continue visually indented (same amount of
	space as the beginning of that line), thus preserving horizontal blocks
	of text.
--]]
opt.breakindent = true

opt.undofile = true

-- split windows
opt.splitright = true
opt.splitbelow = true

opt.spelllang = "en_us"
opt.spell = true

-- keep cursor in the middle of the screen (almost)
opt.scrolloff = 10
opt.updatetime = 50

-- FOLDING --
opt.foldmethod = "indent"

--hides the foldcolumn
opt.foldcolumn = "0"
-- makes all folds open by default
opt.foldlevelstart = 99

-- statuscolumn
opt.statuscolumn = ' %s%{(&filetype !=# "netrw" && &buftype !=# "nofile") ? (v:relnum?v:relnum:v:lnum) : ""} '

opt.fillchars:append({ eob = " " })

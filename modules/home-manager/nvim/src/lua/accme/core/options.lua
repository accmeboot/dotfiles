local opt = vim.opt -- options gloabals variable

-- Set here, not in keymaps.lua: must be set before plugins define mappings
vim.g.mapleader = " "

vim.g.have_nerd_font = true

-- home-manager generates its own init.lua with these, but this config's
-- init.lua shadows it, so set them here (matches withRuby/withPython3 = false)
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_python3_provider = 0

-- line numbers
opt.number = true -- Show current line number
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
opt.laststatus = 3 -- one statusline for all windows (lualine's `globalstatus`)
opt.pumborder = "rounded" -- border around the completion popupmenu
opt.termguicolors = true
opt.signcolumn = "yes"

-- backspace
opt.backspace = "indent,eol,start" --- I HAVE NO IDEA WHAT IT

-- clipboard
opt.clipboard:append("unnamedplus") -- for copy/paste from the outside

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

opt.fillchars:append({ eob = " " })

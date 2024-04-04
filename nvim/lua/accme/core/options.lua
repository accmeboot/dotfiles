local opt = vim.opt -- options gloabals variable

-- line numbers
opt.relativenumber = true

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

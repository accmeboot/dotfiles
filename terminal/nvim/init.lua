-- Need to disable netrw plugin for yazi to take over properly
vim.g.loaded_netrwPlugin = 0

require("accme.core.options")
require("accme.core.keymaps")

require("accme.lazy")

require("accme.core.colorscheme")

-- local
require("accme.local.spell-check")
require("accme.local.statusline")

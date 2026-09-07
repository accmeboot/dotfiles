return {
  "AlexandrosAlexiou/kotlin.nvim",
  ft = { "kotlin" },
  dependencies = {
    "folke/trouble.nvim",
  },
  -- The JetBrains kotlin-lsp build this drives has expired ("This build of
  -- intellij-server has expired"), and the newest upstream release is the
  -- expired one, so mason cannot install a working server yet.
  -- Re-enable once https://github.com/Kotlin/kotlin-lsp/issues/217 is fixed,
  -- and drop kotlin_language_server from lspconfig.lua at the same time.
  enabled = false,
  config = function()
    require("kotlin").setup {}
  end,
}

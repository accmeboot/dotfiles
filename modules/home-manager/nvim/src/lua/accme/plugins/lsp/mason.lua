return {
  "williamboman/mason.nvim",
  dependencies = { "williamboman/mason-lspconfig.nvim", "WhoIsSethDaniel/mason-tool-installer.nvim" },
  config = function()
    local mason_lspconfig = require("mason-lspconfig")
    local mason = require("mason")

    mason.setup({
      ui = {
        border = "rounded",
      },
    })

    mason_lspconfig.setup({
      -- list of servers for mason to install
      ensure_installed = {
        "ts_ls",
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "emmet_ls",
        "gopls",
        "pyright",
        "sqlls",
        "svelte",
        "rust_analyzer",
        "mdx_analyzer",
        "nil_ls",
        "clangd",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    })

    require("mason-tool-installer").setup({
      ensure_installed = {
        "prettier",
        "stylelint",
        "eslint_d",
        "prettierd",
        "goimports",
        "pylint",
      },
    })
  end,
}

return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "hrsh7th/cmp-nvim-lsp",
    { "antosha417/nvim-lsp-file-operations", config = true },
    {
      "mrcjkb/rustaceanvim",
      version = "^4", -- Recommended
      ft = { "rust" },
    },
  },
  config = function()
    local cmp_nvim_lsp = require("cmp_nvim_lsp")
    local keymap = vim.keymap

    local on_attach = function(client, bufnr)
      local opts = { noremap = true, silent = true, buffer = bufnr }

      -- set keybinds
      keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts) -- go to definition
      keymap.set("n", "K", function()
        vim.lsp.buf.hover({
          border = "rounded",
          max_width = 100,
          max_height = 15,
        })
      end, opts)                                                  -- show definition

      keymap.set("n", "gl", vim.diagnostic.open_float, opts)      -- show diagnostics
      keymap.set("n", "gf", vim.lsp.buf.references, opts)         -- show references
      keymap.set("n", "<leader>C", vim.lsp.buf.code_action, opts) -- code actions
      keymap.set("v", "<leader>R", vim.lsp.buf.rename, opts)      -- rename everywhere
    end

    local capabilities = cmp_nvim_lsp.default_capabilities()

    -- Rust configuration
    vim.g.rustaceanvim = {
      tools = {},
      server = {
        on_attach = on_attach,
        default_settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              enable = true,
            },
            checkOnSave = {
              command = "clippy",
            },
          },
        },
      },
      dap = {},
    }

    -- Configure each server
    vim.lsp.config("html", {
      capabilities = capabilities,
      on_attach = on_attach,
      filetype = { "html", "tmpl", "gotmpl" },
    })

    vim.lsp.config("gopls", {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { "gopls", "--remote=auto" },
    })

    vim.lsp.config("sqlls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.lsp.config("ts_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.lsp.config("cssls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.lsp.config("tailwindcss", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.lsp.config("emmet_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
      filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "svelte" },
    })

    vim.lsp.config("svelte", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.lsp.config("nil_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.lsp.config("mdx_analyzer", {
      capabilities = capabilities,
      on_attach = on_attach,
      root_dir = function(fname)
        return vim.fs.find(".git", { path = vim.fs.dirname(fname), upward = true })[1] or vim.fs.dirname(fname)
      end,
    })

    vim.lsp.config("lua_ls", {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = {
              [vim.fn.expand("$VIMRUNTIME/lua")] = true,
              [vim.fn.stdpath("config") .. "/lua"] = true,
            },
          },
        },
      },
    })

    vim.lsp.config("pyright", {
      capabilities = capabilities,
      on_attach = on_attach,
    })

    vim.lsp.config("clangd", {
      capabilities = capabilities,
      on_attach = on_attach,
      cmd = { "clangd", "--fallback-style=Google" },
      filetypes = { "c", "cpp" },
      single_file_support = true,
    })

    -- Enable all LSP servers after configuration
    vim.lsp.enable({
      "html",
      "gopls",
      "sqlls",
      "ts_ls",
      "cssls",
      "tailwindcss",
      "emmet_ls",
      "svelte",
      "mdx_analyzer",
      "lua_ls",
      "pyright",
      "nil_ls",
      "clangd"
    })
  end,
}

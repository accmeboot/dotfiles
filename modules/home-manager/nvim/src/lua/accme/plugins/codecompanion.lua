return {
  "olimorris/codecompanion.nvim",
  opts = {
    adapters = {
      http = {
        azure_openai = function()
          return require("codecompanion.adapters").extend("azure_openai", {
            env = {
              api_key = "cmd:echo $AZURE_OPENAI_API_KEY",
              endpoint = "cmd:echo $AZURE_URL",
            },
            schema = {
              model = {
                default = "gpt-4o",
              },
            },
          })
        end,
        ollama = function()
          return require("codecompanion.adapters").extend("ollama", {
            schema = {
              model = {
                default = "codellama",
              },
            },
          })
        end,
        anthropic = function()
          return require("codecompanion.adapters").extend("anthropic", {
            schema = {
              model = {
                default = "claude-sonnet-4-20250514",
              },
            },
            env = {
              api_key = "cmd:echo $ANTHROPIC_API_KEY",
            },
          })
        end,
      },
    },
    strategies = {
      chat = {
        adapter = "anthropic",
      },
      inline = {
        adapter = "anthropic",
      },
      cmd = {
        adapter = "anthropic",
      },
    },
    display = {
      chat = {
        window = {
          width = 0.30,
        },
      },
      diff = {
        enabled = true,
        provider = "inline",
        provider_opts = {
          -- Options for inline diff provider
          inline = {
            layout = "buffer", -- float|buffer - Where to display the diff
          },
        },
      },
    },

    extensions = {
      history = {
        enable = true,
      },

      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          show_result_in_chat = true, -- Show mcp tool results in chat
          make_vars = true,           -- Convert resources to #variables
          make_slash_commands = true, -- Add prompts as /slash commands
        },
      },
    },
  },
  init = function()
    vim.keymap.set("n", "<leader>cc", ":CodeCompanionChat toggle<CR>")
    vim.keymap.set("n", "<leader>ca", ":Telescope codecompanion<CR>")
    vim.keymap.set("n", "<leader>ch", ":CodeCompanionHistory<CR>")
  end,
  dependencies = {
    "ravitemer/codecompanion-history.nvim",
    {
      "ravitemer/mcphub.nvim",
      build = "bundled_build.lua",
      opts = {
        use_bundled_binary = true,
      },
    },
  },
}

return {
  "olimorris/codecompanion.nvim",
  opts = {
    strategies = {
      chat = {
        adapter = {
          name = "anthropic",
          model = "claude-sonnet-4-20250514",
        },
        env = {
          api_key = "cmd:echo $ANTHROPIC_API_KEY",
        },
      },
      inline = {
        adapter = {
          name = "anthropic",
          model = "claude-sonnet-4-20250514",
        },
        env = {
          api_key = "cmd:echo $ANTHROPIC_API_KEY",
        },
      },
      cmd = {
        adapter = {
          name = "anthropic",
          model = "claude-sonnet-4-20250514",
        },
        env = {
          api_key = "cmd:echo $ANTHROPIC_API_KEY",
        },
      }
    },
    display = {
      chat = {
        window = {
          width = 0.30,
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
        }
      }
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

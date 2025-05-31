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
      diff = {
        enabled = true,
        close_chat_at = 240,    -- Close an open chat buffer if the total columns of your display are less than...
        layout = "horizontal",  -- vertical|horizontal split for default provider
        opts = { "internal", "filler", "closeoff", "algorithm:patience", "followwrap", "linematch:120" },
        provider = "mini_diff", -- default|mini_diff
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
    local spinner = require("accme.local.codecompanion-spinner")

    -- Setup the autocmd detection
    spinner.setup_status()

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
    {
      "echasnovski/mini.diff",
      config = function()
        local diff = require("mini.diff")
        diff.setup({
          -- Disabled by default
          source = diff.gen_source.none(),
        })
      end,
    },
  },
}

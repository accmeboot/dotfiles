return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local action_state = require("telescope.actions.state")

    local custom_actions = {}

    function custom_actions.fzf_multi_select(prompt_bufnr)
      local function get_table_size(t)
        local count = 0
        for _ in pairs(t) do
          count = count + 1
        end
        return count
      end

      local picker = action_state.get_current_picker(prompt_bufnr)
      local num_selections = get_table_size(picker:get_multi_selection())

      if num_selections > 1 then
        actions.send_selected_to_qflist(prompt_bufnr)
        actions.open_qflist()
      else
        actions.file_edit(prompt_bufnr)
      end
    end

    telescope.setup({
      pickers = {
        find_files = {
          hidden = true,
        },
        grep_string = {
          additional_args = { "--hidden" },
        },
        live_grep = {
          additional_args = { "--hidden" },
        },
      },
      defaults = {
        sorting_strategy = "ascending",
        results_title = false,
        layout_strategy = "vertical",
        layout_config = {
          prompt_position = "top",
          mirror = true,
          height = 0.6,
          width = 0.6,
          anchor = "CENTER",
        },
        mappings = {
          i = {
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-j>"] = actions.move_selection_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
          n = {
            ["<cr>"] = custom_actions.fzf_multi_select,
          },
        },
        file_ignore_patterns = { "node_modules", ".git/" },
      },
    })

    telescope.load_extension("fzf")
    telescope.load_extension("ui-select")

    -- telescope --
    vim.keymap.set("n", "<leader>tf", "<cmd>Telescope find_files<cr>")
    vim.keymap.set("n", "<leader>ts", "<cmd>Telescope live_grep<cr>")
    vim.keymap.set("n", "<leader>tw", "<cmd>Telescope grep_string<cr>")
    vim.keymap.set("n", "<leader>tb", "<cmd>Telescope buffers<cr>")
    vim.keymap.set("n", "<leader>th", "<cmd>Telescope help_tags<cr>")
    vim.keymap.set("n", "<leader>tr", "<cmd>Telescope resume<cr>")
    vim.keymap.set("n", "<leader>tc", "<cmd>Telescope commands<cr>")

    vim.keymap.set("n", "<leader>tgb", "<cmd>Telescope git_branches<cr>")
    vim.keymap.set("n", "<leader>tgc", "<cmd>Telescope git_commits<cr>")
  end,
}

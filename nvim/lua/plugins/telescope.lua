return {
	{
		"nvim-telescope/telescope-ui-select.nvim",
		require("telescope").setup({}),
	},
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			-- local builtin = require("telescope.builtin")
			local telescope = require("telescope")
			-- local actions = require("telescope.actions")
      -- require("telescope").load_extension("noice")
      -- require("telescope").load_extension('harpoon')
      telescope.setup({
        defaults = {
          -- `hidden = true` is not supported in text grep commands.
          path_display = { "truncate" },
          mappings = {
            n = {
              ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
            },
            i = {
              ["<C-j>"] = actions.cycle_history_next,
              ["<C-k>"] = actions.cycle_history_prev,
              ["<C-w>"] = actions.send_selected_to_qflist + actions.open_qflist,
              ["<C-S-d>"] = actions.delete_buffer,
              ["<C-s>"] = actions.cycle_previewers_next,
              ["<C-a>"] = actions.cycle_previewers_prev,
            },
          },
        },
      })
      vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
      vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
    end,
  },
}

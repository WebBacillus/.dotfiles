return {
  -- 1. Define the main Telescope plugin first
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8", -- It's good practice to pin a version
    dependencies = {
      "nvim-lua/plenary.nvim", -- Plenary is a mandatory dependency for Telescope
      "nvim-telescope/telescope-ui-select.nvim", -- Make ui-select a dependency here, or define it separately below
    },
    config = function()
      -- Require Telescope and its submodules
      local telescope = require("telescope")
      local builtin = require("telescope.builtin")
      local actions = require("telescope.actions")
      -- local action_state = require("telescope.actions.state") -- Uncomment if you need this for custom actions

      -- Set up Telescope itself
      telescope.setup({
        defaults = {
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
        -- Configure extensions directly here or within their own config functions
        extensions = {
          ["ui-select"] = {
            -- Example: use dropdown theme for ui-select
            require("telescope.themes").get_dropdown({
              -- theme_config = {
              --   border = true,
              --   prompt_title = "Select",
              --   results_title = "Options",
              -- },
            }),
          },
          -- Uncomment these if you have them installed and configured
          -- noice = {
          --   -- Configuration for noice extension
          -- },
          -- harpoon = {
          --   -- Configuration for harpoon extension
          -- },
        },
      })

      -- Load Telescope extensions
      -- Ensure you load extensions *after* telescope.setup()
      telescope.load_extension("ui-select")
      -- telescope.load_extension("noice") -- Uncomment if you need this
      -- telescope.load_extension("harpoon") -- Uncomment if you need this

      -- Set your keymaps
      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "[F]ind [F]iles" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "[F]ind [G]rep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "[F]ind [B]uffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "[F]ind [H]elp Tags" })
      -- Example of using ui-select with a builtin picker:
      vim.keymap.set("n", "<leader>ss", function()
        builtin.lsp_references({
          -- This tells Telescope to use the ui-select extension's picker
          -- theme and actions for lsp_references
          theme = "dropdown", -- Or any other theme you prefer
          -- Other options can be passed here
        })
      end, { desc = "[S]earch LSP [S]references (UI-Select)" })
    end,
  },

  -- 2. Define telescope-ui-select.nvim as a separate plugin (optional, but good practice)
  --    If you made it a dependency in the main telescope block, this separate entry
  --    might not be strictly necessary if you don't have a separate config for it.
  --    However, explicitly defining it here ensures it's managed as its own plugin.
  {
    "nvim-telescope/telescope-ui-select.nvim",
    -- No config needed here if you load its extension in the main telescope config.
    -- If you wanted a dedicated config for ui-select, you could put it here,
    -- but usually loading the extension in the main telescope config is sufficient.
  },

  -- Ensure plenary.nvim is also managed as a plugin, though it's often implicitly handled
  -- if it's a dependency of another plugin like Telescope.
  -- { "nvim-lua/plenary.nvim" },
}

return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        -- ensure_installed = { "lua_ls", "gopls" },
        automatic_installation = true,
      })
    end
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      -- local on_attach = function(client, bufnr)
      --   vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
      --     vim.lsp.handlers.hover,
      --     {
      --       border = "rounded", -- Optional: Add a border for better visibility
      --       focusable = false,  -- Prevent the documentation window from taking focus
      --     }
      --   )
      -- end,
      require("lspconfig").lua_ls.setup({})
      require("lspconfig").gopls.setup({})
      require("lspconfig").eslint.setup({
        capabilities = capabilities,
      })
      require("lspconfig").ts_ls.setup({
        capabilities = capabilities,
        -- on_attach = on_attach,
        settings = {
          completions = {
            completeFunctionCalls = true
          }
        },
        init_options = {
          preferences = {
            disableSuggestions = true
          }
        }
      })
      require("lspconfig").clangd.setup({
        capabilities = capabilities,
      })
      -- require('lspconfig').dartls.setup({
      --   capabilities = capabilities,
      -- })
      -- -- require('lspconfig').dcm.setup({})
      vim.keymap.set({'n', 'v', }, '<leader>ca', vim.lsp.buf.code_action, {})
      vim.keymap.set('n', 'K' , vim.lsp.buf.hover, {})
    end
  }
}

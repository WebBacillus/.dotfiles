return {
  {
    "hrsh7th/cmp-nvim-lsp",
    'windwp/nvim-autopairs',
  },
  {
    'L3MON4D3/LuaSnip',
    dependencies = {
      'saadparwaiz1/cmp_luasnip',
      "rafamadriz/friendly-snippets"
    },
    config = function()
      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      ls.add_snippets("cpp", {
        s("inc", {
          t('#include<bits/stdc++.h>'),
          t({'', '', ''}),
          t('using namespace std;'),
          t({'', '', ''}),
          t({'int main () {', '\t'}),
          i(0),
          t({
            '',
            '\treturn 0;',
            '}',
          }),
        }),
        s("leet", {
          t('#include<bits/stdc++.h>'),
          t({'', '', ''}),
          t('using namespace std;'),
          t({'', '', ''}),
          i(0),
          t({'', '', ''}),
          t({'int main () {', '\t'}),
          t({
            '',
            '\treturn 0;',
            '}',
          }),

        }),


      })
    end
  },
  {
    -- 'akinsho/flutter-tools.nvim',
    -- lazy = false,
    -- dependencies = {
    --   'nvim-lua/plenary.nvim',
    --   'stevearc/dressing.nvim', -- optional for vim.ui.select
    -- },
    -- config = function()
    --   require("flutter-tools").setup({})
    -- end
  },
  {
    'hrsh7th/nvim-cmp',
    config = function()
      local cmp = require('cmp')
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load({ paths = vim.fn.stdpath("config") .. "/snippets/" })
      require("nvim-autopairs").setup {}

      cmp.setup({
        snippet = {
          -- REQUIRED - you must specify a snippet engine
          expand = function(args)
            -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
            require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
            -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
            -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
            -- vim.snippet.expand(args.body) -- For native neovim snippets (Neovim v0.10+)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ['<C-Space>'] = cmp.mapping.complete(),
          -- ['<C-c>'] = cmp.mapping.abort(),
          ['<Tab>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          -- { name = 'vsnip' }, -- For vsnip users.
          { name = 'luasnip' }, -- For luasnip users.
          -- { name = 'ultisnips' }, -- For ultisnips users.
          -- { name = 'snippy' }, -- For snippy users.
          { name = 'path' },
          { name = 'buffer' },
        })
      })
    end
  }
}

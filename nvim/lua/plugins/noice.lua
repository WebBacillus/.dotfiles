return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    cmdline = {
        view = "cmdline",
      },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    -- "rcarriga/nvim-notify",
  },
  config = function()
    require("noice").setup({})
  end
}

return {
  "kawre/leetcode.nvim",
  build = ":TSUpdate html, python", -- if you have `nvim-treesitter` installed
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
  },
  opts = {
    lang = "python3",
  },
}

return {
  "sainnhe/gruvbox-material",
  lazy = false, -- Load immediately so it's available for setting the colorscheme
  priority = 1000, -- Ensure it loads before others
  config = function()
    vim.g.gruvbox_material_enable_italic = true
    vim.g.gruvbox_material_background = "medium"
    vim.cmd.colorscheme "gruvbox-material"
  end,
}

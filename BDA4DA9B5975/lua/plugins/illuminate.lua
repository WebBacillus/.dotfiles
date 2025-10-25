return {
  "RRethy/vim-illuminate",
  config = function()
    require('illuminate').configure({
      under_cursor = false,
    })
    vim.keymap.set("n", "]]", function()
      require("illuminate").goto_next_reference()
    end)
    vim.keymap.set("n", "[[", function()
      require("illuminate").goto_prev_reference()
    end)
  end
}

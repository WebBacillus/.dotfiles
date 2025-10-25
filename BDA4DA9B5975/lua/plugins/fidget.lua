return {
  "j-hui/fidget.nvim",
  config = function()

    local fidget = require("fidget") -- Load the fidget module

    fidget.setup({
      notification = {
        window = {
          winblend = 0,
        }
      }
    }) -- Set up fidget with default options
 end
}

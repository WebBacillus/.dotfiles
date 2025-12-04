local dap = require "dap"

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug File",
    request = "launch",
    program = "${file}",
    -- cwd = "${fileDir}",
  },
}
return {
  "jay-babu/mason-nvim-dap.nvim",
  opts = {
    ensure_installed = { "delve" },
  },
}

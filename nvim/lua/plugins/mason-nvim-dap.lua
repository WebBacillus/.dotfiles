local dap = require "dap"

dap.configurations.go = {
  {
    type = "delve",
    name = "Debug File",
    request = "launch",
    program = "${file}",
    cwd = "${workspaceFolder}",
    -- cwd = "${fileDirname}",
  },
}

for _, language in ipairs { "typescript", "javascript", "typescriptreact", "javascriptreact" } do
  dap.configurations[language] = {
    {
      type = "pwa-node",
      request = "launch",
      name = "Next.js: debug server-side",
      cwd = "${workspaceFolder}",
      runtimeExecutable = "npm",
      runtimeArgs = { "run-script", "dev" },
      skipFiles = { "<node_internals>/**" },
      console = "integratedTerminal",
    },
  }
end

return {
  "jay-babu/mason-nvim-dap.nvim",
  opts = {
    ensure_installed = { "delve", "js-debug-adapter" },
  },
}

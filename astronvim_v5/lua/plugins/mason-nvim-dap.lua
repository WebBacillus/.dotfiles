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
  opts = function(_, opts)
    opts.ensure_installed = vim.tbl_deep_extend("force", opts.ensure_installed, { "python-debugpy", "delve" })
    if not opts.handlers then opts.handlers = {} end
    vim.tbl_deep_extend("force", opts.handlers, {
      python = function(config)
        config.adapters = {
          type = "executable",
          command = "python",
          args = { "-m", "debugpy.adapter" },
        }
        return config
      end,
      delve = function(config)
        config.adapters = {
          type = "executable",
          command = vim.fn.exepath "dlv",
          args = { "dap" },
        }
        return config
      end,
    })
  end,
}

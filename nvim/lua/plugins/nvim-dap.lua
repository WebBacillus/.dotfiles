return {
  {
    "julianolf/nvim-dap-lldb",
    dependencies = { "mfussenegger/nvim-dap" },
    opts = { codelldb_path = "/home/webbalaka/.local/share/nvim/mason/bin/codelldb" },
  },
  {
    "williamboman/mason.nvim",
    "mfussenegger/nvim-dap",
    "jay-babu/mason-nvim-dap.nvim",
    opts = {
      handlers = {}
    },
    config = function()
      require("mason").setup()
      require("mason-nvim-dap").setup()
    end
  },
  {
    "mfussenegger/nvim-dap",
    -- "rcarriga/nvim-dap-ui",
    -- event = "VeryLazy",
    dependencies = {"rcarriga/nvim-dap-ui", "nvim-neotest/nvim-nio"},
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dap.adapters.lldb = {
        type = 'executable',
        command = '/home/webbalaka/.local/share/nvim/mason/bin/codelldb', -- adjust as needed, must be absolute path
        name = 'lldb'
      }

      dap.configurations.cpp = {
        {
          name = 'Launch',
          type = 'lldb',
          request = 'launch',
          program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = '${workspaceFolder}',
          -- terminal = 'integrated'
          stopOnEntry = false,
          args = {},

          -- 💀
          -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
          --
          --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
          --
          -- Otherwise you might get the following error:
          --
          --    Error on launch: Failed to attach to the target process
          --
          -- But you should be aware of the implications:
          -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
          -- runInTerminal = false,
        },
      }

      dapui.setup()
      dap.listeners.before.attach.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.launch.dapui_config = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated.dapui_config = function()
        dapui.close()
      end
      dap.listeners.before.event_exited.dapui_config = function()
        dapui.close()
      end
    end
  },
}

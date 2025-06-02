return {
  "mfussenegger/nvim-dap",
  config = function()
    local dap = require("dap")

    -- lldb configuration
    dap.adapters.lldb = {
      type = "executable",
      command = "/usr/bin/lldb",
      name = "lldb",
    }

    dap.configurations.cpp = {
      name = "Launch",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
      end,
      cwd = "${workspaceFolder}",
      stopOnEntry = false,
      args = {},
    }

    dap.configurations.c = dap.configurations.cpp
  end,
}

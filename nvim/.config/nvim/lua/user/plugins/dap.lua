return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")
    local widgets = require("dap.ui.widgets")

    -- used for debugging tests
    dap.adapters.coreclr = {
      type = "executable",
      command = "netcoredbg",
      args = { "--interpreter=vscode" },
    }

    dap.adapters.netcoredbg = {
      type = "executable",
      command = "netcoredbg",
      args = { "--interpreter=vscode" },
    }

    dap.configurations.cs = {
      {
        type = "netcoredbg",
        name = "Attach to Process",
        request = "attach",
        processId = function()
          return require("dap.utils").pick_process()
        end,
      },
      {
        type = "netcoredbg",
        name = "Launch .NET Application",
        request = "launch",
        program = function()
          return vim.fn.input("Path to dll: ", vim.fn.getcwd() .. "/bin/Debug/", "file")
        end,
      },
    }

    dapui.setup()

    vim.keymap.set("n", "<F5>", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<F8>", dap.step_over, { desc = "Debug: Step Over" })
    vim.keymap.set("n", "<F7>", dap.step_into, { desc = "Debug: Step Into" })
    vim.keymap.set("n", "<F12>", dap.step_out, { desc = "Debug: Step Out" })

    vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
    vim.keymap.set("n", "<leader>B", function()
      dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Debug: Set Breakpoint" })

    vim.keymap.set("n", "<leader>ds", dap.continue, { desc = "Debug: Start/Continue" })
    vim.keymap.set("n", "<leader>dc", dap.terminate, { desc = "Debug: Stop" })
    vim.keymap.set("n", "<leader>dn", dap.run_to_cursor, { desc = "Debug: Run to Cursor" })
    vim.keymap.set("n", "<leader>dR", dap.clear_breakpoints, { desc = "Debug: Clear Breakpoints" })
    vim.keymap.set("n", "<leader>de", function()
      dap.set_exception_breakpoints({ "all" })
    end, { desc = "Debug: Set Exception Breakpoints" })

    vim.keymap.set("n", "<leader>di", widgets.hover, { desc = "Debug: Inspect" })
    vim.keymap.set("n", "<leader>d?", function()
      widgets.centered_float(widgets.scopes)
    end)

    vim.keymap.set("n", "<leader>dk", ':lua require"dap".up()<CR>zz')
    vim.keymap.set("n", "<leader>dj", ':lua require"dap".down()<CR>zz')
    vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })

    dap.listeners.after.event_initialized["dapui_config"] = function()
      vim.schedule(function()
        dapui.open()
      end)
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end
  end,
}

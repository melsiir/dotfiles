return {
  -- Debug Adapter Protocol client implementation for Neovim
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      -- A UI for nvim-dap
      {
        "rcarriga/nvim-dap-ui",
        dependencies = {
          "nvim-neotest/nvim-nio",
        },
        -- stylua: ignore
        keys = {
          { "<leader>du", function() require("dapui").toggle({}) end, desc = "Dap UI", },
          { "<leader>de", function() require("dapui").eval() end,     desc = "Eval",   mode = { "n", "v" }, },
        },
        config = function()
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup({
            controls = {
              element = "repl",
              enabled = true,
              icons = {
                disconnect = " ",
                pause = " ",
                play = " ",
                run_last = " ",
                step_back = " ",
                step_into = " ",
                step_out = " ",
                step_over = " ",
                terminate = " ",
              },
            },
          })
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open()
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close()
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close()
          end
        end,
      },
      -- virtual text for the debugger
      {
        "theHamsta/nvim-dap-virtual-text",
        opts = {},
      },
    },
    -- stylua: ignore
    config = function()
      vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })
      vim.fn.sign_define("DapStopped", { text = "󰁕 ", texthl = "DiagnosticWarn", linehl = "DapStoppedLine", numhl = "" })
      vim.fn.sign_define("DapBreakpoint", { text = " ", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = " ", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointRejected", { text = " ", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
      vim.fn.sign_define("DapLogPoint", { text = " ", texthl = "DiagnosticInfo", linehl = "", numhl = "" })
    end,
    -- stylua: ignore
    keys = {
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end,        desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end,                                           desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,                                                    desc = "Continue" },
      { "<leader>dl", function() require("dap").set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) end, desc = "Set Log Point" },
      { "<leader>dC", function() require("dap").run_to_cursor() end,                                               desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end,                                                       desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end,                                                   desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end,                                                        desc = "Down" },
      { "<leader>dk", function() require("dap").up() end,                                                          desc = "Up" },
      { "<leader>do", function() require("dap").step_out() end,                                                    desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end,                                                   desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end,                                                       desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end,                                                 desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end,                                                     desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end,                                                   desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end,                                            desc = "Widgets" },
      { "<leader>dR", function() require("dap").clear_breakpoints() end,                                           desc = "Removes all breakpoints" },
    },
  },
  -- mason.nvim integration
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = "mason.nvim",
    cmd = { "DapInstall", "DapUninstall" },
    opts = {
      -- Makes a best effort to setup the various debuggers with
      -- reasonable debug configurations
      automatic_installation = true,

      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},

      -- You'll need to check that you have the required things installed
      -- online, please don't ask me how to install them :)
      ensure_installed = {
        -- Update this to ensure that you have the debuggers for the langs you want
      },
    },
    -- mason-nvim-dap is loaded when nvim-dap loads
    config = function() end,
  },

}


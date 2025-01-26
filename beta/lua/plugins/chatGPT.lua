return {
  {
    "jackMort/ChatGPT.nvim",
    lazy = true,
    cmd = { "ChatGPT", "ChatGPTActAs", "ChatGPTEditWithInstructions" },
    config = function()
      local home = vim.fn.expand("$HOME")
      local border = { style = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }, highlight = "PickerBorder" }
      require("chatgpt").setup({
        api_key_cmd = "cat " .. home .. "/.secrets/openai",
        model = "gpt-3.5-turbo",
        popup_window = { border = border },
        popup_input = { border = border, submit = "<C-s>" },
        settings_window = { border = border },
        chat = {
          keymaps = {
            close = {
              "<C-c>", --[[ , '<Esc>' ]]
            },
          },
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
  {

    "folke/which-key.nvim",
    optional = true,
    config = function()
      local wk = require("which-key")
      local chatgpt = require("chatgpt")
      wk.register({
        c = {
          name = "ChatGPT",
          c = { "<cmd>ChatGPT<CR>", "ChatGPT" },
          e = { "<cmd>ChatGPTEditWithInstruction<CR>", "Edit with instruction", mode = { "n", "v" } },
          g = { "<cmd>ChatGPTRun grammar_correction<CR>", "Grammar Correction", mode = { "n", "v" } },
          t = { "<cmd>ChatGPTRun translate<CR>", "Translate", mode = { "n", "v" } },
          k = { "<cmd>ChatGPTRun keywords<CR>", "Keywords", mode = { "n", "v" } },
          d = { "<cmd>ChatGPTRun docstring<CR>", "Docstring", mode = { "n", "v" } },
          a = { "<cmd>ChatGPTRun add_tests<CR>", "Add Tests", mode = { "n", "v" } },
          o = { "<cmd>ChatGPTRun optimize_code<CR>", "Optimize Code", mode = { "n", "v" } },
          s = { "<cmd>ChatGPTRun summarize<CR>", "Summarize", mode = { "n", "v" } },
          f = { "<cmd>ChatGPTRun fix_bugs<CR>", "Fix Bugs", mode = { "n", "v" } },
          x = { "<cmd>ChatGPTRun explain_code<CR>", "Explain Code", mode = { "n", "v" } },
          r = { "<cmd>ChatGPTRun roxygen_edit<CR>", "Roxygen Edit", mode = { "n", "v" } },
          l = { "<cmd>ChatGPTRun code_readability_analysis<CR>", "Code Readability Analysis", mode = { "n", "v" } },
        },
      })
    end,
  },
}

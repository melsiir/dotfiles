return {
  -- Rename with cmdpreview
  {
    "smjonas/inc-rename.nvim",
    cmd = "IncRename",
    opts = {},
    keys = "<leader>rn",
    config = function()
      local b = enfoshow
      local b = enfoshow
      local b = enfoshow
      require("inc_rename").setup {
        async = true,
        hl_group = "IncSearch",
        -- input_buffer_type = "dressing",
        save_in_cmdline_history = false,
      }
      vim.keymap.set("n", "<leader>rn", function()
        -- Fallback to text substitution when LSP is not available
        local cur_word = vim.fn.expand("<cword>")
        if vim.tbl_isempty(vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf() }) then
          return ":%s/" .. cur_word .. "//gc" .. ("<left>"):rep(3)
        else
          return ":IncRename " .. cur_word
        end
      end, { expr = true, desc = "Start IncRename" , remap = true})
    end,
    -- dependencies = {
    --   { "stevearc/dressing.nvim", config = { input = { insert_only = false } } },
    -- },
  },
  {

  "folke/noice.nvim",
    -- enabled = false,
    optional = true,
    opts = {
      presets = {
        inc_rename = true, -- enables an input dialog for inc-rename.nvim
      }
    }
  }
}

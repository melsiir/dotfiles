-- LazyVim.on_very_lazy(function()
--   vim.filetype.add({
--     extension = { mdx = "markdown.mdx" },
--   })
-- end)
return {
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters = {
        ["markdown-toc"] = {
          condition = function(_, ctx)
            for _, line in ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false)) do
              if line:find("<!%-%- toc %-%->") then
                return true
              end
            end
          end,
        },
        ["markdownlint-cli2"] = {
          condition = function(_, ctx)
            local diag = vim.tbl_filter(function(d)
              return d.source == "markdownlint"
            end, vim.diagnostic.get(ctx.buf))
            return #diag > 0
          end,
        },
      },
      formatters_by_ft = {
        ["markdown"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
        ["markdown.mdx"] = { "prettier", "markdownlint-cli2", "markdown-toc" },
      },
    },
  },
  {
    "williamboman/mason.nvim",
    opts = { ensure_installed = { "markdownlint-cli2", "markdown-toc" } },
  },
  {
    "nvimtools/none-ls.nvim",
    optional = true,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.diagnostics.markdownlint_cli2,
      })
    end,
  },
  {
    "mfussenegger/nvim-lint",
    optional = true,
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint-cli2" },
      },
    },
  },
  -- {
  --   "neovim/nvim-lspconfig",
  --   opts = {
  --     servers = {
  --       marksman = {},
  --     },
  --   },
  -- },
  --
  {
    "MeanderingProgrammer/render-markdown.nvim",
    enabled = true,
    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
    },
    ft = { "markdown", "norg", "rmd", "org" },
  },
  -- {
  --   "OXY2DEV/markview.nvim",
  --   ft = "markdown",
  --   config = function()
  --     local presets = require("markview.presets")
  --
  --     local checkbox = presets.checkboxes.nerd
  --
  --     checkbox.custom = vim.tbl_extend("force", checkbox.custom, {
  --       { match_string = "-", text = "", hl = "MarkviewCheckboxPending" },
  --       { match_string = "~", text = "", hl = "MarkviewCheckboxProgress" },
  --       { match_string = "/", text = " ", hl = "MarkdownCheckboxSkipped" },
  --       { match_string = "f", text = "󰈸 ", hl = "MarkdownCheckboxFire" },
  --       { match_string = "s", text = " ", hl = "MarkdownCheckboxStar" },
  --       { match_string = "*", text = "󰌵 ", hl = "MarkdownCheckboxIdea" },
  --       { match_string = "y", text = "󰔓 ", hl = "MarkdownCheckboxYes" },
  --       { match_string = "n", text = "󰔑 ", hl = "MarkdownCheckboxNo" },
  --       { match_string = "?", text = " ", hl = "MarkdownCheckboxQuestion" },
  --       { match_string = "i", text = " ", hl = "MarkdownCheckboxInfo" },
  --       { match_string = "!", text = "󱅶 ", hl = "MarkdownCheckboxImportant" },
  --     })
  --
  --     require("markview").setup({
  --       modes = { "n", "i", "v", "V", "c", "nc" },
  --       hybrid_modes = { "i" },
  --
  --       filetypes = { "markdown", "quarto", "rmd", "Avante" },
  --       checkboxes = checkbox,
  --       headings = presets.headings.decorated,
  --       code_blocks = {
  --         style = "language",
  --         icons = "mini",
  --
  --         language_direction = "right",
  --         min_width = 60,
  --         pad_char = " ",
  --         pad_amount = 3,
  --
  --         language_names = {
  --           ["txt"] = "Text",
  --         },
  --
  --         hl = "MarkviewCode",
  --         info_hl = "MarkviewCodeInfo",
  --
  --         sign = true,
  --         sign_hl = nil,
  --       },
  --       horizontal_rules = presets.horizontal_rules.thin,
  --     })
  --   end,
  -- },
  {
    "renerocksai/telekasten.nvim",
    -- enabled = false,
    -- cond = require("config").config_type ~= "minimal",
    dependencies = {},
    -- stylua: ignore
    keys = {
      { mode = { "n" }, "<leader>z",  "<cmd>Telekasten panel<CR>",                   { desc = "Show Telekasten panel" } },
      { mode = { "n" }, "<leader>zf", "<cmd>Telekasten find_notes<CR>",              { desc = "Find notes" } },
      { mode = { "n" }, "<leader>zg", "<cmd>Telekasten search_notes<CR>",            { desc = "Search notes" } },
      { mode = { "n" }, "<leader>zd", "<cmd>Telekasten goto_today<CR>",              { desc = "Go to today" } },
      { mode = { "n" }, "<leader>zz", "<cmd>Telekasten follow_link<CR>",             { desc = "Follow link" } },
      { mode = { "n" }, "<leader>zn", "<cmd>Telekasten new_note<CR>",                { desc = "New note" } },
      { mode = { "n" }, "<leader>zb", "<cmd>Telekasten show_backlinks<CR>",          { desc = "Show backlinks" } },
      { mode = { "n" }, "<leader>zI", "<cmd>Telekasten insert_img_link<CR>",         { desc = "Insert image link" } },
      { mode = { "n" }, "<leader>zr", "<cmd>Telekasten rename_note()<CR>",           { desc = "Rename note" } },
      { mode = { "n" }, "<leader>zp", "<cmd>Telekasten preview_img()<CR>",           { desc = "Preview image" } },
      { mode = { "n" }, "<leader>zm", "<cmd>Telekasten browse_media()<CR>",          { desc = "Browse media" } },
      { mode = { "n" }, "<leader>za", "<cmd>Telekasten show_tags()<CR>",             { desc = "Show tags" } },
      { mode = { "n" }, "<leader>zt", "<cmd>Telekasten toggle_todo({ i=true })<CR>", { desc = "Toggle todo" } },
    },
    opts = {
      home = vim.fn.expand("~/storage/documents/obsidian"),
      auto_set_filetype = false,
      auto_set_syntax = false,
    },
    config = function(_, opts)
      require("telekasten").setup(opts)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "markdown",
        callback = function()
          vim.keymap.set("i", "[[", "<cmd>Telekasten insert_link<CR>")
        end,
      })

      vim.g.vim_markdown_folding_disabled = 1
    end,
  }
  ,
}

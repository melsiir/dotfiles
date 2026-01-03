
return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    dashboard = {
      enabled = false,
      sections = {
        -- { section = "header" },
        { section = "keys", gap = 1, width = 40, indent = 1, },
        -- { section = "startup" },
      },
    },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    scroll = { enabled = false },
    words = { enabled = true },
    animate = { enabled = true },
    terminal = {
      enabled = true,
      animate = {
        enabled = vim.fn.has("nvim-0.10") == 1,
        easing = "linear",
        duration = {
          step = 50,    -- ms per step
          total = 1000, -- maximum duration
        },
      }
    },



    indent = {
      enabled = true,   -- enable indent guides
      indent = {
        enabled = false, -- enable indent guides
        char = "│",
        blank = " ",
        -- blank = "∙",
        only_scope = true,   -- only show indent guides of the scope
        only_current = false, -- only show indent guides in the current window
        hl = "SnacksIndent", ---@type string|string[] hl groups for indent guides
        -- can be a list of hl groups to cycle through
        -- hl = {
        --     "SnacksIndent1",
        --     "SnacksIndent2",
        --     "SnacksIndent3",
        --     "SnacksIndent4",
        --     "SnacksIndent5",
        --     "SnacksIndent6",
        --     "SnacksIndent7",
        --     "SnacksIndent8",
        -- },
      },
      scope = {
        enabled = true, -- enable highlighting the current scope
        -- animate scopes. Enabled by default for Neovim >= 0.10
        -- Works on older versions but has to trigger redraws during animation.
        ---@type snacks.animate.Config|{enabled?: boolean}
        animate = {
          enabled = vim.fn.has("nvim-0.10") == 1,
          easing = "linear",
          duration = {
            step = 50,   -- ms per step
            total = 500, -- maximum duration
          },
        },
        char = "│",
        underline = false,    -- underline the start of the scope
        only_current = false, -- only show scope in the current window
        hl = "SnacksIndentScope", ---@type string|string[] hl group for scopes
      },
      chunk = {
        -- when enabled, scopes will be rendered as chunks, except for the
        -- top-level scope which will be rendered as a scope.
        enabled = true,
        -- only show chunk scopes in the current window
        only_current = false,
        hl = "SnacksIndentChunk", ---@type string|string[] hl group for chunk scopes
        char = {
          -- corner_top = "┌",
          -- corner_bottom = "└",
          corner_top = "╭",
          corner_bottom = "╰",
          horizontal = "─",
          vertical = "│",
          -- arrow = ">",
          arrow = "─",
        },
      },
      blank = {
        char = " ",
        -- char = "·",
        hl = "SnacksIndentBlank", ---@type string|string[] hl group for blank spaces
      },
      -- filter for buffers to enable indent guides
      filter = function(buf)
        return vim.g.snacks_indent ~= false and vim.b[buf].snacks_indent ~= false and vim.bo[buf].buftype == ""
      end,
      priority = 200,
    },
    ---------------
    styles = {
      notification = {
        wo = { wrap = true } -- Wrap notifications
      }
    }

  },
  keys = {
    { "<leader>un", function() Snacks.notifier.hide() end,           desc = "Dismiss All Notifications" },
    { "<leader>bd", function() Snacks.bufdelete() end,               desc = "Delete Buffer" },
    { "<leader>gg", function() Snacks.lazygit() end,                 desc = "Lazygit" },
    { "<leader>gb", function() Snacks.git.blame_line() end,          desc = "Git Blame Line" },
    { "<leader>gB", function() Snacks.gitbrowse() end,               desc = "Git Browse" },
    { "<leader>gf", function() Snacks.lazygit.log_file() end,        desc = "Lazygit Current File History" },
    { "<leader>gl", function() Snacks.lazygit.log() end,             desc = "Lazygit Log (cwd)" },
    { "<leader>cR", function() Snacks.rename.rename_file() end,      desc = "Rename File" },
    { "<c->",       function() Snacks.terminal() end,                desc = "Toggle Terminal" },
    { "<c-_>",      function() Snacks.terminal() end,                desc = "which_key_ignore",            mode = { "n", "t" } },
    { "]]",         function() Snacks.words.jump(vim.v.count1) end,  desc = "Next Reference",              mode = { "n", "t" } },
    { "[[",         function() Snacks.words.jump(-vim.v.count1) end, desc = "Prev Reference",              mode = { "n", "t" } },
    { "<leader>.",  function() Snacks.scratch() end,                 desc = "Toggle Scratch Buffer" },
    { "<leader>S",  function() Snacks.scratch.select() end,          desc = "Select Scratch Buffer" },
    {
      "<leader>N",
      desc = "Neovim News",
      function()
        Snacks.win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = {
            spell = false,
            wrap = false,
            signcolumn = "yes",
            statuscolumn = " ",
            conceallevel = 3,
          },
        })
      end,
    }
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        local Snacks = require("snacks")
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd -- Override print to use snacks for `:=` command

        -- Create some toggle mappings
        Snacks.toggle.option("spell", { name = "Spelling" }):map("<leader>uS")
        Snacks.toggle.option("wrap", { name = "Wrap" }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        -- Snacks.toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel & gt, 0 and vim.o.conceallevel or 2 }):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
      end,
    })
  end,
}

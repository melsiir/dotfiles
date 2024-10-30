return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  -- init = function()
  --   vim.g.lualine_laststatus = vim.o.laststatus
  --   if vim.fn.argc(-1) > 0 then
  --     -- set an empty statusline till lualine loads
  --     vim.o.statusline = " "
  --   else
  --     -- hide the statusline on the starter page
  --     vim.o.laststatus = 0
  --   end
  -- end,

  config = function()
    local isNord = function()
      if vim.g.colors_name == "nord" then
        return true
      else
        return false
      end
    end
    local fg = function(name)
      local color = ccoolor(name)
      return color and { fg = color } or nil
    end
    local ccoolor = function(name, bg)
      ---@type {foreground?:number}?
      ---@diagnostic disable-next-line: deprecated
      local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name, link = false })
        or vim.api.nvim_get_hl_by_name(name, true)
      ---@diagnostic disable-next-line: undefined-field
      ---@type string?
      local color = nil
      if hl then
        if bg then
          color = hl.bg or hl.background
        else
          color = hl.fg or hl.foreground
        end
      end
      return color and string.format("#%06x", color) or nil
    end

    local mode = {
      "mode",
      fmt = function(str)
        return " " .. str
        -- return " " .. str
        -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
      end,
    }

    local hide_in_width = function()
      return vim.fn.winwidth(0) > 80
    end

    local filename = {
      "filename",
      file_status = true, -- displays file status (readonly status, modified status)
      path = 0, -- 0 = just filename, 1 = relative path, 2 = absolute path
      cond = hide_in_width,
    }

    local diagnostics = {
      "diagnostics",
      sources = { "nvim_diagnostic" },
      sections = { "error", "warn" },
      symbols = { error = " ", warn = " ", info = " ", hint = " " },
      colored = not vim.g.colors_name == "nord",
      update_in_insert = false,
      always_visible = false,
      -- cond = hide_in_width,
    }

    local diff = {
      "diff",
      colored = not isNord(),
      symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
      -- cond = hide_in_width,
    }

    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "auto", -- Set theme based on environment variable
        -- Some useful glyphs:
        -- https://www.nerdfonts.com/cheat-sheet
        --           
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "neo-tree" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = { { "branch", icon = "" } },
        lualine_c = { filename },
        lualine_x = { diagnostics, diff, { "encoding", cond = hide_in_width }, { "filetype", cond = hide_in_width } },
        lualine_y = { "location" },
        lualine_z = { "progress" },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { { "location", padding = 0 } },
        lualine_y = {},
        lualine_z = {},
      },
      -- tabline = {},
      -- extensions = { 'fugitive' },
    })
  end,
}

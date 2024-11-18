local function getColor(name, bg)
  local hl = vim.api.nvim_get_hl and vim.api.nvim_get_hl(0, { name = name, link = false })
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

local function fg(name)
  local color = getColor(name)
  return color and { fg = color } or nil
end

local function search_result()
  if vim.v.hlsearch == 0 then
    return ""
  end
  local last_search = vim.fn.getreg("/")
  if not last_search or last_search == "" then
    return ""
  end
  local searchcount = vim.fn.searchcount({ maxcount = 9999 })
  return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function()
    local function get_greeting()
      local tableTime = os.date("*t")
      local hour = tableTime.hour
      local greetingsTable = {
        [1] = "󰙃  Why are you still up, " .. "Mohammed" .. "?",
        [2] = "  Good morning, " .. "Mohammed",
        [3] = "  Good afternoon, " .. "Mohammed",
        [4] = "󰖔  Good evening, " .. "Mohammed",
      }
      local greetingIndex = 0
      if hour >= 23 or hour < 7 then
        greetingIndex = 1
      elseif hour < 12 then
        greetingIndex = 2
      elseif hour >= 12 and hour < 18 then
        greetingIndex = 3
      elseif hour >= 18 and hour < 23 then
        greetingIndex = 4
      end
      return greetingsTable[greetingIndex]
    end

    local function recorder_provider()
      return " " .. " Rec"
    end

    local function isRecording()
      local reg = vim.fn.reg_recording()
      if reg == "" then
        return ""
      end -- not recording
      return " " .. " Rec for " .. reg
      -- return true
    end

    local function recorder_condition()
      local reg = vim.fn.reg_recording()
      if reg == "" then
        return false
      end -- not recording
      return true
    end

    local lsp_progress = require("config.lsp_progress")
    lsp_progress.autocmd()
    local isNord = vim.g.colors_name == "nord"

    local mode = {
      "mode",
      fmt = function(str)
        return " " .. str
        -- return " " .. str
        -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
      end,
      -- color = { gui = "bold" },
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
      colored = not isNord,
      update_in_insert = false,
      always_visible = false,
      -- cond = hide_in_width,
    }

    local diff = {
      "diff",
      colored = not isNord,
      symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
      cond = hide_in_width,
    }

    local angels = {
      sections = { left = "", right = "" },
      component = { left = "", right = "" },
    }

    local halfCircle = {
      sections = { left = "", right = "" },
      component = { left = "", right = "" },
    }

    require("lualine").setup({
      options = {
        icons_enabled = true,
        theme = "auto", -- Set theme based on environment variable
        --           
        section_separators = "",
        component_separators = "",
        -- section_separators = { left = "", right = "" },
        -- component_separators = { left = "", right = "" },
        disabled_filetypes = { "alpha", "neo-tree" },
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { mode },
        lualine_b = {
          { "branch", icon = "" },
        },
        lualine_c = {
          filename,
          {
            isRecording,
            -- recorder_provider,
            -- cond = isRecording,
          },

          {
            function()
              return ""
            end,
            cond = function()
              return vim.fn.mode() == "t"
            end,
          },
        },
        lualine_x = {
          {
            search_result,
            color = fg("DiagnosticVirtualTextInfo"),
          },
          diagnostics,
          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = fg("SpecialComment"),
          },
          diff,
          { "encoding", cond = hide_in_width },
          {
            "filetype",
            cond = hide_in_width,
          },
          {
            function()
              local autoformat = vim.g.autoformat
              return autoformat and "󰚔 on" or "󰚔 off"
            end,
            -- color = "green",
            cond = hide_in_width,
          },
          {
            function()
              return ""
            end,

            cond = function()
              return vim.g.liveserver_bufnr ~= nil
            end,
            -- color = { fg = "#268bd2" },
            color = fg("MiniIconsBlue"),
          },
        },
        lualine_y = { "location" },
        lualine_z = {
          "progress",
          {
            function()
              -- return " "
              return " LSP"
            end,
            cond = function()
              return next(vim.lsp.get_clients()) ~= nil and vim.b.spinner_icon == "󰄬"
            end,
            padding = { right = 1 },
            color = { gui = "bold" },
          },
          { lsp_progress.lsp_progress, padding = 0 },
        },
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

-- return {
--   "rebelot/heirline.nvim",
--   enabled = true,
--   dependencies = { "zeioth/heirline-components.nvim" },
--   event = { "BufReadPost", "BufAdd", "BufNewFile" },
--   opts = function()
--     vim.opt.showtabline = 2
--     vim.opt.laststatus = 3
--     local lib = require("heirline-components.all")
--     return {
--       tabline = { -- UI upper bar
--         lib.component.tabline_conditional_padding(),
--         lib.component.tabline_buffers(),
--         lib.component.fill({ hl = { bg = "tabline_bg" } }),
--         lib.component.tabline_tabpages(),
--       },
--       statusline = { -- UI statusbar
--         hl = { fg = "fg", bg = "bg" },
--         lib.component.mode(),
--         lib.component.git_branch(),
--         lib.component.file_info(),
--         lib.component.git_diff(),
--         lib.component.diagnostics(),
--         lib.component.fill(),
--         lib.component.cmd_info(),
--         lib.component.fill(),
--         lib.component.lsp(),
--         lib.component.virtual_env(),
--         lib.component.nav(),
--         lib.component.mode({ surround = { separator = "right" } }),
--       },
--     }
--   end,
--   config = function(_, opts)
--     local heirline = require("heirline")
--     local heirline_components = require("heirline-components.all")
--
--     -- Setup
--     heirline_components.init.subscribe_to_events()
--     heirline.load_colors(heirline_components.hl.get_colors())
--     heirline.setup(opts)
--   end,
-- }

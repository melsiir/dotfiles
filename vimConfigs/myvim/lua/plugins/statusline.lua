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

local function cwd()
  local dir_name = " " .. vim.fn.fnamemodify(vim.fn.getcwd(), ":t") .. " "
  return dir_name
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
  enabled = true,
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

    local function isRecording()
      local reg = vim.fn.reg_recording()
      if reg == "" then
        return ""
      end -- not recording
      return " " .. " " .. reg
      -- return true
    end

    local lsp_progress = require("config.util.lsp_progress")
    lsp_progress.autocmd()
    local isNord = vim.g.colors_name == "nord"

    local mode = {
      "mode",
      fmt = function(str)
        return " " .. str
        -- return " " .. str
        -- return ' ' .. str:sub(1, 1) -- displays only the first character of the mode
      end,
      color = { gui = "bold" },
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

    local opts = {

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
          {
            cwd,
            cond = function()
              return vim.fn.expand("%:t") ~= "" and vim.fn.winwidth(0) > 80
            end,
            color = fg("special"),
          },
          filename,
          {
            isRecording,
            color = fg("DiagnosticSignError"),
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
            function()
              return "  " .. require("dap").status()
            end,
            cond = function()
              return package.loaded["dap"] and require("dap").status() ~= ""
            end,
            color = function()
              return fg("Debug")
            end,
          },

          {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = fg("special"),
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
            on_click = function()
              vim.g.autoformat = not vim.g.autoformat
            end,
          },
          {
            function()
              return "  "
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
          {
            "progress",
            cond = function()
              return next(vim.lsp.get_clients()) ~= nil and not lsp_progress.is_spinning()
            end,
          },
          {
            function()
              -- return "     "
              return " "
            end,
            cond = function()
              return next(vim.lsp.get_clients()) ~= nil and not lsp_progress.is_spinning()
            end,
            padding = { right = 1 },
            color = { gui = "bold" },
          },
          { lsp_progress.lsp_progress, padding = { left = 1 } },
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
    }

    return opts
  end,
}

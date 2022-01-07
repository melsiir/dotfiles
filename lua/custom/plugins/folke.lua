local function clock()
  return " " .. os.date("%H:%M")
end

local colors = {
  bg       = '#202328',
  fg       = '#bbc2cf',
  yellow   = '#ECBE7B',
  cyan     = '#008080',
  darkblue = '#081633',
  green    = '#98be65',
  orange   = '#FF8800',
  violet   = '#a9a1e1',
  magenta  = '#c678dd',
  blue     = '#51afef',
  red      = '#ec5f67',
}


local vi_mode_colors = {
    NORMAL = colors.green,
    INSERT = colors.red,
    VISUAL = colors.magenta,
    OP = colors.green,
    BLOCK = colors.blue,
    REPLACE = colors.violet,
    ['V-REPLACE'] = colors.violet,
    ENTER = colors.cyan,
    MORE = colors.cyan,
    SELECT = colors.orange,
    COMMAND = colors.green,
    SHELL = colors.green,
    TERM = colors.green,
    NONE = colors.yellow
}



local function holidays()
  return "🎅🎄🌟🎁"
end

local lsp = function()
local msg = ''
    local buf_ft = vim.api.nvim_buf_get_option(0, 'filetype')
    local clients = vim.lsp.get_active_clients()
    if next(clients) == nil then
      return msg
    end
    for _, client in ipairs(clients) do
      local filetypes = client.config.filetypes
      if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
     --   return client.name
          return ''
      end
    end
    return msg
  end


local function lsp_progress(_, is_active)
  if not is_active then
    return
  end
  local messages = vim.lsp.util.get_progress_messages()
  if #messages == 0 then
    return ""
  end
  -- dump(messages)
  local status = {}
  for _, msg in pairs(messages) do
    local title = ""
    if msg.title then
      title = msg.title
    end
    -- if msg.message then
    --   title = title .. " " .. msg.message
    -- end
    table.insert(status, (msg.percentage or 0) .. "%% " .. title)
  end
  local spinners = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners
  return table.concat(status, "  ") .. " " .. spinners[frame + 1]
end

vim.cmd("au User LspProgressUpdate let &ro = &ro")

local config = {
  options = {
  --  theme = "tokyonight",
  theme = {
      -- We are going to use lualine_c an lualine_x as left and
      -- right section. Both are highlighted by c theme .  So we
      -- are just setting default looks o statusline
      normal = { c = { fg = colors.fg, bg = colors.bg } },
      inactive = { c = { fg = colors.fg, bg = colors.bg } },
    },
    -- section_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    -- component_separators = { left  = "", right = "" },
    component_separators = { left = "", right = "" },
    icons_enabled = true,
  },
  sections = {
    lualine_a = {  {'mode', fmt = function(str) return ' ' .. str end} },
    lualine_b = { "branch" },
    lualine_c = {
      { "diagnostics", sources = { "nvim_diagnostic" } },
      -- { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
      -- { "filename", path = 1, symbols = { modified = "  ", readonly = "" } },
      -- {
      --   function()
      --     local gps = require("nvim-gps")
      --     return gps.get_location()
      --   end,
      --   cond = function()
      --     local gps = require("nvim-gps")
      --     return pcall(require, "nvim-treesitter.parsers") and gps.is_available()
      --   end,
      --   color = { fg = "#ff9e64" },
      -- },
    },
    lualine_x = { lsp,  lsp_progress, require("github-notifications").statusline_notification_count },
    lualine_y = {},
    lualine_z = {{'progress', color = { fg = colors.fg }, padding = { left = 0, right = 0} }, "location" },
   --  lualine_z = { clock },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {},
  },
  extensions = { "nvim-tree" },
}

-- try to load matching lualine theme

local M = {}

function M.load()
  local name = vim.g.colors_name or ""
  local ok, _ = pcall(require, "lualine.themes." .. name)
  if ok then
    config.options.theme = name
  end
  require("lualine").setup(config)
end

M.load()

-- vim.api.nvim_exec([[
--   autocmd ColorScheme * lua require("config.lualine").load();
-- ]], false)

return M


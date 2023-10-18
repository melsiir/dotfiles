--
-- ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
-- ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
-- ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
-- ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
-- ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
-- ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
--
-- File: plugins/lualine.lua
-- Description: Pacman config for lualine
-- Author: Kien Nguyen-Tuan <kiennt2609@gmail.com>
-- Credit: shadmansaleh & his evil theme: https://github.com/nvim-lualine/lualine.nvim/blob/master/examples/evil_lualine.lua

local has = vim.fn.has
local is_linux = has "unix"
local is_win = has "win32"

function encoding ()

if is_linux == 1 then
  return ""
end
if is_win == 1 then
  return {"encoding"}
end
end

function fileformat ()

if is_linux == 1 then
  return ""
end
if is_win == 1 then
  return {"fileformat"}
end
end

-- local progress = {
--         "progress",
--         fmt = function()
--           return "%P/%L"
--         end,
--       }

local colors = {
  dark = "#3B4252",
  white = "#E5E8F1",
}
return {{
    -- Statusline
    -- A blazing fast and easy to configure neovim statusline plugin written in pure lua.
    "nvim-lualine/lualine.nvim",
    config = function(_)
        local lualine = require("lualine")
        local lualine_require = require("lualine_require")
        -- Now don"t forget to initialize lualine
        -- lualine.setup(config)
        lualine.setup({
          options = {
    icons_enabled = true,
    -- theme = "powerline",
    theme = "auto",
    -- theme = {

    --     normal = { c = { fg = "#3B4252", bg = "E5E8F1" } },
    --   -- inactive = { c = { fg = colors.fg, bg = colors.bg } },
    -- },
    -- component_separators = { left = "", right = "" },
    -- section_separators = { left = "", right = "" },
    disabled_filetypes = { "alpha", "dashboard", "NvimTree", "Outline" },
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch',
    {'diff',
    colored = false,
	symbols = { added = " ", modified = " ", removed = " " }, -- changes diff symbols
  cond = hide_in_width

  }, 'diagnostics'},
    lualine_c = {{
     'filename',
     file_status = true, -- displays file status (readonly status, modified status)
     path = 0 -- 0 = just filename, 1 = relative path, 2 = absolute path
   }},
    lualine_x = {encoding(), fileformat(), 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
})
        end
}}


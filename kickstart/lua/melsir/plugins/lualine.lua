--only show if the disply width is larger than 76
function  willshow(a)
  local syswidth = vim.fn.winwidth('%')
  if syswidth < 76 then
    return ""
  end
  if syswidth >= 76 then
    return a
  end
end


local colors = {
  dark = "#3B4252",
  white = "#E5E8F1",
}

return {
  -- Set lualine as statusline
  'nvim-lualine/lualine.nvim',
  -- event = "InsertEnter",
  -- See `:help lualine.txt`
  opts = {
    options = {
      icons_enabled = true,
      theme = "auto",
      -- theme = {
      -- normal = { c = { fg = "#3B4252", bg = "#E5E8F1" } },
      -- inactive = { c = { fg = colors.fg, bg = colors.bg } },
      -- },
      -- component_separators = '|',
      -- enable these both will fix lualine problem with nvim startup screen
      component_separators = '',
      -- section_separators = '',
      disabled_filetypes = { "alpha", "dashboard", "NvimTree", "neo-tree", "intro"},
      always_divide_middle = true,

    },
    sections = {
      lualine_b = {{'branch',icon = "",}, {
        'diff',
        symbols = { added = ' ',
          -- modified = '柳 '
          -- modified = ' ',
          modified = ' ',
          -- modified = ' ',
          removed = ' '
        },
      }, 'diagnostics'},
      lualine_x = {willshow("encoding"), willshow("fileformat"), 'filetype'},

    },
  },
}


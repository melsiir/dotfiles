local section_separators = { left = "", right = "" }
local component_separators = { left = "", right = "" }
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- section_separators = '',
      -- empty separator does not interupt neovim stock startup screen
      opts.options.section_separators = section_separators
      opts.options.component_separators = component_separators
      opts.sections.lualine_b = { { "branch", icon = "" } }

      -- apply this config only termux
      if vim.g.user_is_termux then
        opts.sections.lualine_c = { "diagnostics" }
        --opts.sections.lualine_x = { "diff" }
        -- opts.sections.lualine_z = {}
        -- opts.sections.lualine_y = {}
        opts.sections.lualine_y = {
          "progress",
        }
        opts.sections.lualine_z = { "location" }
      end
    end,
  },
}

return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        -- flavour = "mocha",
        integrations = {
          telescope = {
            enabled = true,
            -- style = "nvchad",
          },
        },
        transparent_background = vim.g.transparent_enabled,
        custom_highlights = function(colors)
          return {
            FloatBorder = { fg = colors.purple },
            WinSeparator = { fg = colors.purple },
          }
        end,
      })
      vim.cmd.colorscheme("catppuccin-frappe")
    end,
  }

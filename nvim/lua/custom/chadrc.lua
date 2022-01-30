-- This is an example chadrc file , its supposed to be placed in /lua/custom/

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
   theme = "catppuccin",
   hl_override = "custom.highlights",
}

-- Install plugins
local userPlugins = require "custom.plugins" -- path to table

M.plugins = {
   install = userPlugins,

   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },

   default_plugin_config_replace = {
      -- feline = "custom.plugins.statusline",
      bufferline = "custom.plugins.bufferline",
      nvim_web_devicons = "custom.plugins.icons",
      dashboard = "custom.plugins.dashboard",
      nvim_treesitter = "custom.plugins.treesitter",
      telescope = "custom.plugins.telescope",

      colorizer = "custom.plugins.colorizer",
      -- nvim_cmp = "custom.plugins.cmp",
      -- comment = "custom.plugins.comment",
      
   },

   status = {
		dashboard = true,
		colorizer = true,
		snippets = true,
		feline = false,
           },

}


M.mappings = {
	terminal = {
		esc_hide_termmode = { "jj" }
		},
}


-- NOTE: we heavily suggest using Packer's lazy loading (with the 'event','cmd' fields)
-- see: https://github.com/wbthomason/packer.nvim
-- https://nvchad.github.io/config/walkthrough

return M

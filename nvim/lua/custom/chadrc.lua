
-- lua/custom/chadrc.lua

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
   theme = "onedark",
   hl_override = "custom.highlights",
}

M.plugins = {
	-- change pre installed plugins default config

	default_plugin_config_replace = {
      -- feline = "custom.plugins.statusline",
      bufferline = "custom.plugins.bufferline",
      nvim_web_devicons = "custom.plugins.icons",
      dashboard = "custom.plugins.dashboard",
      treesitter = "custom.plugins.treesitter",
      telescope = "custom.plugins.telescope"
      
   },
-- disable plugins by set it to false
	status = {
		dashboard = true,
		colorizer = true,
		feline = false,
           },
   options = {
      lspconfig = {
         setup_lspconf = "custom.plugins.lspconfig",
      },
   },
}

M.mappings = {
	terminal = {
		esc_hide_termmode = { "jj" }
		},
}



return M

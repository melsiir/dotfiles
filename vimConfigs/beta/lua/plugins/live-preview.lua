return {
  "brianhuster/live-preview.nvim",
  -- event = "VeryLazy",
  ft = { "markdown" },
  dependencies = {
    "nvim-telescope/telescope.nvim",   -- Not required, but recommended for integrating with Telescope
  },
  opts = {
    cmd = "LivePreview",                                                                   -- Main command of live-preview.nvim
    port = 5500,                                                                           -- Port to run the live preview server on.
    autokill = false,                                                                      -- If true, the plugin will autokill other processes running on the same port (except for Neovim) when starting the server.
    browser = "am start -n mark.via.gp/mark.via.Shell --activity-clear-task >/dev/null",   --~/.co- Terminal command to open the browser for live-previewing (eg. 'firefox', 'flatpak run com.vivaldi.Vivaldi'). By default, it will use the default browser.
    dynamic_root = false,                                                                  -- If true, the plugin will set the root directory to the previewed file's directory. If false, the root directory will be the current working directory (`:lua print(vim.uv.cwd())`).
    sync_scroll = false,                                                                   -- If true, the plugin will sync the scrolling in the browser as you scroll in the Markdown files in Neovim.
    picker = "telescope",                                                                  -- Picker to use for opening files. 3 choices are available: 'telescope', 'fzf-lua', 'mini.pick'. If nil, the plugin look for the first available picker when you call the `pick` command.
  },
}

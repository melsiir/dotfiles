require("config.options") -- Load general options
require("config.keymaps") -- Load general keymaps
-- require("config.intro") -- Load general keymaps

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { import = "plugins" },
    -- { import = "plugins.langs" },
    { import = "plugins.langs.typescript" },
    { import = "plugins.langs.tailwind" },
    { import = "plugins.langs.markdown" },
    { import = "plugins.langs.python" },
    -- { import = "plugins.langs.go" },
    -- { import = "plugins.langs.latex" },
    { import = "plugins.ai.copilot" },
    { import = "plugins.ai.cochat" },
    -- { import = "plugins.ai.avante" },
    -- { import = "plugins.ai.complation" },
    -- { import = "plugins.ai.generation" },
    { import = "plugins.ai.generation_parrot" },
    -- { import = "plugins.ai.super-maven" },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  -- install = { colorscheme = { "tokyonight", "habamax" } },
  install = { colorscheme = { "catppuccin" } },
  checker = {
    enabled = true, -- check for plugin updates periodically
    notify = false, -- notify on update
  },                -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        "gzip",
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})

require("config.autocmd") -- Load general options
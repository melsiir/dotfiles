-- Utilities for startup optimization
local M = {}

-- Optimize specific settings for mobile/Termux
M.optimize_for_mobile = function()
  -- Reduce update time on slower systems
  vim.opt.updatetime = 500

  -- Reduce backup time
  vim.opt.backup = false
  vim.opt.writebackup = false

  -- Optimize for terminal usage
  if vim.env.TERMUX_VERSION then
    vim.opt.mouse = '' -- Disable mouse in Termux by default
  end
end

return M
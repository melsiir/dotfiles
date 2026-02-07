-- Mobile/Termux specific configurations
local M = {}

M.setup = function()
  -- Check if we're in Termux
  local is_termux = vim.env.TERMUX_VERSION ~= nil or 
                   (vim.env.PREFIX ~= nil and string.find(vim.env.PREFIX, 'com.termux'))

  if is_termux then
    -- Optimize for mobile environment
    -- NOTE: Not setting lazyredraw anymore as it conflicts with Noice.nvim
    vim.opt.showmode = false   -- Disable mode display since statusline shows it

    -- Adjust for touch interface
    vim.opt.mouse = 'a'        -- Enable mouse in all modes (can be disabled later)

    -- Optimize for smaller screens
    vim.opt.numberwidth = 3    -- Reduce space for line numbers

    -- Adjust for potentially slower hardware
    vim.opt.updatetime = 500   -- Increase update time slightly

    -- print("Neovim configured for Termux environment")
  end
end

return M

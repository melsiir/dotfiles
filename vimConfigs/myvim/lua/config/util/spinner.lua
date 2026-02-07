local spinner_frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
local spinner_index = 1
local active = false

-- Increment spinner on events
local function tick()
  if not active then
    return
  end
  spinner_index = (spinner_index % #spinner_frames) + 1
  vim.cmd("redrawstatus")
end

-- LSP progress handler
vim.lsp.handlers["$/progress"] = function(_, result, ctx)
  active = true
  tick()
  if result.done then
    active = false
  end
end

-- Also update spinner on cursor move (so idle terminals still show animation)
vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
  callback = function()
    if active then
      tick()
    end
  end,
})

-- Lualine component
local function lsp_spinner()
  if active then
    return spinner_frames[spinner_index] .. " LSP"
  else
    return ""
  end
end

return { lsp_spinner = lsp_spinner }

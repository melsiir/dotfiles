local M = {}

function M.bufremove(buf)
  buf = buf or 0
  buf = buf == 0 and vim.api.nvim_get_current_buf() or buf

  if vim.bo.modified then
    local choice = vim.fn.confirm(("Save changes to %q?"):format(vim.fn.bufname()), "&Yes\n&No\n&Cancel")
    if choice == 0 or choice == 3 then -- 0 for <Esc>/<C-c> and 3 for Cancel
      return
    end
    if choice == 1 then -- Yes
      vim.cmd.write()
    end
  end

  for _, win in ipairs(vim.fn.win_findbuf(buf)) do
    vim.api.nvim_win_call(win, function()
      if not vim.api.nvim_win_is_valid(win) or vim.api.nvim_win_get_buf(win) ~= buf then
        return
      end
      -- Try using alternate buffer
      local alt = vim.fn.bufnr("#")
      if alt ~= buf and vim.fn.buflisted(alt) == 1 then
        vim.api.nvim_win_set_buf(win, alt)
        return
      end

      -- Try using previous buffer
      local has_previous = pcall(vim.cmd, "bprevious")
      if has_previous and buf ~= vim.api.nvim_win_get_buf(win) then
        return
      end

      -- Create new listed buffer
      local new_buf = vim.api.nvim_create_buf(true, false)
      vim.api.nvim_win_set_buf(win, new_buf)
    end)
  end
  if vim.api.nvim_buf_is_valid(buf) then
    pcall(vim.cmd, "bdelete! " .. buf)
  end
end

M.get_pkg_path = function(pkg, path, opts)
  pcall(require, "mason") -- make sure Mason is loaded. Will fail when generating docs
  local root = vim.env.MASON or (vim.fn.stdpath("data") .. "/mason")
  opts = opts or {}
  opts.warn = opts.warn == nil and true or opts.warn
  path = path or ""
  local ret = root .. "/packages/" .. pkg .. "/" .. path
  if opts.warn and not vim.loop.fs_stat(ret) and not require("lazy.core.config").headless() then
    vim.notify(
      ("Mason package path not found for **%s**:\n- `%s`\nYou may need to force update the package."):format(pkg, path),
      vim.log.levels.WARN
    )
  end
  return ret
end

function M.FormatForReddit()
  vim.cmd("%s/^/     /g")
  vim.cmd("w ~/redditpost.md")
  vim.cmd("%s/^     //g")
end

-- code run borrowed from
-- https://github.com/tamton-aquib/essentials.nvim
M.run_file = function(ht)
  local fts = {
    rust       = "cargo run",
    python     = "python %",
    javascript = "npm start",
    c          = "make",
    cpp        = "make",
    java       = "java %",
    lua        = "lua %"
  }

  vim.api.nvim_create_autocmd('TermOpen', {
    group = vim.api.nvim_create_augroup('TerminalSettings', { clear = true }),
    callback = function()
      vim.opt_local.number = false
      vim.opt_local.relativenumber = false
      vim.cmd.startinsert()
    end,
  })


  local cmd = fts[vim.bo.ft]
  vim.cmd(
    cmd and ("w | " .. (ht or "") .. "sp | term " .. cmd)
    or "echo 'No command for this filetype'"
  )
end

return M

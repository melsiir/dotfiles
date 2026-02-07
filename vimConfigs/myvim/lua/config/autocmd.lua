-- This file is automatically loaded by lazyvim.config.init.

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
--   callback = function()
--     local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
--     if not normal.bg then
--       return
--     end
--     io.write(string.format("\x1b]11;#%06x\x1b\\", normal.bg))
--   end,
-- })
-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = augroup("highlight_yank"),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
  group = augroup("resize_splits"),
  callback = function()
    local current_tab = vim.fn.tabpagenr()
    vim.cmd("tabdo wincmd =")
    vim.cmd("tabnext " .. current_tab)
  end,
})

-- go to last loc when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  group = augroup("last_loc"),
  callback = function(event)
    local exclude = { "gitcommit" }
    local buf = event.buf
    if vim.tbl_contains(exclude, vim.bo[buf].filetype) or vim.b[buf].lazyvim_last_loc then
      return
    end
    vim.b[buf].lazyvim_last_loc = true
    local mark = vim.api.nvim_buf_get_mark(buf, '"')
    local lcount = vim.api.nvim_buf_line_count(buf)
    if mark[1] > 0 and mark[1] <= lcount then
      pcall(vim.api.nvim_win_set_cursor, 0, mark)
    end
  end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("close_with_q"),
  pattern = {
    "PlenaryTestPopup",
    "grug-far",
    "help",
    "lspinfo",
    "notify",
    "qf",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "dbout",
    "gitsigns-blame",
  },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
    vim.keymap.set("n", "q", "<cmd>close<cr>", {
      buffer = event.buf,
      silent = true,
      desc = "Quit buffer",
    })
  end,
})

-- make it easier to close man-files when opened inline
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("man_unlisted"),
  pattern = { "man" },
  callback = function(event)
    vim.bo[event.buf].buflisted = false
  end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
  group = augroup("wrap_spell"),
  pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- Fix conceallevel for json files
vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("json_conceal"),
  pattern = { "json", "jsonc", "json5" },
  callback = function()
    vim.opt_local.conceallevel = 0
  end,
})

-- Auto create dir when saving a file, in case some intermediate directory does not exist
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
  group = augroup("auto_create_dir"),
  callback = function(event)
    if event.match:match("^%w%w+:[\\/][\\/]") then
      return
    end
    local file = vim.uv.fs_realpath(event.match) or event.match
    vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
  end,
})

vim.filetype.add({
  pattern = {
    [".*"] = {
      function(path, buf)
        return vim.bo[buf]
            and vim.bo[buf].filetype ~= "bigfile"
            and path
            and vim.fn.getfsize(path) > vim.g.bigfile_size
            and "bigfile"
          or nil
      end,
    },
  },
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  group = augroup("bigfile"),
  pattern = "bigfile",
  callback = function(ev)
    vim.b.minianimate_disable = true
    vim.cmd("syntax off")
    -- vim.cmd("SatelliteDisable")
    vim.opt_local.foldmethod = "manual"
    vim.opt_local.spell = false
    vim.opt_local.list = false
    vim.b.matchup_matchparen_fallback = 0
    vim.b.matchup_matchparen_enabled = 0

    vim.schedule(function()
      vim.bo[ev.buf].syntax = vim.filetype.match({ buf = ev.buf }) or ""
    end)
  end,
})

-- large file
vim.api.nvim_create_autocmd({ "BufReadPre" }, {
  group = vim.api.nvim_create_augroup("large_buf", { clear = true }),
  pattern = "*",
  callback = function()
    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()))
    if ok and stats and (stats.size > 1024 * 1024) then
      vim.b.large_buf = true
      vim.cmd("syntax off")
      -- vim.cmd("SatelliteDisable")
      vim.opt_local.foldmethod = "manual"
      vim.opt_local.spell = false
      vim.opt_local.list = false
      vim.b.matchup_matchparen_fallback = 0
      vim.b.matchup_matchparen_enabled = 0
      local status_ok, ts_config = pcall(require, "nvim-treesitter.configs")
      if not status_ok then
        return
      end
      local disable_cb = function(_, buf)
        local success, detected = pcall(vim.api.nvim_buf_get_var, buf, "bigfile_disable_treesitter")
        return success and detected
      end
      for _, mod_name in ipairs(ts_config.available_modules()) do
        local module_config = ts_config.get_module(mod_name) or {}
        local old_disabled = module_config.disable
        module_config.disable = function(lang, buf)
          return disable_cb(lang, buf)
            or (type(old_disabled) == "table" and vim.tbl_contains(old_disabled, lang))
            or (type(old_disabled) == "function" and old_disabled(lang, buf))
        end
      end
      vim.notify("Large buffer detected", vim.diagnostic.severity.WARN)
      vim.api.nvim_exec_autocmds("User", {
        pattern = "LargeBuf",
      })
    else
      vim.b.large_buf = false
    end
  end,
})

-- Add "LiveServer" command to quick execute live-server of npm
vim.api.nvim_create_user_command("LiveServer", function()
  if vim.g.liveserver_bufnr ~= nil then
    return
  end

  vim.cmd("tabnew | term live-server")
  vim.g.liveserver_bufnr = vim.api.nvim_get_current_buf()
  vim.cmd("close")

  local function print_lines()
    local lines = vim.api.nvim_buf_get_lines(vim.g.liveserver_bufnr, 0, 1, false)
    local content = table.concat(lines)
    if content == nil or content == "" then
      vim.defer_fn(print_lines, 100)
    else
      print(content)
    end
  end

  print_lines()

  -- local live_server_lualine = function()
  --   if vim.g.liveserver_bufnr ~= nil then
  --     -- return [[󱄙]]
  --     return [[ ]]
  --   end
  --   return [[]]
  -- end
  --
  -- require("lualine").setup({
  --   sections = {
  --     lualine_x = { { live_server_lualine, color = { fg = "blue" } } },
  --   },
  -- })
end, { desc = "Start live-server in background" })

-- Add "LiveServerStop" command to quick stop live-server of npm
vim.api.nvim_create_user_command("LiveServerStop", function()
  if not vim.g.liveserver_bufnr then
    print("You haven't start Live Server!")
    return
  end

  vim.cmd("bd! " .. vim.g.liveserver_bufnr)
  vim.g.liveserver_bufnr = nil
end, { desc = "Stop live-server" })

-- lsp loading in winbar
-- vim.api.nvim_create_autocmd("LspProgress", {
--   callback = function(o)
--     local p = o.data.params.value.percentage
--     vim.wo.winbar = p and ("%#Green#" .. ("▔"):rep(math.floor((p * vim.o.columns) / 100))) or ""
--   end
-- })

-- disable auto comment in newline
if vim.g.autocomment then
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function()
      vim.opt_local.formatoptions:remove({ "c", "r", "o" })
    end,
  })
end

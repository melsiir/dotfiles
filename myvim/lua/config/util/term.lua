-- create fancy terminal
local M = {}
do
  local api = vim.api
  local fn = vim.fn
  local cmd = vim.cmd
  local g = vim.g
  local opt = vim.opt
  local exec = vim.api.nvim_exec

  local function create_term()
    local buf = api.nvim_create_buf(false, true)
    local win = api.nvim_open_win(buf, true, {
      relative = "editor",
      width = 80,
      height = 20,
      row = 10,
      col = 10,
      style = "minimal",
    })
    api.nvim_win_set_option(win, "wrap", false)
    api.nvim_win_set_option(win, "number", false)
    api.nvim_win_set_option(win, "relativenumber", false)
    api.nvim_win_set_option(win, "cursorline", false)
    api.nvim_win_set_option(win, "cursorcolumn", false)
    api.nvim_win_set_option(win, "signcolumn", "no")
    api.nvim_win_set_option(win, "winhighlight", "Normal:Normal")
    api.nvim_win_set_option(win, "winblend", 0)
    api.nvim_win_set_option(win, "winfixwidth", true)
    api.nvim_win_set_option(win, "winfixheight", true)
  end

  function M.create_term()
    create_term()
  end 



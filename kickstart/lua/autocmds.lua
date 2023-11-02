
-- format on save with conform 
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    require("conform").format({ bufnr = args.buf })
  end,
})


-- remove whitespace on save
vim.cmd [[autocmd BufWritePre * :%s/\s\+$//e]]


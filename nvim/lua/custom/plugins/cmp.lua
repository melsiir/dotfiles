local present, cmp = pcall(require, "cmp")

if not present then
   return
end
local snippets_status = require("core.utils").load_config().plugins.status.snippets


vim.opt.completeopt = "menuone,noselect"

cmp.setup {
  completion = {
      completeopt = "menuone,noselect",
   },
   documentation = {
      border = "rounded",
   },
snippet = (snippets_status and {
      expand = function(args)
         require("luasnip").lsp_expand(args.body)
      end,
   }) or {
      expand = function(_) end,
   },
   formatting = {
      format = function(entry, vim_item)
         local icons = require "custom.plugins.lspkind_icons"
         vim_item.kind = string.format("%s %s", icons[vim_item.kind], vim_item.kind)

         vim_item.menu = ({
            nvim_lsp = "[LSP]",
            nvim_lua = "[Lua]",
            buffer = "[BUF]",
            path = "[Path]",
            cmdline = "[cmdline]",
            emoji = "[emoji]",

         })[entry.source.name]

         return vim_item
      end,
   },
   mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_next_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
         behavior = cmp.ConfirmBehavior.Replace,
         select = true,
      },
      ["<Tab>"] = function(fallback)
         if cmp.visible() then
            cmp.select_next_item()
         elseif require("luasnip").expand_or_jumpable() then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
         else
            fallback()
         end
      end,
      ["<S-Tab>"] = function(fallback)
         if cmp.visible() then
            cmp.select_prev_item()
         elseif require("luasnip").jumpable(-1) then
            vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
         else
            fallback()
         end
      end,
   },
   sources = {
      { name = "nvim_lsp" },
      { name = "luasnip" },
      { name = "buffer" },
      { name = "nvim_lua" },
      { name = "path" },
      { name = "emoji" },
      { name = "cmdline" },
   },
   experimental = {
    ghost_text = true,
  },
}

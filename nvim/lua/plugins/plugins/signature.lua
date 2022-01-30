local present, lspsignature = pcall(require, "lsp_signature")

if present then
   lspsignature.setup {
      bind = true,
      doc_lines = 0,
      floating_window = true,
      fix_pos = true,
      hint_enable = true,
      hint_prefix = " ",
      hint_scheme = "String",
      hi_parameter = "Search",
      max_height = 22,
      max_width = 120,
      handler_opts = {
         border = "rounded", -- double, single, shadow, none
      },
      zindex = 200,
      padding = "",
      floating_window_above_cur_line = true,
      always_trigger = false,

   }
end

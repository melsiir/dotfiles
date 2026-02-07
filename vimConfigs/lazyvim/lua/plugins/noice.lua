local term_width = vim.o.columns
local popup_width = math.min(60, term_width - 4) -- max 60, leave 2-char margin
local col = math.floor((term_width - popup_width) / 2)
local fire = "hg"
return {
  "folke/noice.nvim",

  opts = function(_, opts)
    opts.cmdline = {
      format = {
        search_down = { icon = " ", view = "cmdline_popup" },
        search_up = { icon = " ", view = "cmdline_popup" },
        cmdline = { icon = "" }, -- 󰘳  --   --   --
      },
    }
    if vim.g.user_is_termux then
      opts.views = {
        cmdline_popup = {
          position = {
            col = col, -- fixed number for true centering
          },
          size = {
            width = popup_width,
          },
        },
      }
    end
    opts.routes = {
      {
        filter = {
          event = "lsp",
          kind = "progress",
          cond = function(message)
            local client = vim.tbl_get(message.opts, "progress", "client")
            if client ~= "jdtls" then
              return false
            end
            local content = vim.tbl_get(message.opts, "progress", "message")
            if not content then
              return false
            end
            return string.find(content, "Validate") or string.find(content, "Publish")
          end,
        },
        opts = { skip = true },
      },
    }
  end,
}

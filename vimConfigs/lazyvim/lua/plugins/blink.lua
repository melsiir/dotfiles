local transparent_win = "Normal:None,FloatBorder:WinSeparator,Search:None"
local none_transparent_win = "Normal:None,Search:None"

return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      menu = {
        border = "rounded",
        -- winhighlight = vim.g.transparent_enabled and transparent_win or none_transparent_win,
        winhighlight = none_transparent_win,
      },
      documentation = {
        -- auto_show_delay_ms = 700,
        window = {
          border = "rounded",
          winhighlight = vim.g.transparent_enabled and transparent_win or none_transparent_win,

        },
      },
    },
    sources = {
      providers = {
        -- path = {
        --   name = "path",
        --   -- When typing a path, I would get snippets and text in the
        --   -- suggestions, I want those to show only if there are no path
        --   -- suggestions
        --   fallbacks = { "snippets", "buffer" },
        -- },
        buffer = {
          -- triger buffer suggestions only after typing 3 charactars at least
          min_keyword_length = 2,
        },

        snippets = {
          min_keyword_length = 2,
          -- score_offset = 80, -- the higher the number, the higher the priority
        },
      },
    },
  },
}

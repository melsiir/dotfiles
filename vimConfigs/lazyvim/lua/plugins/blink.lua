return {
  "saghen/blink.cmp",
  opts = {
    completion = {
      menu = {
        border = "rounded",
        winhighlight = "Normal:None,FloatBorder:WinSeparator,Search:None",
      },
      documentation = {
        -- auto_show_delay_ms = 700,
        window = {
          border = "rounded",
          winhighlight = "Normal:None,FloatBorder:WinSeparator,Search:None",
        },
      },
    },
    sources = {
      providers = {
        path = {
          name = "path",
          -- When typing a path, I would get snippets and text in the
          -- suggestions, I want those to show only if there are no path
          -- suggestions
          fallbacks = { "snippets", "buffer" },
        },
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

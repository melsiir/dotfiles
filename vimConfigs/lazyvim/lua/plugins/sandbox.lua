if true then
  return {}
end
return {
  {
    "folke/flash.nvim",
    enabled = false,
  },
  {
    "FluxxField/smart-motion.nvim",
    -- enabled = false,
    opts = {
      presets = {
        words = true,       -- w, b, e, ge
        lines = true,       -- j, k
        search = true,      -- s, f, F, t, T, ;, ,, gs
        delete = true,      -- d + any motion, dt, dT, rdw, rdl
        yank = true,        -- y + any motion, yt, yT, ryw, ryl
        change = true,      -- c + any motion, ct, cT
        paste = true,       -- p/P + any motion
        treesitter = true,  -- ]], [[, ]c, [c, ]b, [b, daa, caa, yaa, dfn, cfn, yfn, saa
        diagnostics = true, -- ]d, [d, ]e, [e
        git = true,         -- ]g, [g
        quickfix = true,    -- ]q, [q, ]l, [l
        marks = true,       -- g', gm
        misc = true,        -- . g. g0 g1-g9 gp gP gA-gZ gmd gmy (repeat, history, pins, global pins)
      },
    },
  },
  {
    "selimacerbas/markdown-preview.nvim",
    lazy = true,
    dependencies = { "selimacerbas/live-server.nvim" },
    config = function()
      require("markdown_preview").setup({
        -- all optional; sane defaults shown
        port = 8421,
        open_browser = true,
        debounce_ms = 300,
      })
    end,
  },
  {
    "xieyonn/spinner.nvim",
    config = function()
      -- **NO** need to call setup() if you are fine with defaults.
      require("spinner").setup()
    end
  },
  {
    "litvinov-git/furry.nvim",
    dependencies = { "nvim-mini/mini.fuzzy" },
    config = function()
      require("furry").setup({
        -- Defaults:
        -- highlight_matches = true,
        -- highlight_current = true,
        -- max_score = 1800,
        -- progressive = true,
        -- sort_by = "lines",
        -- on_empty = "dump",
        -- on_space = "repeat_last",
        -- on_change = "dump",
        -- on_buf_enter = "repeat_last",
      })
    end

  },
  { 'nvim-mini/mini.nvim', version = false },
}

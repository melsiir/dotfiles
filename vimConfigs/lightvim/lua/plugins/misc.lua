return  {
  {
    "sphamba/smear-cursor.nvim",
    enabled = true,
    opts = {
      filetypes_disabled = { "markdown" },
      stiffness = 0.8,          -- 0.6      [0, 1]
      trailing_stiffness = 0.5, -- 0.3      [0, 1]
      -- distance_stop_animating = 0.5, -- 0.1      &gt; 0
      -- hide_target_hack = false,      -- true     boolean
      transparent_bg_fallback_color = "#303030",
      -- legacy_computing_symbols_support = true,
      -- Smear cursor when switching buffers or windows.
      smear_between_buffers = false,
      -- Smear cursor when moving within line or to neighbor lines.
      -- smear_between_neighbor_lines = false,


    },
  }
}

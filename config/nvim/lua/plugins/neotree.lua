local windowSize = function(a)
  local viewWidth = vim.fn.winwidth(0)
  if viewWidth > 85 then
    return math.floor(viewWidth / a)
  else
    return math.floor(viewWidth / 2)
  end
end
-- use <  and  > to navigate tabs
return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
    -- popup_border_style = Utils.ui.borderchars("thick", "tl-t-tr-r-br-b-bl-l"),
    sources = {
      "filesystem",
      "buffers",
      "git_status",
      -- "diagnostics",
      "document_symbols",
    },
    source_selector = {
      winbar = true, -- toggle to show selector on winbar
      content_layout = "center",
      -- statuslinr = true,
      tabs_layout = "equal",
      show_separator_on_edge = true,
      sources = {
        { source = "filesystem", display_name = "󰉓" },
        { source = "buffers", display_name = "󰈙" },
        { source = "git_status", display_name = "" },
        { source = "document_symbols", display_name = "o" },
        -- { source = "diagnostics", display_name = "󰒡" },
      },
    },
    default_component_configs = {
      indent = {
        indent_size = 2,
        padding = 1, -- extra padding on left hand side
        -- indent guides
        with_markers = true,
        indent_marker = "│",
        last_indent_marker = "└",
        -- expander config, needed for nesting files
        with_expanders = true, -- if nil and file nesting is enabled, will enable expanders
        expander_collapsed = "",
        expander_expanded = "",

        -- expander_collapsed = "",
        -- expander_expanded = "",
        expander_highlight = "NeoTreeExpander",
      },
    },
    icon = {
      folder_closed = "",
      folder_open = "",
      folder_empty = "",
      folder_empty_open = "",
    },
    window = {
      position = "left",
      width = windowSize(3),
      mapping_options = {
        noremap = true,
        nowait = true,
      },
    },
  },
  keys = {
      { "-", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
  }
}

windowSize = function(a)
  local viewWidth = vim.fn.winwidth("%")
  if viewWidth > 85 then
    return math.floor(viewWidth / a)
  else
    return math.floor(viewWidth / 2)
  end
end

return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = {
    window = {
      position = "left",
      width = windowSize(3),
      mapping_options = {
        noremap = true,
        nowait = true,
      },
    },
  },
}

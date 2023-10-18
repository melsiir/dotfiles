

return {
'akinsho/bufferline.nvim',
 dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function(_)
        local bufferline = require("bufferline")
        -- Now don"t forget to initialize lualine
        -- lualine.setup(config)
        bufferline.setup({})
      end

}

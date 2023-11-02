return {
  'norcalli/nvim-colorizer.lua',
   config = function(_)
        local colorizer = require("colorizer")
        -- declaring the config nvim will annoy you turn termguicolor on
        colorizer.setup({
          '*';
        })
      end
}



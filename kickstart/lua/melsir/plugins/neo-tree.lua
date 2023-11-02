return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },

  config = function()
    windowSize = function(a)
      local viewWidth = vim.fn.winwidth '%'
      if viewWidth > 85 then
        return math.floor(viewWidth / 3)
      else
        return math.floor(viewWidth / 2)
      end
    end
    -- Unless you are still migrating, remove the deprecated commands from v1.x
    vim.cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]

    require('neo-tree').setup {
      close_if_last_window = true,
      popup_border_style = 'rounded',
      default_component_configs = {
        git_status = {
          symbols = {
            added = '',
            deleted = '',
            modified = '',
            renamed = '➜',
            -- untracked = "★",
            untracked = '?',
            ignored = '◌',
            unstaged = '✗',
            staged = '✓',
            -- conflict = '',
            conflict = '',
          },
        },
      },
      window = {
        position = 'left',
        width = windowSize(3),
        mapping_options = {
          noremap = true,
          nowait = true,
        },
      },
      filesystem = {
        components = {
          --clean up the full path and only show the current folder
          name = function(config, node, state)
            local highlights = require 'neo-tree.ui.highlights'
            local text = node.name
            local highlight = config.highlight or highlights.FILE_NAME
            if node.type == 'directory' then
              highlight = highlights.DIRECTORY_NAME
            end
            if node:get_depth() == 1 then
              text = string.upper(vim.fn.fnamemodify(node.path, ':t'))
              highlight = highlights.ROOT_NAME
            else
              if config.use_git_status_colors == nil or config.use_git_status_colors then
                local git_status = state.components.git_status({}, node, state)
                if git_status and git_status.highlight then
                  highlight = git_status.highlight
                end
              end
            end
            return {
              --toggle bittwen these two text values to shorten
              --or get full path
              -- text = node.name,
              text = text,
              highlight = highlight,
            }
          end,
        },
      },
    }
  end,
}

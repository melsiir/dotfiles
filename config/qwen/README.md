# Neovim Configuration

A fast, aesthetically pleasing Neovim configuration optimized for Neovim 0.11.5 with VS Code-like appearance and functionality.

## Features

- **Fast startup**: Optimized with lazy loading using lazy.nvim
- **Modern UI**: Tokyo Night theme with VS Code-like appearance
- **Smart completion**: Powered by blink.cmp
- **LSP support**: Automatic server management with mason.nvim
- **Fuzzy finding**: Telescope for file and text search
- **Git integration**: Signs and utilities with gitsigns.nvim
- **Terminal integration**: ToggleTerm for embedded terminals
- **Dashboard**: Alpha dashboard for startup screen
- **Mobile-friendly**: Optimized for use on mobile devices via Termux

## Installation

1. Backup your current Neovim configuration:
```bash
mv ~/.config/nvim ~/.config/nvim.backup
```

2. Clone this configuration:
```bash
git clone https://github.com/yourusername/neovim-config.git ~/.config/nvim
```

Or if you're using this as a template, copy the files to your Neovim configuration directory.

3. Start Neovim to automatically install plugins:
```bash
nvim
```

## Key Mappings

### General
- `<Space>` - Leader key
- `<C-s>` - Save file
- `<C-q>` - Quit
- `<C-\>` - Toggle terminal
- `<C-h/j/k/l>` - Navigate between windows
- `<S-h/l>` - Switch between buffers
- `<A-h/j/k/l>` - Resize windows
- `<A-k/j>` - Move lines up/down (normal/insert/visual modes)

### File Operations
- `<Space><Space>` - Find files in buffers
- `<Space>ff` - Find files in workspace
- `<Space>fr` - Open recent files
- `<Space>fs` - Find text in files
- `<Space>fc` - Find word under cursor
- `<Space>fh` - Search help tags

### Git Operations
- `<Space>hs` - Stage hunk
- `<Space>hr` - Reset hunk
- `<Space>hS` - Stage buffer
- `<Space>hR` - Reset buffer
- `<Space>hp` - Preview hunk
- `<Space>hb` - Blame line
- `<Space>hd` - Diff this

### Buffer Operations
- `<Space>bp` - Toggle pin buffer
- `<Space>bP` - Close unpinned buffers
- `<Space>bo` - Close other buffers
- `<Space>bc` - Close buffers to the right
- `<Space>bd` - Delete buffer

### Toggle Operations
- `<Space>n` - Toggle line numbers
- `<Space>us` - Toggle spelling
- `<Space>uw` - Toggle wrap
- `<Space>up` - Toggle paste mode
- `<Space>ug` - Toggle sign column
- `<Space>ul` - Toggle cursor line
- `<Space>uc` - Toggle color column at 80
- `<Space>xx` - Toggle diagnostics
- `<Space>cc` - Toggle colorizer
- `<Space>cb` - Toggle background
- `<Space>sh` - Save session
- `<Space>sl` - Load session
- `<Space>sd` - Delete session

### Comments
- `<Space>/` - Toggle line comment
- `<Space>cb` - Toggle block comment

## Plugins

This configuration uses the following key plugins:

- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager with lazy loading
- [snacks.nvim](https://github.com/folke/snacks.nvim) - Essential utilities
- [blink.cmp](https://github.com/saghen/blink.cmp) - Modern completion engine
- [tokyonight.nvim](https://github.com/folke/tokyonight.nvim) - Theme with VS Code-like appearance
- [nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) - LSP configuration
- [mason.nvim](https://github.com/williamboman/mason.nvim) - LSP server management
- [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter) - Syntax highlighting
- [telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) - Fuzzy finder
- [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim) - Git integration
- [toggleterm.nvim](https://github.com/akinsho/toggleterm.nvim) - Terminal integration

## Mobile/Termux Optimization

This configuration is optimized for use on mobile devices via Termux:

- Lightweight plugin loading
- Efficient resource usage
- Touch-friendly keybindings
- Optimized for slower processors
- Special handling for Termux environment variables
- Reduced screen updates for better performance
- Adjusted settings for smaller screens

## Customization

To customize this configuration:

1. Modify `init.lua` for general settings
2. Modify `lua/plugins/init.lua` for plugin configurations
3. Add custom key mappings to `lua/utils.lua`

## Installation and Setup

1. Install Neovim 0.10+:
   ```bash
   # On Ubuntu/Debian
   sudo apt install neovim
   
   # On macOS
   brew install neovim
   
   # On Arch Linux
   sudo pacman -S neovim
   ```

2. Backup your current Neovim configuration:
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

3. Clone this configuration:
   ```bash
   git clone https://github.com/yourusername/neovim-config.git ~/.config/nvim
   ```

4. Start Neovim to automatically install plugins:
   ```bash
   nvim
   ```

5. Wait for plugins to install. You can check the status with `:Lazy`.

## Performance Tips

- The configuration uses lazy loading extensively to improve startup time
- Plugins are only loaded when needed based on file types, commands, or events
- The `vim.loader` is enabled for faster startup
- Unused Neovim plugins are disabled to reduce startup time

## Updating

To update plugins:
1. Open Neovim
2. Run `:Lazy sync` to update all plugins
3. Run `:Mason` to manage LSP servers and tools (install manually as needed)

Note: LSP servers and tools are not automatically installed. You'll need to install them manually using `:Mason`.

## Troubleshooting

If you encounter issues:

1. Check Neovim version (requires 0.10+)
2. Run `:checkhealth` to diagnose problems
3. Run `:Lazy` to manage plugins
4. Check `:messages` for error messages
5. For LSP issues, run `:LspInfo` to see LSP status
6. For mason issues, run `:Mason` to see installed tools
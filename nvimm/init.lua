require('melsir.base')
require('melsir.highlights')
require('melsir.maps')
require('melsir.plugins')

-- apply theme
-- tokyonight onenord
vim.cmd.colorscheme('tokyonight')

local has = vim.fn.has
local is_mac = has "macunix"
local is_linux = has "unix"
local is_win = has "win32"
local is_wsl = has "wsl"

if is_mac == 1 then
  require('melsir.macos')
end
if is_linux == 1 then
  require('melsir.linux')
end
if is_win == 1 then
  require('melsir.windows')
end
if is_wsl == 1 then
  require('melsir.wsl')
end



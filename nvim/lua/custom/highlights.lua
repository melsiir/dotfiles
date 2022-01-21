local colors = require("colors").get()
local mc =  require"custom.myColors"
local fg = require("core.utils").fg
local fg_bg = require("core.utils").fg_bg
local bg = require("core.utils").bg
--fg("Normal", colors.red) 

-- If you dont want to require the above stuffs then you could just do : 

-- fg("hi Normal guifg=#yourhexcolor")

--fg("hi TelescopeSelection guifg=#00ff00")

--fg_bg("TelescopePromptBorder", mc.darklight, mc.darklight)

--results background

--bg("TelescopeNormal", mc.dark)

fg_bg("TelescopePreviewTitle", mc.blue, mc.ored)
-- the text you type and it's background
fg_bg("TelescopePromptNormal", mc.white, colors.black2)

-- the telescope icon
fg_bg("TelescopePromptPrefix", mc.dodgeblue, colors.black2)

-- where the sentence find files written
fg_bg("TelescopePromptTitle", mc.black, mc.dodgeblue)

-- selected result
fg("TelescopeSelection", mc.white)
 
 
fg("DashboardCenter", mc.white)
fg("DashboardFooter", mc.white)
fg("DashboardHeader", mc.white)
fg("DashboardShortcut", mc.white)




-- Lsp diagnostics

--fg("DiagnosticHint", mc.white)
--fg("DiagnosticError", mc.ored)
--fg("DiagnosticWarn", yellow)
--fg("DiagnosticInformation", green)



--html

-- fg('HtmlTag',colors.blue)
-- fg('HtmlTagname',mc.purple)
fg('HtmlEndtag',colors.blue)
fg('HtmlLink',colors.cyan)
-- fg('HtmlString',mc.blue)
-- fg('HtmlValue',mc.blue)



-- cmp




-- fg('CmpItemAbbr','#FFFFFF')
-- color for selected item
bg('PmenuSel', colors.blue)

-- item that does not have color 
fg('CmpItemAbbrDeprecated', colors.blue)
fg('CmpItemKind', colors.blue)
-- change the colors of the cmp sources exaple [BUF]
fg('CmpItemMenu', colors.blue)

fg('CmpItemAbbrMatch', colors.blue)
fg('CmpItemAbbrMatchFuzzy', colors.blue)
fg('CmpItemKindVariable', colors.blue)
fg('CmpItemKindInterface', colors.blue)
fg('CmpItemKindText', colors.blue)
fg('CmpItemKindClass', colors.yellow)
fg('CmpItemKindFunction', colors.dark_purple)
fg('CmpItemKindMethod', colors.dark_purple)
fg('CmpItemKindKeyword', '#D4D4D4')
fg('CmpItemKindField', colors.blue)
fg('CmpItemKindModule', colors.yellow)
fg('CmpItemKindSnippet', colors.blue)




-- vim.cmd('highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080')
-- vim.cmd('highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6')
-- vim.cmd('highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6')
-- vim.cmd('highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE')
-- vim.cmd('highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE')
-- vim.cmd('highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE')
-- vim.cmd('highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0')
-- vim.cmd('highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0')
-- vim.cmd('highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4')

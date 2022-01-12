local colors = require("colors").get()
local mc =  require"custom.myColors"
local fg = require("core.utils").fg
local fg_bg = require("core.utils").fg_bg
local bg = require("core.utils").bg
--fg("Normal", colors.red) 

-- If you dont want to require the above stuffs then you could just do : 

-- vim.cmd("hi Normal guifg=#yourhexcolor")

--vim.cmd("hi TelescopeSelection guifg=#00ff00")

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
-- fg('HtmlString',mc.blue)
-- fg('HtmlValue',mc.blue)






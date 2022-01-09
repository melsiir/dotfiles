set fish_color_autosuggestion brblack
set fish_color_command brblue
set fish_color_param cyan
set fish_color_comment magenta
set fish_color_end green
set fish_color_error red
set fish_color_quote yellow
set fish_color_operator green
set fish_color_escape green
set fish_color_redirection brcyan

set -l name (basename (status -f) .fish){_uninstall}

function $name --on-event $name
    set -e fish_color_autosuggestion 
    set -e fish_color_command 
    set -e fish_color_param 
    set -e fish_color_comment 
    set -e fish_color_end 
    set -e fish_color_error 
    set -e fish_color_quote 
    set -e fish_color_operator 
    set -e fish_color_escape 
    set -e fish_color_redirection 
end


function draculaMan
    set -xl LESS_TERMCAP_mb $(printf '\e[1;31m') # begin bold
    set -xl LESS_TERMCAP_md $(printf '\e[1;34m') # begin blink
    set -xl LESS_TERMCAP_so $(printf '\e[01;45;37m') # begin reverse video
    set -xl LESS_TERMCAP_us $(printf '\e[01;36m') # begin underline
    set -xl LESS_TERMCAP_me $(printf '\e[0m') # reset bold/blink
    set -xl LESS_TERMCAP_se $(printf '\e[0m') # reset reverse video
    set -xl LESS_TERMCAP_ue $(printf '\e[0m') # reset underline
    # set -xl GROFF_NO_SGR=1
    set -lx LESS '-rsF -m +Gg'
    MANPAGER=less command man $argv

end

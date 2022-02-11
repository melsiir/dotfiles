if status is-interactive
    # Commands to run in interactive sessions can go herehere
    # set -g fish_prompt_pwd_dir_length 1
    if type -q exa
        alias ll "exa -l -g --icons"
        alias lla "ll -a"
        alias laa "ls -A"
    end
    # set -g theme_hostname always
    # set -g theme_display_user yes
    # set -g theme_hide_hostname no
    export NODE_PATH='/data/data/com.termux/files/usr/pnpm-global/5/node_modules'
    # NodeJS
    set -gx PATH node_modules/.bin $PATH
    # export PATH=~/.npm-global/bin:$PATH
    # spaceship init fish | source
end

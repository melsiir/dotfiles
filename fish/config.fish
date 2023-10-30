if status is-interactive
    # Commands to run in interactive sessions can go here
    set fish_greeting ""
    set -gx TERM xterm-256color

    source ~/.config/fish/aliases.fish
    # source ~/.config/fish/test.fish
    source ~/.config/fish/functions.fish
    source ~/.config/fish/web.fish
    # source ~/.config/fish/onDemand/svgExtractor.fish
    source ~/.config/fish/onDemand/offline.fish

    # customization for bobthefish
    # function fish_greeting -d "What's up, fish?"
      # set_color $fish_color_autosuggestion
      # set_color blue
      #  uname -nmsr
      # TODO: `command -q -s` only works on fish 2.5+, so hold off on that for now
      # command -s uptime >/dev/null
      # and command uptime
      # set upt (uptime | string split ,)
      # set upp $upt[2] $upt[3] $upt[4]
      # set upf (string replace " " "" $upp)
      # echo \n $upf
      # # echo $upt \n
      #   # clear
      #   # gbat
      # set_color normal
    # end

    # # set -g theme_newline_cursor yes
    # # set -g theme_newline_prompt "\$ "
    # set -g theme_display_date no
    # # theme
    # # found in /data/data/com.termux/files/usr/share/fish/tools/web_config/themes
    # # fish_config theme choose "Dracula"
    # fish_config theme choose "Dracula Official"
    # # color scheme terminal-dark and termianl light makes bobthefish theme so cool
    set -g theme_color_scheme terminal-dark
    set -g fish_prompt_pwd_dir_length 1
    set -g theme_display_user yes
    set -g theme_hide_hostname yes
    set -g theme_hostname always
    # 
    # # To have colors for ls and all grep commands such as grep, egrep and zgrep
    # # set -x CLICOLOR 1
    # # set -x LS_COLORS 'no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

    # # set -x BAT_THEME Dracula

    #chris titus
    # Color for manpages in less makes manpages a little easier to read
    set -x LESS_TERMCAP_mb $(printf '\e[01;31m')
    set -x LESS_TERMCAP_md $(printf '\e[01;31m')
    set -x LESS_TERMCAP_me $(printf '\e[0m')
    set -x LESS_TERMCAP_se $(printf '\e[0m')
    set -x LESS_TERMCAP_so $(printf '\e[01;44;33m')
    set -x LESS_TERMCAP_ue $(printf '\e[0m')
    set -x LESS_TERMCAP_us $(printf '\e[01;32m')

    # set -lx LESS '-rsF -m +Gg'

    command -qv nvim && alias vim nvim
    set -gx EDITOR nvim
    function edit
        echo "$EDITOR is currently set as your default editor. If you want to change it, then edit the fish config file at $HOME/.config/fish/config.fish"
        $EDITOR
    end

    abbr -ag nv nvim
    abbr -ag v vim

    set -gx PATH bin $PATH
    set -gx PATH ~/bin $PATH
    set -gx PATH ~/.local/bin $PATH
    # NodeJS
    set -gx PATH node_modules/.bin $PATH
    #  storage
    set -gx phone /storage/emulated/0
    set -gx sdcard $HOME/storage/external-1
    set -gx documents /storage/emulated/0/Documents
    set -gx downloads /storage/emulated/0/Download
    set -gx obsidian /storage/emulated/0/Documents/My\ obsidian
    # doc links
    function cheatsheet
        vi $HOME/.config/fish/doc/linux_cheatsheet.txt
    end
    function dots
        cd $HOME/.config
    end
end


source ~/.config/fish/aliases.fish
source ~/.config/fish/functions.fish
source ~/.config/fish/web.fish
source ~/.config/fish/onDemand/offline.fish
# source ~/.config/fish/onDemand/app.fish
# source ~/.config/fish/test.fish
# source ~/.config/fish/onDemand/svgExtractor.fish
# source ~/.config/fish/onDemand/ontime.fish

# colors for echo
# replace e with cap E to bold
set RC '\e[0m'
set BLACK '\e[30m'
set RED '\e[31m'
set GREEN '\e[32m'
set YELLOW '\e[33m'
set BLUE '\e[34m'
set MAGENTA '\e[35m'
set CYAN '\e[36m'
set WHITE '\e[37m'
set BOLD '\e[1m'
set FAINT '\e[2m'
set ITALIC '\e[3m'
set UNDERLINE '\e[4m'
set FILL '\e[7m'
set CROSSLINE '\e[9m'
#use like so
#echo -e $GREEN"string$RC"
#echo -e "$GREEN\e string$RC"
#echo -e "$GREEN string$RC"
#combonation
#\e[34m  blue
#\e[34;1m  blue bold
#\e[34;3m  blue italic


# if status is-interactive
# Commands to run in interactive sessions can go here
set fish_greeting ""
set -gx TERM xterm-256color
set -gx libs "/data/data/com.termux/files/usr/glibc/lib"
# customization for bobthefish

# To have colors for ls and all grep commands such as grep, egrep and zgrep
# set -x CLICOLOR 1
# set -x LS_COLORS (vivid generate one-dark)
# set -x LS_COLORS 'no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'

# set -x BAT_THEME "Solarized (dark)"

#chris titus
# Color for manpages in less makes manpages a little easier to read
# set -x LESS_TERMCAP_mb $(printf '\e[01;31m')
# set -x LESS_TERMCAP_md $(printf '\e[01;31m')
# set -x LESS_TERMCAP_me $(printf '\e[0m')
# set -x LESS_TERMCAP_se $(printf '\e[0m')
# set -x LESS_TERMCAP_so $(printf '\e[01;44;33m')
# set -x LESS_TERMCAP_ue $(printf '\e[0m')
# set -x LESS_TERMCAP_us $(printf '\e[01;32m')

set -x LESS_TERMCAP_mb $(printf "\e[1;31m")
set -x LESS_TERMCAP_md $(printf "\e[1;36m")
set -x LESS_TERMCAP_me $(printf "\e[0m")
set -x LESS_TERMCAP_se $(printf "\e[0m")
set -x LESS_TERMCAP_so $(printf "\e[1;44;33m")
set -x LESS_TERMCAP_ue $(printf "\e[0m")
set -x LESS_TERMCAP_us $(printf "\e[1;32m")

# set -lx LESS '-rsF -m +Gg'

command -qv nvim && alias vim nvim
set -gx EDITOR nvim
function edit
    echo "$EDITOR is currently set as your default editor. If you want to change it, then edit the fish config file at $HOME/.config/fish/config.fish"
    $EDITOR
end

function vi
    nvim $argv
end

function vcl
    nvim --clean $argv
end

function vf -d "find files for neovim"
    nvim (fzf) $argv
end

function vc -d "find config files"
    nvim (find .config/ -type f | fzf)
end

function vim-update
    nvim --headless "+Lazy! sync" +qa W
end

function vimswitch -d "switch bitween neovim configs"
    set selectedConfig (command ls ~/.dotfiles | grep -E '(myvim|lazyvim|lightvim)' | fzf --tac --border rounded --border-label="neovim configs")
    if test -z $selectedConfig
        echo "no config selected"
        return
    end
    rm -rf ~/.config/nvim
    ln -svf ~/.dotfiles/$selectedConfig ~/.config/nvim
    echo
    echo -e $GREEN"successfully selected $selectedConfig"$RC
end

function vim-reset -d "delete all neovim plugind"
    rm -rf ~/.local/share/nvim && rm -rf ~/.config/nvim/lazy-lock.json
end

function wget
    wget2 --force-progress $argv
end

abbr -ag nv nvim
abbr -ag v vim
abbr fda "fd -IH"
abbr rga "rg -uu"

function sd
    cd /storage/0A56-1B19
end

set -gx PATH bin $PATH
set -gx PATH ~/bin $PATH
set -gx PATH ~/.local/bin $PATH
set -gx PATH ~/.config/bin $PATH
# NodeJS
set -gx PATH node_modules/.bin $PATH
#Mason
set -gx MASONBIN "$HOME/.local/share/nvim/mason/bin"
set -gx PATH "$MASONBIN" $PATH

#dotfiles
set -gx dotfiles ~/.dotfiles

#  storage
set -gx phone /storage/emulated/0
set -gx sd /storage/0A56-1B19
set -gx documents /storage/emulated/0/Documents
set -gx gate /storage/emulated/0/Documents/gate
set -gx downloads /storage/emulated/0/Download
set -gx obsidian /storage/emulated/0/Documents/obsidian

#: `fzf` defaults configuration.
# set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow'
# set -gx FZF_DEFAULT_OPTS '--layout=reverse --border'
# set -gx FZF_ALT_C_COMMAND 'fd -H -t d'
#

# FZF options
# set -gx FZF_DEFAULT_COMMAND 'fd --type f --hidden --follow --exclude .git --exclude node_modules'
# set fzf_history_opts --sort --exact --history-size=30000
# set fzf_fd_opts --hidden --follow --exclude=.git
# set fzf_preview_dir_cmd eza -la --git --group-directories-first --icons --color=always
# set fzf_directory_opts --bind "ctrl-o:execute($EDITOR {} &> /dev/tty)"

if type -q bat
    # you can use theme=ansi to inhert terminal colors
    alias cat "bat --plain --pager=never"
end

# doc links
function wiki
    set DocsDir $HOME/.config/wiki
    set selectedDoc (command ls $DocsDir  |  fzf --border rounded --border-label="select a file")
    if test -z $selectedDoc
        echo "no file selected"
        return
    end
    nvim $DocsDir/$selectedDoc
end

function dots
    cd ~/.dotfiles
end

function dotfiles
    cd $dotfiles
end

function src
    source ~/.config/fish/config.fish
end

# pnpm
set -gx PNPM_HOME "/data/data/com.termux/files/home/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

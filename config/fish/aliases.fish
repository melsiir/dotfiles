
# aliases


function shrug
    echo "¯\_(ツ)_/¯"
end
function xx
    exit 0
end
function linecount
    wc -l $argv
end

function op -d Open
    if count $argv >/dev/null
        open $argv
    else
        open .
    end
end

# empty obsidian trash

# edit  config
function ealiases
    vi ~/.config/fish/aliases.fish
end
function epaks
    vi ~/.config/fish/onDemand/packages.fish
end
function efunctions
    vi ~/.config/fish/functions.fish
end
function eweb
    vi ~/.config/fish/web.fish
end
function efish
    vi $HOME/.config/fish/config.fish
end
function estar
    vi $HOME/.config/starship.toml
end
function cvim
    cd $HOME/.config/nvim
end
function cfish
    cd $HOME/.config/fish
end
function config
    cd $HOME/.config
end
function noswap
    rm -r ~/.local/state/nvim/swap
end
function fzfv -d "find and open with neovim"
    vi (fzf)
end
function vh -d "open nvim in current directory like code ."
    nvim .
end

function vl -d "open last file"
    nvim -c "normal '0"
end

function pvim -d "plain nvim"
    nvim -u NONE -i NONE -n -N -n
end

function nman
    MANPAGER='nvim +Man!' man $argv
end
# set fon ; $HOME/.termux/font.ttf;end
function command_exist -d "check if command exist"
    command -v "$argv[1]" >/dev/null 2>&1
end

# package managing
function dbn
    apt-cache depends $argv
end
function rdbn
    apt-cache rdepends $argv
end
function paki
    pkg install $argv
end
function ap
    if command_exist pacman
        pacman -S $argv
    else

        apt-get install $argv
    end
end
function aps
    if command_exist pacman
        pacman -Ss $argv
    else
        apt search $argv
    end
end
function apr -d "remove packages"
    apt remove $argv
    command apt autoremove --yes
    #yes for confrmation good for automation
end
function uninstall
    pkg uninstall $argv
end
# alias debs ; cd $HOME/../usr/var/cache/apt/archives;end
function debs
    if command_exist pacman
        cd /data/data/com.termux/files/usr/var/cache/pacman/pkg
    else
        cd $HOME/../../cache/apt/archives
    end
end


function uu -d "update and upgrade packages"
    apt update && apt upgrade -y
    nvim --headless "+Lazy! update" +qa
end

function deblogs
    cd /data/data/com.termux/files/usr/var/log/apt/
end

function rmdebs -d "delete all the downloaded debs files"
    if command_exist pacman
        rm -r /data/data/com.termux/files/usr/var/cache/pacman/pkg
    else
        rm -r $HOME/../../cache/apt/archives
    end
end

# Alias's to modified commands
function cp
    command cp -ri $argv
end

# ask always when Removeing files from
function mv
    command mv -i $argv
end

#  * Create missing directories in path when calling `mkdir`
function mkdir
    command mkdir -p $argv
end
function ps
    command ps auxf
end
function ping
    command ping -c 10 $argv
end
function less
    command less -R $argv
end

function c
    clear
end
function del
    command rm -rfv $argv
end

#delete empty folders recursively
function noemptydir -d "delete empty folders recursively"
    find . -type d -empty -delete
end
# alias multitail ; multitail --no-repeat -c;end

# Change directory aliases
function home
    cd ~
end
function cd..
    cd ..
end
function ..
    cd ..
end
function ...
    cd ../..
end
function ....
    cd ../../..
end
function .....
    cd ../../../..
end

# cd into the old directory
function bd -d "cd into the old directory"
    cd $dirprev[-1]
end

# Remove a directory and all files
function rmd -d "Remove a directory and all files"
    /bin/rm --recursive --force --verbose $argv
end


# grep	alias. Colorize grep output (good for log files)
function grep
    command grep --color=auto $argv
end
function egrep
    command egrep --color=auto $argv
end
function fgrep
    command fgrep --color=auto $argv
end
function rg
    command rg -p $argv
end
# alias ip='ip -c[auto]'


# Use eza instead of ls.
if type -q eza
    alias l="eza -l --color=auto --icons --group-directories-first"
    alias ls="eza --color=auto  --icons --group-directories-first"
    alias la="eza -a --color=auto --icons --group-directories-first"
    function ll
        eza -al --color=always --icons --group-directories-first
    end
    function lll
        eza --group-directories-first -lagF --git --time-style=long-iso --icons always
    end
    function lt
        eza -aT --color=always --icons --group-directories-first
    end
    function l. -d "only show hidden"
        eza -a | grep -E "^\."
    end
    function dir -d "list dirs only"
        eza --only-dirs -a --icons auto --color auto
    end
    function lx -d "sort by extension"
        eza --sort ext --color auto --icons --group-directories-first
    end
    function lk -d "sort by size"
        # eza --sort size --color auto --icons --group-directories-first
        eza --grid --long --header --no-permissions --no-time --no-user --across
    end
    function lc -d " sort by change time"
        eza --sort changed --color auto --icons --group-directories-first
    end
    function lu -d "sort by access time"
        eza --sort accessed --color auto --icons --group-directories-first
    end
    function lr -d "recursive ls"
        eza -R --color auto --icons --group-directories-first
    end
    function lt -d "sort by date"
        eza --sort date --color auto --icons --group-directories-first
    end
else
    alias lla 'ls -Alh' # show hidden files
    alias lls 'ls -aFh --color=always' # add colors and file type extensions
    alias la 'ls -a' #overwrite fish default command
    alias ls 'ls -Fh --color=always' # add colors and file type extensions
    alias lx 'ls -lXBh --color=auto --group-directories-first' # sort by extension
    alias lk 'ls -lSrh --color=auto --group-directories-first' # sort by size
    alias lc 'ls -lcrh --color=auto --group-directories-first' # sort by change time
    alias lu 'ls -lurh --color=auto --group-directories-first' # sort by access time
    alias lr 'ls -lRh --color=auto --group-directories-first' # recursive ls
    alias lt 'ls -ltrh --color=auto --group-directories-first' # sort by date
    alias lm 'ls -alh --color=auto --group-directories-first |more' # pipe through 'more'
    alias lw 'ls -xAh --group-directories-first' # wide listing format
    alias ll 'ls -Fls --color=auto --group-directories-first' # long listing format
    alias labc 'ls -lap --color=auto --group-directories-first' #alphabetical sort
    alias lf "ls -l | egrep -v '^d'" # files only
    alias ldir "ls -l | egrep '^d'" # directories only

end

# alias to show the date
function da -d "show the date"
    date "+%Y-%m-%d %A %T %Z"
end

# alias chmod commands
function mx
    chmod a+x $argv
end
function 000
    chmod -R 000 $argv
end
function 644
    chmod -R 644 $argv
end
function 666
    chmod -R 666 $argv
end
function 755
    chmod -R 755 $argv
end
function 777
    chmod -R 777 $argv
end
function 700
    chmod -R 700 $argv
end

# Search command line history
function h -d "Search command line history"
    history | grep $argv
end

# Search running processes
function p -d "Search running processes"
    ps aux | grep $argv
end
function topcpu
    /bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10
end
function topcpuf
    set -l statusfile (random)(random).txt
    /bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10 >$statusfile
    sed -i "/\/bin\/ps -eo pcpu,pid,user,args/d" $statusfile
    sed -i "/sort -k 1 -r/d" $statusfile
    sed -i "/head -10/d" $statusfile
    cat $statusfile
    rm $statusfile

end


function rmrf -d "force remove"
    command rm -rfd $argv
end

# Search files in the current folder
function f -d "Search files in the current folder"
    find . | grep $argv
end
# alias rptext ; find . -type f -exec sed -i ; s/$argv[1]/bar/g" {} +;end

# To see if a command is aliased, a file, or a built-in command
function checkcommand -d "To see if a command is aliased, a file, or a built-in command"
    type -t $argv
end


# Alias's to show disk space and space used in a folder
function diskspace -d "show disk space and space used in a folder"
    command du -S | sort -n -r | more $argv
end
function folders
    command du -h --max-depth=1 $argv
end
function folderssort
    command find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn $argv
end
function tree
    command tree -CAhF --dirsfirst $argv
end
function treed
    command tree -CAFd $argv
end
function mountedinfo
    command df -hT $argv
end
# adding flags
function df
    command df -h $argv
end # human-readable sizes
function free
    command free -m $argv
end # show sizes in MB


#  * `sizeof` command to show size of file or directory
function sizeof
    command du -hs $argv
end

function tersize -d "get the size of termux distro"
    sizeof /data/data/com.termux/files
end

# Show all logs in /var/log
# alias logs="find /data/data/com.termux/files/usr/var/log -type f -exec $file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/://g' | grep -v '[0-9]' | xargs tail -f"
# alias logs="bash (find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/://g' | grep -v '[0-9]' | xargs tail -f)"


# Alias; s for archives
function mktar
    tar -cvf $argv
end
function mkbz2
    tar -cvjf $argv
end
function mkgz
    tar -cvzf $argv
end
function untar
    tar -xvf $argv
end
function unbz2
    tar -xvjf $argv
end
function ungz
    tar -xvzf $argv
end
function mkzip
    zip -r $argv[1].zip $argv
end


# SHA1
function sha1
    openssl sha1 $argv | cut -f 2 -d " "
end
function md5
    openssl md5 $argv | cut -f 2 -d " "
end
function sha256
    openssl sha256 $argv | cut -f 2 -d " "
end


function py
    python $argv
end



abbr pp pnpm

function ppi
    pnpm i --offline $argv
end

function lv
    live-server $argv
end

function sassy
    sass --watch style.scss:style.css
end

function dev
    pnpm dev $argv
end


function vito
    vite --port 8080 --open $argv
end


function joke
    curl https://icanhazdadjoke.com
end

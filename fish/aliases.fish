
# aliases


function shrug
    echo "¯\_(ツ)_/¯"
end
function xx
    exit 0
end
function linecount
    wc -l
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
function opm
    open README.md
end
function noswap
    rm -r ~/.local/state/nvim/swap
end
function vf
    vi (fzf)
end
# set fon ; $HOME/.termux/font.ttf;end

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
    apt-get install $argv
end
function aps
    apt search $argv
end
function uninstall
    pkg uninstall $argv
end
# alias debs ; cd $HOME/../usr/var/cache/apt/archives;end
function debs
    cd $HOME/../../cache/apt/archives
end
function nodebs
    cd $HOME/../usr/var/cache/apt/archives/*
end
function deblogs
    cd ‘/data/data/com.termux/files/usr/var/log/apt/
end

# Alias's to modified commands
function cp
    command cp -ri $argv
end
function mv
    command mv -i $argv
end
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

function cls
    clear
end
function del
    command rm -rfv $argv
end

#delete empty folders recursively
function noemptydir
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
function bd
    cd $dirprev[-1]
end

# Remove a directory and all files
function rmd
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
    alias l="eza -al --color=always  --icons --group-directories-first"
    alias ls="eza --color=auto  --icons --group-directories-first"
    alias la="eza -a --color=auto --icons --group-directories-first"
    function ll
        eza -l --color=auto --icons --group-directories-first
    end
    function lt
        eza -aT --color=always --icons --group-directories-first
    end
    function l.
        eza -a | egrep "^\."
    end
    function dir
        eza -al --color=always --icons --group-directories-first
    end
    function lx
        eza --sort ext --color auto --icons --group-directories-first
    end # sort by extension
    function lk
        eza --sort size --color auto --icons --group-directories-first
    end # sort by size
    function lc
        eza --sort changed --color auto --icons --group-directories-first
    end # sort by change time
    function lu
        eza --sort accessed --color auto --icons --group-directories-first
    end # sort by access time
    function lr
        eza -R --color auto --icons --group-directories-first
    end
    # recursive ls
    function lt
        eza --sort date --color auto --icons --group-directories-first
    end # sort by date

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
function da
    date +%Y-%m-%d %A %T %Z
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
function h
    history | grep $argv
end

# Search running processes
function p
    ps aux | grep $argv
end
function topcpu
    /bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10
end

# Search files in the current folder
function f
    find . | grep $argv
end
# alias rptext ; find . -type f -exec sed -i ; s/$argv[1]/bar/g" {} +;end

# To see if a command is aliased, a file, or a built-in command
function checkcommand
    type -t $argv
end


# Alias's to show disk space and space used in a folder
function diskspace
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


# SHA1
function sha1
    openssl sha1 $argv
end
function md5
    openssl md5 $argv
end

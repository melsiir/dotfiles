
# aliases
alias shrug "echo '¯\_(ツ)_/¯'"
alias xx "exit"
alias linecount "wc -l"

# empty obsidian trash

# edit  config
alias ealiases 'vi ~/.config/fish/aliases.fish'
alias epaks 'vi ~/.config/fish/onDemand/packages.fish'
alias efunctions 'vi ~/.config/fish/functions.fish'
alias eweb 'vi ~/.config/fish/web.fish'
alias efish "vi $HOME/.config/fish/config.fish"
alias cvim "cd $HOME/.config/nvim"
alias cfish "cd $HOME/.config/fish"
alias opm "open README.md"
alias noswap 'rm -r ~/.local/state/nvim/swap'
alias vf 'vi (fzf)'
set -xU fon "$HOME/.termux/font.ttf"
function tryfont
  cp $argv $fon
end

# package managing
alias dbn "apt depends"
alias rdbn "apt rdepends"
alias paki "pkg install"
alias ap "apt-get install"
alias aps "apt search"
alias uninstall "pkg uninstall"
# alias debs "cd $HOME/../usr/var/cache/apt/archives"
alias debs "cd $HOME/../../cache/apt/archives"
alias nodebs "cd $HOME/../usr/var/cache/apt/archives/*"
alias deblogs 'cd ‘/data/data/com.termux/files/usr/var/log/apt/'

# Alias's to modified commands
alias cp 'cp -ri'
alias mv 'mv -i'
alias mkdir 'mkdir -p'
alias ps 'ps auxf'
alias ping 'ping -c 10'
alias less 'less -R'
alias cls 'clear'
alias del="rm -rfv"

#delete empty folders recursively
alias noemptydir 'find . -type d -empty -delete'
# alias multitail 'multitail --no-repeat -c'

# Change directory aliases
alias home 'cd ~'
alias cd.. 'cd ..'
alias .. 'cd ..'
alias ... 'cd ../..'
alias .... 'cd ../../..'
alias ..... 'cd ../../../..'

# cd into the old directory
alias bd 'cd "$dirprev[-1]"'

# Remove a directory and all files
alias rmd '/bin/rm  --recursive --force --verbose '


# grep	alias. Colorize grep output (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias rg='rg -p'
# alias ip='ip -c[auto]'

# Alias's for multiple directory listing commands
# alias lla 'ls -Alh' # show hidden files
# alias lls 'ls -aFh --color=always' # add colors and file type extensions
# alias la 'ls -a' #overwrite fish default command
# alias ls 'ls -Fh --color=always' # add colors and file type extensions
# alias lx 'ls -lXBh --color=auto --group-directories-first' # sort by extension
# alias lk 'ls -lSrh --color=auto --group-directories-first' # sort by size
# alias lc 'ls -lcrh --color=auto --group-directories-first' # sort by change time
# alias lu 'ls -lurh --color=auto --group-directories-first' # sort by access time
# alias lr 'ls -lRh --color=auto --group-directories-first' # recursive ls
# alias lt 'ls -ltrh --color=auto --group-directories-first' # sort by date
# alias lm 'ls -alh --color=auto --group-directories-first |more' # pipe through 'more'
# alias lw 'ls -xAh --group-directories-first' # wide listing format
# alias ll 'ls -Fls --color=auto --group-directories-first' # long listing format
# alias labc 'ls -lap --color=auto --group-directories-first' #alphabetical sort
# alias lf "ls -l | egrep -v '^d'" # files only
# alias ldir "ls -l | egrep '^d'" # directories only


# alias ls="eza --color=always --icons --group-directories-first"
# alias la 'eza --color=always --icons --group-directories-first --all'
# alias ll 'eza --color=always --icons --group-directories-first --all --long'


# Use eza instead of ls.
if type -q eza
  alias l="eza -al --color=always  --icons --group-directories-first"
  alias ls="eza --color=auto  --icons --group-directories-first"
  alias la="eza -a --color=auto --icons --group-directories-first"
  alias ll="eza -l --color=auto --icons --group-directories-first"
  alias lt="eza -aT --color=always  --icons --group-directories-first"
  alias l.='eza -a | egrep "^\."'
  alias dir="eza -al --color=always --icons --group-directories-first"

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
alias da='date "+%Y-%m-%d %A %T %Z"'

# alias chmod commands
alias mx 'chmod a+x'
alias 000 'chmod -R 000'
alias 644 'chmod -R 644'
alias 666 'chmod -R 666'
alias 755 'chmod -R 755'
alias 777 'chmod -R 777'
alias 700 'chmod -R 700'

# Search command line history
alias h "history | grep "

# Search running processes
alias p "ps aux | grep "
alias topcpu "/bin/ps -eo pcpu,pid,user,args | sort -k 1 -r | head -10"

# Search files in the current folder
alias f "find . | grep "
# alias rptext 'find . -type f -exec sed -i "s/$argv[1]/bar/g" {} +'

# To see if a command is aliased, a file, or a built-in command
alias checkcommand "type -t"

# Alias's to show disk space and space used in a folder
alias diskspace="du -S | sort -n -r |more"
alias folders='du -h --max-depth=1'
alias folderssort='find . -maxdepth 1 -type d -print0 | xargs -0 du -sk | sort -rn'
alias tree='tree -CAhF --dirsfirst'
alias treed='tree -CAFd'
alias mountedinfo='df -hT'
# adding flags
alias df='df -h'				# human-readable sizes
alias free='free -m'			# show sizes in MB


#  * `sizeof` command to show size of file or directory
alias sizeof="du -hs"

# Show all logs in /var/log
alias logs="find /data/data/com.termux/files/usr/var/log -type f -exec $file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/://g' | grep -v '[0-9]' | xargs tail -f"
# alias logs="bash (find /var/log -type f -exec file {} \; | grep 'text' | cut -d' ' -f1 | sed -e's/://g' | grep -v '[0-9]' | xargs tail -f)"


# Alias's for archives
alias mktar='tar -cvf'
alias mkbz2='tar -cvjf'
alias mkgz='tar -cvzf'
alias untar='tar -xvf'
alias unbz2='tar -xvjf'
alias ungz='tar -xvzf'



# SHA1
alias sha1='openssl sha1'
alias md5='openssl md5'




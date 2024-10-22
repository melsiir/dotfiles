# Searches and replaces for text in all files in the current folder
function ftext
    # -i case-insensitive
    # -I ignore binary files
    # -H causes filename to be printed
    # -r recursive search
    # -n causes line number to be printed
    # optional: -F treat search term as a literal, not a regular expression
    # optional: -l only print filenames and not the matching lines ex. grep -irl "$1" *
    # optional: -o only print matched text instead of whole file
    # optional: -w print the whole line
    grep -iIHrnw --color=always "$argv" . | less -r
end

# replace text recursively
function rreplaceText -d "replace text recursively
"
    find . -type f -exec sed -i "s/$argv[1]/$argv[2]/g" {} +
end

#replace text for indivisual files
function replaceText -d "replace text for indivisual files
"
    sed -i -- "s/$argv[2]/$argv[3]/g" $argv[1]
end

function confirmed
    set confirmCode (random 100 999)
    read --prompt "echo -e ' to perform this action please \n Enter this confirmation code ($confirmCode): '" -l confirmCodeAnswer
    if test -z $confirmCodeAnswer
        set confirmCodeAnswer 0
    end
    if test $confirmCode -eq $confirmCodeAnswer
        return 0
    else
        echo " you entered the wrong code"
        return 1
    end
end

function ii
    echo -e "\n$ORANGE:You are logged on:$RC"
    hostname
    echo -e "\n$LIGHT_BLUE Additionnal information:$RC "
    uname -a
    echo -e "\n$LIGHT_BLUE Users logged on:$RC "
    w -h
    echo -e "\n$LIGHT_BLUE Current date :$RC "
    date
    echo -e "\n$LIGHT_BLUE Machine stats :$RC "
    uptime
    echo -e "\n$LIGHT_BLUE IP for Inter Connection:$RC"
    curl -4 icanhazip.com
end

function copyClip -d "copy content to clipboard"
    if type -q termux-clipboard-set
        if test (count $argv) -eq 0
            return
            termux-clipboard-set
        else
            if test -f $argv[1]
                termux-clipboard-set <$argv
            else
                termux-clipboard-set $argv
            end

        end

    else
        echo $argv

    end

end

function reload --description 'Reloads shell (i.e. invoke as a login shell)'
    exec $SHELL -l
end

function linkbin -d "link .config/bin to .local/bin"
    mkdir -p ~/.local/bin
    ln -sf ~/.config/bin/* ~/.local/bin/
end
function remove-dupl -d "remove duplicate files"
    # remove duplicate files
    set dir (pwd)
    remove-duplicate $dir
end


# show the path of file or dir
function copypath --description "Copy full file path"
    # readlink -e $argv #| xclip -sel clip
    readlink -e $argv | copyClip
    echo "copied to clipboard"
end

# Create and go to the directory
function mkdirg -d "make directory and cd to it"
    mkdir "$argv"
    cd "$argv"
end


# Goes up a specified number of directories  (i.e. up 4)
function up
    set d ""
    set limit $argv[1]
    set --erase argv[1]
    for i in (seq 1 $limit)
        # set d "$d/"
        set d "$d/"".."
    end
    set d $(echo $d | sed 's/^\///')
    if [ -f "$d" ]
        set d ".."
    end
    cd $d
end


# Returns the last 2 fields of the working directory
function pwdtail
    pwd | awk -F/ '{nlast = NF -1;print $nlast"/"$NF}'
end

function match -d "check if string contain substring"
    if string match -q "*$argv[1]*" $argv[2]
        echo "$argv[1] was found"
    else
        echo "$argv[1] was not found"
    end
end


function sedmatch -d "check string matches with sed"
    if [ -n "(sed -n "/$argv[1]/p" > $argv[2])" ]

        echo "$argv[1] was found"

    else
        echo "$argv[1] was not found"

    end
end

# generate new ssh intity
function gen-ssh
    ssh-keygen -f ~/.ssh/$argv -C "$argv"
    echo "Host $argv" >>~/.ssh/config
    echo " HostName __IP__" >>~/.ssh/config
    echo " ForwardAgent yes" >>~/.ssh/config
    echo " PreferredAuthentications publickey" >>~/.ssh/config
    echo " IdentityFile ~/.ssh/$argv" >>~/.ssh/config
    echo "" >>~/.ssh/config
    # vim ~/.ssh/config
end

# git
function gitssh -d "generate and add ssh key to github"
    set -l gitName "$argv[1]"
    set -l gitEmail "$argv[2]"
    #set git name and email
    if test (count $argv) -le 1
        set -l gitConfigName (git config --global --get user.name)
        set -l gitConfigEmail (git config --global --get user.email)
        if test -z $gitConfigName
            read --prompt "echo ' Enter your name: ' " -l gitName
            read --prompt "echo ' Enter your email: ' " -l gitEmail
            git config --global user.name $gitName
            git config --global user.email $gitEmail
        else
            set gitName $gitConfigName
            set gitEmail $gitConfigEmail
        end
    else
        # if supplied as argument set them from
        git config --global user.name $gitName
        git config --global user.email $gitEmail
    end
    #store credential in cache
    # security flow !
    git config --global credential.helper cache

    set -l keyName github
    if test -f ~/.ssh/$keyName
        #if there already key just use it
        #start ssh agent
        eval (ssh-agent -c)
        # private ssh key ssh agent
        ssh-add ~/.ssh/$keyName
    else
        # generate new key
        ssh-keygen -f ~/.ssh/$keyName -t ed25519 -C $gitEmail

        # printf "%s\n" \
        #     "Host github.com" \
        #     "  IdentityFile ~/.ssh/$keyName" \
        #     "  LogLevel ERROR" >>~/.ssh/config

        #start ssh agent
        eval (ssh-agent -c)
        # private ssh key ssh agent
        ssh-add ~/.ssh/$keyName
        echo "copy the the following public key to make personal access token in github"
        copyClip ~/.ssh/$keyName.pub
        echo -e "$GREEN\e the public key copyed to your clipboard$RC"
        echo "now goto this link and create new access token"
        open "https://github.com/settings/ssh/new"
        echo
        echo "to test your ssh key connection run the following command"
        echo
        echo -e "$GREEN\e ssh -T git@github.com$RC"
        echo
        echo "if you connecting with key for the first time"
        echo "you may get a warrning message just type yes"
        echo "if got error says pubkey not autherized re add the the keyfile to the ssh-agent"
    end
    echo "to auth with github make sure to add the the remote url as ssh url like:"
    echo "git remote add origin git@github.com:githubUserName/repoName.git"
end

function giturl -d "print repo remote urls
"
    git remote get-url --all origin $argv
end


# is it a `main` or a `master` repo?
function gitmainormaster
    git branch --format '%(refname:short)' --sort=-committerdate --list master main | head -n1
end
function gps -d "switch git branches bitween test and main"
    #it assume you only have 2 branches main and test
    set currB (git branch | grep "\*")
    if string match -q "*test*" $currB
        git checkout main
    else
        git checkout test
    end
end

function main
    git checkout (gitmainormaster)
end
function master
    main
end

function undogit -d "soft delete last commit"
    if confirmed
        git reset --soft HEAD~1
        echo -e "$GREEN successfully deleted the latest commit$RC"
    end
end

function githistory -d "list of all git repo commits piped into fzf"
    git log --oneline --graph --color=always | nl | fzf --ansi --track --no-sort --layout=reverse-list
end

function gs
    git status $argv
end

function gd
    git add . $argv
end
function gb
    git branch $argv
end
function gc
    git checkout $argv
end
function gp
    git push $argv
end
function gl
    git log --oneline --decorate --color $argv
end
function amend
    git add . && git commit --amend --no-edit $argv
end
function commit
    git add . && git commit -m "$argv"
end
function diff
    git diff $argv
end
function force
    # git push --force-with-lease $argv
    git push origin HEAD --force $argv
end

function gnuke
    git clean -df && git reset --hard $argv
end
function pop
    git stash pop $argv
end
function prune
    git fetch --prune $argv
end
function pull
    git pull $argv
end
function push
    git push $argv
end
function resolve
    git add . && git commit --no-edit $argv
end
function stash
    git stash -u $argv
end
function unstage
    git restore --staged . $argv
end
function wip
    commit wip $argv
end
function gco -d "Use `fzf` to choose which branch to check out" --argument-names branch
    set -q branch[1]; or set branch ''
    git for-each-ref --format='%(refname:short)' refs/heads | fzf --height 10% --layout=reverse --border --query=$branch --select-1 | xargs git checkout
end
function gcoc -d "Fuzzy-find and checkout a commit"
    git log --pretty=oneline --abbrev-commit --reverse | fzf --tac +s -e | awk '{print $1;}' | read -l result; and git checkout "$result"
end
function snag -d "Pick desired files from a chosen branch"
    # use fzf to choose source branch to snag files FROM
    set branch (git for-each-ref --format='%(refname:short)' refs/heads | fzf --height 20% --layout=reverse --border)
    # avoid doing work if branch isn't set
    if test -n "$branch"
        # use fzf to choose files that differ from current branch
        set files (git diff --name-only $branch | fzf --height 20% --layout=reverse --border --multi)
    end
    # avoid checking out branch if files aren't specified
    if test -n "$files"
        git checkout $branch $files
    end
end
function hfzf -d "fuzzy search the command history"
    history | fzf --no-sort --border sharp
end

function lazyg
    git add .
    git commit -m "$argv"
    git push
end

function gcl
    git clone $argv
end

function gitlog --description "git commit browser. uses fzf"
    # todo add "$argv" in there without breaking the no-argv case.
    git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" | fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` --bind "ctrl-m:execute:
                echo "{}" | grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R'"
end

function opm -d "open md documents"
    if test -f README.md
        open README.md
    else
        open *.md
    end
end

function o
    set -l files (fzf)
    # set -l files (fzf --print0 --preview "bat --theme ansi --color always {}")
    if test -z "$files"
        return
    end
    echo -n "$files" | xargs -0 -o "$EDITOR"
end

function getExt -d "get file extension"
    set -l ext (string split "." $argv[1])[-1]
    return $ext
end
# run hugo server
function hug
    # hugo server -F --bind=127.0.0.0:8844 -p=8844 --baseURL=http://127.0.0.0:8844
    hugo server -F --bind=127.0.0.0 --baseURL=http://127.0.0.0
end

function hs -d "start hugo development server"
    # -D include drafts
    hugo server -D $argv
end

function draft -d "write drafts for later usage"
    if test (count $argv) -eq 0
        vi ~/.draft/draft
    else
        printf "$argv\n\n" >>~/.draft/draft
    end
end
# encrypt files with gnupg

function encrypt
    gpg --batch --output $argv[1].gpg --passphrase $argv[2] --symmetric $argv[1]
    echo "$argv[1] encrypted successfully"
end

#decrypt files with gnugp
function decrypt
    gpg --batch --output (string replace ".gpg" "" $argv[1]) --passphrase $argv[2] --decrypt $argv[1]
    echo "$argv[1] decrypted successfully"
end

function zd -d "list files in dir quickly"
    set -l finds (fd --type directory --max-depth 5)

    if [ -z "$finds" ]
        return 0
    end

    set -l fzf_selection (printf '%s\n' $finds | fzf)

    if [ -n "$fzf_selection" ]
        cd $fzf_selection && eza --grid --all --classify --icons
    else
        return 0
    end
end

function zipall -d "compress all file in this dir"
    if test (count $argv) -eq 0
        set archiveName (string split "/" (pwd))[-1]
    else
        set archiveName $argv
    end
    zip -r $archiveName *
end

function oneZip -d "extract indivisual file from zip file"
    set choosenFile (unzip -l $argv[1] | grep -Po "([a-z\.]{2,6})([\/\w \?=.-]*)\/?" | fzf)
    if test -z $choosenFile
        echo "no file selected"
        return
    end
    if test (string match -r '\/$' "$choosenFile") = /
        unzip $argv[1] "$choosenFile*"
    else
        unzip -j $argv[1] $choosenFile
    end
end
function extract -d "extracting different files"
    switch $argv
        case "*.tar.bz2"
            tar xjf $argv

        case "*.tar.gz"
            tar xzf $argv

        case "*.bz2"
            bunzip2 $argv

        case "*.rar"
            unrar x $argv

        case "*.gz"
            gunzip $argv

        case "*.tar"
            tar xf $argv

        case "*.tbz2"
            tar xjf $argv

        case "*.tgz"
            tar xzf $argv

        case "*.zip"
            unzip $argv

        case "*.Z"
            uncompress $argv

        case "*.7z"
            7z x $argv

        case "*.deb"
            ar x $argv

        case "*.tar.xz"
            tar xf $argv

        case "*.tar.zst"
            unzstd $argv

        case "*"
            echo "'$argv' cannot be extracted via ex"

    end
    set_color normal
end

# Get week number
function week
    date +%V
end


function run --description "Make file executable, then run it"
    chmod +x "$argv"
    eval "./$argv"
end


function b --description "Exec command in bash. Useful when copy-pasting commands with imcompatible syntax to fish "
    bash -c "$argv"
end



function qr --description "Prints QR. E.g. super useful when you need to transfer private key to the phone without intermediaries `cat ~/.ssh/topsecret.pem | qr`"
    c
    # -t determine the output format for stdout better use ansi, ansi256, ansiutf8, utf8 the default is png
    if [ "$argv" = "" ]
        echo "Please give input file or string value"
        # qrencode --background=00000000 --foreground=FFFFFF -t ansi -o -
        return
    else
        if test -e $argv
            cat $argv | qrencode --background=00000000 --foreground=FFFFFF -t ansi -o -
        else
            printf "$argv" | qrencode --background=00000000 --foreground=FFFFFF -t ansi -o -
        end
    end
end

# alias sharewifi='qr "WIFI:T:WPA;S:aaa;P:bbb;;"'

function bak --description "Copies (backups) file in same folder with .bak extension"
    cp -i "$argv" "$argv.bak"
end

# get package urls to download for offline
function pkgurl
    apt-get --print-uris install $argv >out
    cat out | grep http | tr -d \' | awk '{print $1}' >deblist
    rm out
    echo "the pkg(s) url(s) are listed in deblist"
end

function spinner
    set pid $last_pid
    echo " The proccess is running"
    while true
        # for X in ⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏
        for X in - / '|' '\\'
            echo -en "\b$X"
            sleep 0.1
        end
    end
end
function sp
    $argv & set PID $last_pid

    echo " The proccess is running"
    while kill -0 $PID 2>/dev/null
        for X in ⠋ ⠙ ⠹ ⠸ ⠼ ⠴ ⠦ ⠧ ⠇ ⠏
            # for X in - / '|' '\\'
            echo -en "\b$X"
            sleep 0.1
        end
    end
end

function toggleship -d "switch on and off starship theme"
    if test -f "$HOME/.config/fish/functions/fish_prompt.fish.bak"
        mv "$HOME/.config/fish/functions/fish_prompt.fish.bak" "$HOME/.config/fish/functions/fish_prompt.fish"
    else if test -f "$HOME/.config/fish/functions/fish_prompt.fish"
        mv "$HOME/.config/fish/functions/fish_prompt.fish" "$HOME/.config/fish/functions/fish_prompt.fish.bak"
    end
end



function restoressh
    mkdir -p $HOME/.ssh
    cp $repo/Keystore/ssh/* $HOME/.ssh
end

function restoreTermux
    mkdir -p $HOME/.termux
    rm $HOME/.termux/termux.properties
    cp $repo/TermuxSettings/* $HOME/.termux
end

function freshstart
    restoressh
    restoreTermux
    # cp $HOME/.config/bin/* $HOME/.local/bin/
    if test $argv = on; or test $argv = online
        apt-update && apt-upgrade

        apt install neovim fzf grep eza lua54 make cmake zip git tree gh fd bat nodejs openssl-tool wget2 zip unzip

        npm install -g pnpm
        pnpm install -g sass nodemon live-server

    else
        set -xU repo /storage/0A56-1B19/backup/Termux
        app pkgUpdate
        mkdir -p temp
        #    apt -f install
        # dpkg --configure util-linux
        cp $repo/offline-repo/pkgUpdate/libsmartcols_*.deb ./temp
        cp $repo/offline-repo/pkgUpdate/termux-tools_*.deb ./temp
        cp $repo/offline-repo/pkgUpdate/util-linux_*.deb ./temp
        dpkg -i ./temp/libsmartcols_*.deb
        dpkg -i ./temp/util-linux_*.deb
        dpkg -i --force-confnew ./temp/termux-tools_*.deb
        # apt -f install
        rm -rf temp
        app neovim fzf eza lua make zip \
            tree git sift bat fd
        updateAptsrc
    end
end


function backhome -d "backup home folder into documents folder"
    cd $HOME
    zip -r home.zip * -x "*/node_modules/*" "storage/*"
    mv home.zip /storage/emulated/0/Documents/
end

function restoreHome -d "restore home backup"
    cd $HOME
    mv /storage/emulated/0/Documents/home.zip $HOME
    unzip home.zip
    rm home.zip
end

function fm -d "open termux storage in external app"
    am start -a android.intent.action.VIEW -d "content://com.android.externalstorage.documents/root/primary"
end

function cfont -d "change termux font"
    # rm $HOME/.termux/font.ttf
    cp -R $argv $HOME/.termux/font.ttf
end

function ctheme -d "change termux theme"
    # rm $HOME/.termux/colors.properties
    cp -Rf $argv $HOME/.termux/colors.properties
end


function tertheme -d "change termux theme with fuzzy finder"
    set themedir $repo/draft/colors
    set selectedTheme (command ls -R $themedir | grep -E '\.properties$' | fzf --border rounded --border-label="Termux Themes")
    if test -z $selectedTheme
        echo "no theme selected"
        return
    end
    set selectednoprop (string replace ".properties" "" $selectedTheme)
    echo "successfully selected $selectednoprop"
    rm -fR $HOME/.termux/colors.properties
    ctheme (find $themedir | grep "/$selectedTheme" | head -1)
    termux-reload-settings
end

function startheme -d "change starship theme with fuzzy finder"
    # set -l selectedTheme (starship preset -l | fzf --border rounded --border-label="select starship Themes")
    # starship preset $selectedTheme >~/.config/starship.toml
    set themeList (starship preset -l)
    set themeList $themeList (ls ~/.config/starship)
    set selectedTheme (echo $themeList | sed 's/[[:blank:]]/\n/g' | fzf --border rounded --border-label="select starship Themes")
    if test -z $selectedTheme
        echo "no theme provided"
        return
    end

    if test -e ~/.config/starship/$selectedTheme
        cp --update=all ~/.config/starship/$selectedTheme ~/.config/starship.toml
    else
        starship preset $selectedTheme >~/.config/starship.toml
    end
end

function terfont -d "change termux font with fuzzy finder"
    set fontdir $repo/nerd_fonts
    set selectedFont (command ls -R $fontdir | grep -E '\.ttf$|\.otf$' |  fzf --border rounded --border-label="Termux Fonts")
    if test -z $selectedFont
        echo "no font selected"
        return
    end
    set selectednoprop (string replace ".ttf" "" $selectedFont)
    echo "successfully selected $selectednoprop"
    rm -fR $HOME/.termux/font.ttf
    cfont (find $fontdir | grep  "/$selectedFont" | head -1)
    termux-reload-settings
end

function updateAptsrc -d "update apt source list offline"
    set Termux /storage/0A56-1B19/backup/Termux
    cp $Termux/myConfig.zip ./
    unzip -q myConfig.zip -d temp
    if test -d $HOME/../usr/var/lib/apt/lists
        rm -rf $HOME/../usr/var/lib/apt/lists
    end
    mkdir -p $HOME/../usr/var/lib/apt/lists
    cp -fr temp/packages/* $HOME/../usr/var/lib/apt/lists
    rm -rf temp
    rm -rf myConfig.zip
end


#android apk

function apk
    java -jar $HOME/.local/bin/APKEditor.jar
end

function apkdecode
    apktool decode $argv[1] \
        --match-original \
        -api 29 \
        -o apkout
end

function apkmerge -d "merge split apks and apkm"
    # set -l inName
    java -jar $HOME/.local/bin/APKEditor.jar m -i $argv
end

function apksign -d "sign apk files"
    # apksigner sign --ks $argv[1] $argv[2]
    if test $HOME/.local/release.keystore
        cp $repo/Keystore/release.keystore $HOME/.local/
        cp $repo/Keystore/pass.txt $HOME/.local/
    end
    apksigner sign --ks $HOME/.local/release.keystore --ks-pass file:$HOME/.local/pass.txt $argv[1]
    rm $HOME/.local/release.keystore $HOME/.local/pass.txt
end

function apkverify
    apksigner verify -v --print-certs $argv
end

function genkeystore -d "generate keystore"
    # validity in days
    keytool -genkey -v -keystore release.keystore -alias universal -keyalg RSA -keysize 2048 -validity 18000 $argv
end

function rcpp -d "run c++ code"
    if test (count $argv) -eq 0
        clang++ -Wall ./*.cpp && ./a.out
    else
        clang++ -Wall $argv && ./a.out
    end
end

function tscr -d "compile and run typescript code"
    tsc
    node dist/*.js
end

function pp
    pnpm $argv
end


function cleanpm -d "clean pnpm cache or npm cache"
    pnpm store prune --force
    rm -rf $HOME/.local/share/pnpm/store

    # npm cache clean --force
end


function npnames -d "extract packages form package.json file"
    # grep -Po '(:\s\{\n\s+)?"(.*?)":\s"\^?\d+\.\d+\.\d+"' package.json | sed "s/\^//g" | string replace -r -a '[\d]{1,3}\.[\d]{1,3}\.[\d]{1,3}' '' | sed "s/\"//g" | sed "s/\://g" | sed ':a;N;$!ba;s/\n//g'
    echo -e "$GREEN$BOLD dependencies $RC"
    set deps (cat package.json | jq .dependencies | string replace -r -a '[\d]{1,3}\.[\d]{1,3}\.[\d]{1,3}' '' | sed -E ":a;N;\$!ba;s/(\{?|\}?|,?|\"?|\:?|\^?|\n?|(\s){2,5})//g")
    echo -e "   $deps"
    echo
    echo -e "$GREEN$BOLD devDependencies $RC"
    set devDeps (cat package.json | jq .devDependencies | string replace -r -a '[\d]{1,3}\.[\d]{1,3}\.[\d]{1,3}' '' | sed -E ":a;N;\$!ba;s/(\{?|\}?|,?|\"?|\:?|\^?|\n?|(\s){2,5})//g")
    echo -e "   $devDeps"
    echo
end

function nfresh -d "remove and reinstall node modules"
    rm -rf node_modules/ pnpm-lock.yaml && pnpm install

end

function noderemove -d "remove all node modules recursively depth level three"
    fd --max-depth 3 --type directory --no-ignore node_modules -x echo {} >modules_files
    cat modules_files | while read -l folder
        echo $folder
        rm -rf $folder
    end

    rm modules_files

end

function nuke -d "delete current directory"
    set -l curdir (pwd)
    # cd $HOME
    if test $curdir = $HOME
        echo "home directory cannot be deleted!"
        return
    else
        set -l deleted (pwd | awk -F/ '{nlast = NF -0;print $nlast}')

        cd ..
        rm -rf $curdir

        echo "the directory $deleted has been nuked"
    end
end


function downsite -d "download website source code"
    wget2 --mirror \
        --page-requisites \
        --adjust-extension \
        --no-parent \
        --convert-links \
        --if-modified-since \
        --execute robots=off \
        --max-threads 5 \
        # --domains $argv \
        $argv
end

function getDocs -d "copy some documentation from sd card"

    set DocsDir $repo/../../eLearning/Docs
    set selectedDoc (command ls -R $DocsDir | grep -E '\.zip$' |  fzf --border rounded --border-label="documentation archives")
    if test -z $selectedDoc
        echo "no archive selected"
        return
    end
    set selectednoprop (string replace ".zip" "" $selectedDoc)
    echo "successfully selected $selectednoprop"
    cp (find $DocsDir -regex ".*$selectedDoc") ./
    unzip $selectedDoc
    rm $selectedDoc

end

function docs -d "run docs with language server"
    set DocsDir $HOME/docs
    set selectedDoc (command ls $DocsDir  |  fzf --border rounded --border-label="select documentation")
    if test -z $selectedDoc
        echo "no documentation selected"
        return
    end
    cd $DocsDir/$selectedDoc
    echo "running $selectedDoc via live-server!"
    live-server
    bd

end

function gate
    set item (command ls  $gate |  fzf --border rounded --border-label="select file or folder")
    if test -z $item
        echo "no file selected"
        return
    end
    mv $gate/$item ./
    echo "$item transfered successfully"
end

function fe -d "goto to function defenetion from"
    set -l rawResult (type $argv[1])[2]
    set -l funcPath (string split " " $rawResult)[4]
    set -l funcLine (string split " " $rawResult)[-1]
    nvim $funcPath +$funcLine
end

function kittermux -d "convert kitty themes into termux themes"
    mkdir -p kithemes
    find . -type f | grep -P "(.*?)\.(conf)\$" | while read -l themeFile
        cp --update=all $themeFile kithemes
    end
    cd kithemes
    find . -type f | grep -P "(.*?)\.(conf)\$" | while read -l file
        sed -i /selection_/d -e /border_color/d -e /Windows/d -e /Tabs/d \
            -e /tab_/d -e /url_color/d -e /_foreground/d -e /_background/d -e /_titlebar_color/d -e /url_style/d -e /visual_bell_color/d -e /cursor_text/d -e "s/\s#/=#/" $file
        sed -i /selection_/d $file
        sed -i -E "s/\s{1,20}=#/=#/g" $file
        set -l tempName $file.taktak98686ggg
        set -l finalName (string split ".conf.taktak98686ggg" $tempName)[1]
        mv --update=all $file $finalName.properties
    end
end


function fzf-aliases-functions
    set aliasPoint (alias)
    set CMD ( printf  $aliasPoint | fzf | cut -d '=' -f1)

    eval $CMD
end

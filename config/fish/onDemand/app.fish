# obsidisn related functions

function ctd -d "clean completed todo"
    sed -i "/[x]/d" "$obsidian/todo 📝.md"
    #remove emptylines
    # sed -i '/^$/d' "$obsidian/todo 📝.md"
    #replace multiple emtpy line with on empty line
    sed -i '/^$/N;/^\n$/D' "$obsidian/todo 📝.md"
    cat "$obsidian/todo 📝.md"
end

function td --description "Add to todo list"
    echo -e "\n- [ ] $argv" >>"$obsidian/todo 📝.md"
    cat "$obsidian/todo 📝.md"

end


function gtd --description 'view todo list'
    cat "$obsidian/todo 📝.md"
end

function color --description "Print color"
    echo (set_color (string trim -c '#' "$argv"))"██"
end

function tdck -d "check todo task"
    if test $argv = ""
        echo "please type text from your note!"
        return
    end
    for todo in $argv
        set linenumber (grep -in $todo "$obsidian/todo 📝.md"  | cut -d':' -f1)
        # replace text at that specific
        sed -i ""$linenumber"s/\[ \]/\[x\]/" "$obsidian/todo 📝.md"
        set noteline (sed -n {$linenumber}p "$obsidian/todo 📝.md")
        echo \n "the task is checked 🏁"
        echo $noteline
    end
end

#obsidian

# go to obsidian vault directory


function obs
    cd $obsidian
    echo "you are now in your obsidian vault 🌙"
end

function obsClean
    rm -r $obsidian/.trash
end

function obsRestore
    cp -r $phone/obsidian_bakcup/* $documents
end

function obsbak
    rm -r $phone/obsidian_bakcup/
    mkdir $phone/obsidian_bakcup
    cp -r $obsidian $phone/obsidian_bakcup
end

function obsBakdots -d "backup obsidian dotfiles"
    pushd $obsidian
    zip -r ../obsidian.zip .obsidian
    popd
end

function obsResdots -d "restore obsidian dotfiles"
    pushd $obsidian/..
    cp obsidian.zip ob.zip
    unzip ob.zip
    rm -rf $obsidian/.obsidian
    mv .obsidian $obsidian
    rm ob.zip
    popd
end

abbr -ag obrs obsResdots

#formating for md copyed from websites
#make md look go by cuting unnecesery content
# it only cut from start to the text --start and from text --end to the end
function trimstart
    set start (grep -in "\-\-start" $argv | head -n 1 | cut -d':' -f1)
    set startd "$start"d
    set fstart "1, $startd"
    sed -i "$fstart" $argv
end

function trimend
    set end (grep -in "\-\-end" $argv | head -n 1 | cut -d':' -f1)
    set fend "$end, \$d"
    sed -i "$fend" $argv
end

function trimmd -d "trim unnecesery content from markdown"
    trimstart $argv
    trimend $argv
end

function trimallmd
    find . -type f -name "*.md" | while read -l mds
        trimstart $mds
        trimend $mds
    end
end
#remove all empty lined
function noemptylines
    sed -i '/^$/d' $argv
end

#remove all whitespaces at the end of lines
function nowspace -d "remove all whitespaces at the end of lines"
    sed -i 's/[[:blank:]]*$//g' $argv
end




#web scrapping
function downlinks -d "download files from links in text file"
    cat $argv | while read -l link
        # wget2 $link
        if string match -rq "^(https?:\/\/)" $link
            set mainLink $link
        else
            set mainLink https://$link
        end
        # wget2 --random-wait -e robots=off $mainLink

        set raw (string split "/" $link)[4..-2]
        set parentDir (string join / $raw)
        wget2 --random-wait -e robots=off --force-directories -P $parentDir $link

    end
end




function extLinks -d "extract all links form next website"
    # run this function in dirctory of your downloaded website and the name of the website as argomument
    # if test (string length $argv) -eq 0
    #     echo "please inter the name of the website"
    #     return
    # end


    # command grep --include="*.html" -rPohI "https://([a-z\.]{2,6})([\/\w\?%=.-]*)\.(css?|js)" | sort | uniq >list.txt
    # command grep --include="*.html" -rPohI "/?_?([a-z\.]{2,6})([\/\w \?%~=.-]*)\.(json?|jpg?|js?|css?|png?|woff2?|woff)" | sort | uniq >list.txt
    command grep --include="*.html" -rPohI "/?_?([a-z\.]{2,6})([\/\w\(\)\?=.-]*)\.(js\"?|css)" | sed -E "s/(\.\.\/){1,3}//" | sed -E "s/^\///" | sort | uniq >list.txt

    sed -i "s/\"//g" list.txt
    if test -d _next
        sed -i -E "s/^static/_next\/static/" list.txt
    end

    # remove any line that does not contains slash
    set unwanted (sed "/[/]/d" list.txt)
    for word in $unwanted
        sed -i '/$word/d' list.txt
    end
    # sed -i 's/_next/$argv\/_next/' list.txt
    # echo "scape slashes and run "
    set esclink (string replace -a "/" "\/" $argv)
    sed -i "s/^/$esclink\//" list.txt

    # mkdir downloaded
    # cd downloaded
    # wget --directory-prefix path/to/directory --input-file ../list.txt
    cat ./list.txt | while read -l link
        set raw (string split "/" $link)[4..-2]
        set parentDir (string join / $raw)
        wget2 --random-wait -e robots=off --force-directories -P $parentDir $link
        # echo $mainLink/$link

    end

end



function downAssets -d "download nextjs assets for messing websites downloaded by wget"
    # you shloud first run the liveserver and pip the output to log filethat should be outside the liveserver execution directory
    # like this
    # live-server > ../livelog.txt
    # and then run this function on this logfile
    # downAssets ./livelog.txt https://react.dev
    # next app
    # grep -Po "GET /_([a-z\.]{2,6})([\/\w \?=%&.-]*)\.(js?|css?|png)" $argv[1] | sed "s/GET \///" >listUrl.txt

    if string match -rq "^(https?:\/\/)" $argv[2]
        set mainLink $argv[2]
    else
        set mainLink https://$argv[2]
    end

    #
    # remix run
    cat $argv[1] | sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g' | grep -Po "GET(.*?)404" | sed "s/GET \///" | sed "s/\s404//" | sort | uniq >ulist.txt


    #remix docs
    ## this remove colors from log file
    # sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g'
    # cat $argv[1] | sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g' | grep -Po "GET /([a-z\.]{2,6})([\/\w \?%=.-]*) 404" | sed "s/GET \///" | sed "s/\s404//" | sort | uniq >ulist.txt


    # cat ./ulist.txt | while read -l link
    #     wget2 --random-wait -e robots=off $mainLink/$link
    # end
    downlinks ./ulist.txt
    rm listUrl.txt


end

function downjs -d "download js assets for web sites"
    command grep --include="runtime*.js" -rPohI "assets/js/\"\+(.*?).js" | sed "s/assets\/js\/\"+(/set a /" | sed "s/\[e\]+\"\.js//" | sed "s/\[e\]||e)+\"\.\"+/\n set b /" >links.fish
    source (pwd)/links.fish
    for i in $a
        set itemIndex (string split ':' $i)[1]
        set firstName (string split ':' $i)[2]
        set secondItem (string match  "*$itemIndex:*" $b)
        set secondName (string split ':' $secondItem)[2]
        set finalName (string join "." $firstName $secondName).js
        echo "$argv[1]/assets/js/$finalName" >>links.txt
    end
    cat links.txt | while read -l link
        wget2 --random-wait -e robots=off $link
    end
    rm links.fish
    rm links.txt
end



function nextjson -d "manually copy json files form inside html in nextjs websites"
    set jsonDir (command ls _next/static | grep -P "(\w-?){14,}")

    mkdir -p _next/data/$jsonDir

    mkdir -p midway
    grep -rl "id=\"__NEXT_DATA__" --include="*.html" >containJson.txt
    cat containJson.txt | while read -l line
        set -l futue_parent (dirname $line)
        mkdir -p midway/$futue_parent/
        set -l future_file (basename -s .html $line).json

        grep -Po "id=\"__NEXT_DATA__\"(.*?),\"page\":\"/\[\[\.\.\.markdownPath" $line | sed "s/id=\"__NEXT_DATA__\" type=\"application\/json\">{\"props\"://" | sed "s/,\"page\":\"\/\[\[\.\.\.markdownPath//" | sed "s/\\\u0026/\&/g" | sed "s/\\\u003e/\>/g" | sed "s/\\\u003c/\</g" >midway/$futue_parent/$future_file

    end

    mv midway/* _next/data/$jsonDir
end


# packages

function pkgdown
    apt --print-uris install $argv >out
    cat out | grep http | tr -d \' | awk '{print $1}' >deblist
    rm out
    echo "the pkg(s) url(s) are listed in deblist"

    for line in (cat ./deblist)
        curl -O $line
    end
end


function pkglist -d "open packages list file"
    vi $HOME/../usr/var/lib/apt/lists/packages-cf.termux.dev_apt_termux-main_dists_stable_main_binary-arm_Packages
end


function getdeps
    dbn $argv >dbn.txt
    #remove the first line
    sed -i 1d dbn.txt
    sed -i /Recommends/d dbn.txt
    sed -i /Suggests/d dbn.txt
    sed -i /Replaces/d dbn.txt
    sed -i /Breaks/d dbn.txt
    sed -i "s/Depends://" dbn.txt
    # remove tags
    sed -i -E "s/\((.*?)\)//g" dbn.txt
    #remove white space at the start of the lines
    sed -i 's/^[[:blank:]]*//g' dbn.txt
    #replace newline with space
    sed -i ':a;N;$!ba;s/\n/ /g' dbn.txt
    set pkgslist (cat dbn.txt)
    echo $pkgslist
    rm dbn.txt
end


function getlog -d "get the package installtion histort"
    cp /data/data/com.termux/files/usr/var/log/apt/term.log ./
    extdebs ./term.log
    # rm ./term.log
end
function extdebs -d "extract packges names from log file"
    # sift "_(.*?).deb" $argv[1] >deb.txt
    grep -E "_(.*?).deb" $argv[1] >deb.txt
    # grep -E "_(.*?).deb|Setting up" $argv[1] >deb.txt
    sed -i "s/Preparing to unpack ...\///g" deb.txt
    sed -i "s/archives\///g" deb.txt
    sed -i "s/apt\///g" deb.txt
    sed -i "s/_.*//g" deb.txt
    #use this in nvim replace to cut some starting digits
    #:%s/^\d*-//
    # you can use the in nvim replace to get the
    # name without extention and tag
    # # %s/_.*//
end

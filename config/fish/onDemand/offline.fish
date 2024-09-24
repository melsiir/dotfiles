
#get list installed packages
#dpkg -l | awk '/^ii/ { print $2 ;}'
#check specific package installed
#
#dpkg -s <packagename>
#dpkg-query -l <packagename>
#apt -qq list fish --installed
#if return 0 echo command after && if return 1 excute command after ||
# return 1 && echo hero || echo fun

# copy deb file and all it dependencies to archive dir and run this for example for strace
# apt-get -f install strace
# and this will install strace automaticly with all it dependencies
set -xU repo /storage/0A56-1B19/backup/Termux
# source ~/.config/fish/onDemand/packages.fish

function geturls
    apt-get --print-uris --yes -d --reinstall install fish (apt-cache depends fish | grep "  Depends:" |  sed 's/  Depends://' | sed ':a;N;$!ba;s/\n//g') | grep ^\' | cut -d\' -f2 >downloads.list
end

function isInstalled
    #return 1 if not installed  or  0 if installed
    #may used like this
    #isInstalled fish && echo yes || echo no
    return (dpkg-query -W -f '${Status}\n' "$argv[1]" 2>&1|awk '/ok installed/{print 0;exit}{print 1}')
end

function ty
    set PACKAGE_NAME $argv

    if ! command -v $PACKAGE_NAME >/dev/null
        echo "$PACKAGE_NAME not installed"
    else
        echo "$PACKAGE_NAME already installed"
    end
end

function tf
    dpkg-query -l | grep $argv | wc -l
end

function markAsDep -d "mark packages as dependencies"
    source ~/.config/fish/onDemand/packages.fish
    set finalDeps
    for i in $argv
        if string match -q "*,$i,*" $markAsDepIgnoreList
            continue
        else
            set finalDeps $finalDeps $i
        end
    end
    apt-mark auto $finalDeps
end

function app -d "install app from local storage"
    # get all packages names and their dependencies and their dirs
    source ~/.config/fish/onDemand/packages.fish

    if test -z $argv[1]
        echo "please enter package name"
        return
    end
    set deps
    set toInstall
    #loop through given arguments
    for i in $argv
        # set packageToInstall
        if test $i = omf
            if ! test -d $HOME/.config/omf
                cp $repo/offline-repo/omf/config/omf $HOME/.config
            end
            cp $repo/offline-repo/omf/share/omf.zip $HOME/.local/share
            unzip $HOME/.local/share/omf.zip -d $HOME/.local/share/
            cp $repo/offline-repo/omf/omf.fish $HOME/.config/fish/conf.d
            rm $HOME/.local/share/omf.zip
            echo "oh-my-fish installed successfully"
            return
        else if test $i = tealdeer
            cp -r $repo/offline-repo/tealdeer $HOME/
            dpkg -i $HOME/tealdeer/tealdeer_*.deb
            mkdir $HOME/.cache/tealdeer/tldr-pages
            unzip -q $HOME/tealdeer/tldr-pages.zip -d $HOME/.cache/tealdeer/tldr-pages
            rm -r $HOME/tealdeer
            echo \n
            echo "tealdeer installed successfully"
            return
            # else if test -z (echo $$i)
            #     echo "package $i is not found in this offline repo"
            #     return
        else if test $i = hurl
            cp --update $repo/offline-repo/binaries/hurl/bin/* ~/.local/bin
            cp --update $repo/offline-repo/binaries/hurl/compilation/*.fish ~/../usr/share/fish/completions
            cp --update $repo/offline-repo/binaries/hurl/compilation/*.bash ~/../usr/share/bash-completion/completions
            cp --update $repo/offline-repo/binaries/hurl/man/*.1 ~/../usr/share/man/man1
            chmod +x ~/.local/bin/hurl
            chmod +x ~/.local/bin/hurlfmt
            echo "hurl installed successfully"
            return

        else if test $i = httpie
            cp --update $repo/offline-repo/binaries/httpie/bin/http_cli ~/.local/bin/http
            cp --update $repo/offline-repo/binaries/httpie/bin/httpie_cli ~/.local/bin/httpie
            cp --update $repo/offline-repo/binaries/httpie/compilation/*.fish ~/../usr/share/fish/completions
            cp --update $repo/offline-repo/binaries/httpie/compilation/*.bash ~/../usr/share/bash-completion/completions
            cp --update $repo/offline-repo/binaries/httpie/man/*.1 ~/../usr/share/man/man1
            ln -s ~/.local/bin/http ~/.local/bin/https
            chmod +x ~/.local/bin/http
            chmod +x ~/.local/bin/httpie
            echo "httpie installed successfully"
            return

        else if test $i = apkeditor
            cp -r $repo/offline-repo/apkeditor/APKEditor.jar $HOME/.local/bin/
            cp -r $repo/offline-repo/apkeditor/apkeditor $HOME/.local/bin/
            echo \n
            echo "APKEditor installed successfully"
            return

        else
            if string match -q "*-*" $i
                set noDashPkg (string replace -a "-" "" "$i")
                set pkgData (string split "@" $$noDashPkg)
                set packageToInstall $pkgData[1]
                set deps $deps (string split "," $packageToInstall)[1..-2]
                set packagedir $pkgData[2]
            else
                set pkgData (string split "@" $$i)
                set packageToInstall $pkgData[1]
                set deps $deps (string split "," $packageToInstall)[1..-2]
                set packagedir $pkgData[2]
            end
        end
        # find the package and install it
        mkdir $HOME/temp
        if test ! -d $HOME/temp/$packagedir
            cp -r $repo/offline-repo/$packagedir $HOME/temp
        end
        for package in (string split , $packageToInstall)
            #find libs debs because they are located in separate directory
            if string match -q "*,$package,*" $libs[1] && find "$HOME/temp" -type f -name "$package\_*.deb"
                find $repo/offline-repo/libs -name "$package\_*.deb" | while read -l pkg
                    cp $pkg $HOME/temp
                    set toInstall $toInstall $pkg
                end
            end
            find $HOME/temp/$packagedir -name "$package\_*.deb" | while read pkg
                # find $repo/offline-repo/$packagedir -name "$package\_*.deb" | while read pkg
                # dpkg -i $pkg
                set toInstall $toInstall $pkg
            end
        end
    end
    dpkg -i $toInstall
    markAsDep $deps
    rm -r $HOME/temp
end


function apprm -d "remove packages and all thair dependencies"
    source ~/.config/fish/onDemand/packages.fish
    set -l toremove

    for package in $argv
        set raw (string split "@" $$package)[1]
        set -l pack (echo $raw | string split ",")
        set -l reversePack (echo $pack[-1..2])
        set toremove $toremove $reversePack
    end
    set toremoveFormatted
    for indivisualPkg in (string split " " $toremove)
        set toremoveFormatted $toremoveFormatted $indivisualPkg

    end

    # echo $toremoveFormatted
    dpkg -r $toremoveFormatted
end


function appremove -d "remove packages and all thair dependencies"
    #not stable sometimes gives some package that are needed by other installed program
    #but thanks to dpkg it won't let remove package needed by another package
    set toremove

    # list all installed pkgs
    set list (printf %s (dpkg --get-selections | string replace "install" "" |sed  ':a;N;$!ba;s/\n/,/g' | sed "s/\s//g"))
    #add comma to the end and the start of lsed -i "/Lsed -i "/Listing.../d"isting.../d"ist
    set list ",$list"
    set list "$list,"

    #====================================

    for argument in $argv
        if test $argument = omf
            rm -r $HOME/.config/fish/conf.d/omf.fish
            rm -r $HOME/.config/omf
            rm -rf $HOME/.local/share/omf
            echo "oh-my-fish removed successfully!"
            return
        end
        if test $argument = apkeditor
            cp $repo/offline-repo/aapkeditor/* $HOME/.local/bin/
            echo "apkeditor removed successfully!"
            return
        end

        if string match -q "*,$argument,*" $list

            #list pkg dependencies
            set dependencies (trimdbnstring dbn $argument)
            #check if dependencies has other programs need's it
            for dependency in (string split "," $dependencies)
                #============================
                #remove dependencies
                set rdps (trimdbnstring rdbn $dependency)
                set rdps (printf %s $rdps | sed "s/$argument//" | sed "s/,,/,/g")
                #if reverse dependency contain one of dependencies of package that you want remove  then remove that string

                set list (string replace ",$dependency," "," $list)
                set canBeRemoved true
                for reverseDependency in (string split "," $rdps)
                    if string match -q "*,$reverseDependency,*" $list
                        set canBeRemoved false
                        break
                    end
                end
                if string match -q "*$dependency*" $toremove
                    set notExisting false
                else
                    set notExisting true
                end
                if $canBeRemoved; and $notExisting
                    set toremove $toremove $dependency
                end

                #remove sub dependencies
                set subDebs (trimdbnstring dbn $dependency)
                for subdeb in (string split "," $subDebs)
                    set rsubdps (trimdbnstring rdbn $subdeb)
                    #if reverse dependency contain one of dependencies of package that you want remove  then remove that string
                    set list (string replace ",$subdeb," "," $list)
                    set subCanBeRemoved true
                    # echo $rsubdps
                    for reverseSubDependency in (string split "," $rsubdps)
                        if string match -q "*,$reverseSubDependency,*" $list
                            set subCanBeRemoved false
                            break
                        end
                    end

                    #make sure there no duplucates pkgs
                    if string match -q "*$subdeb*" $toremove
                        set notExisting false
                    else
                        set notExisting true
                    end
                    if $subCanBeRemoved; and $notExisting
                        set toremove $toremove $subdeb
                    end
                end
                #=======================
            end
            set toremove $toremove $argument

        else
            echo " $argument is not even installed!"
        end
    end
    echo "remove this"
    echo $toremove
    # pkg uninstall $toremove
    # dpkg -r $toremove
end





# function appu --description "uninstall packages with all dependencies"
#   set pkgtorm (string split , $$argv)
#   # string replace -a "liblzma" "" $pkgtorm
#   pkg uninstall (echo $pkgtorm | string replace "liblzma" "")
# end




# make folder called new and put all updated packages inside it
# and put pkgs inside theme
function updateOfflineRepo
    set repodir $repo/offline-repo
    command mkdir -p new
    cp $HOME/../../cache/apt/archives/*.deb ./new
    set -l pkgs ""
    # extract package name from new dir
    find "./new/" -name "*.deb" | while read -l fullnewPkg
        set nonew (string replace "./new/" "" $fullnewPkg)
        set newpkg (string replace -r "_(.)*.deb" "" $nonew)
        set pkgs "$pkgs,$newpkg"
    end
    # copy all matching dirs
    set dirstocopy
    set dirstoloop ","
    set curdir (pwd)
    for i in (string split , $pkgs)
        find $repodir -name "$i\_*.deb" | while read -l pkg
            set repoPkgDir (echo $pkg | awk -F/ '{nlast = NF -1;print $nlast}')
            #this is neat way to get file parent dir but i have no time to work it out
            # set repoPkgDir (dirname $pkg )
            if string match -q "*$repoPkgDir*" $dirstocopy
                #do nothing
            else
                set dirstoloop "$dirstoloop,$curdir/$repoPkgDir"
                set dirstocopy $dirstocopy $repodir/$repoPkgDir
            end
        end
    end
    cp $dirstocopy ./
    #remove the first comma in the string
    set dirstoloop (string replace ",," "" $dirstoloop)

    set copyed
    for olddir in (string split , $dirstoloop)
        for i in (string split , $pkgs)
            find $olddir -name "$i\_*.deb" | while read -l pkg
                if test -f $pkg
                    rm $pkg
                    set npkg (find "./new" -name "$i\_*.deb")
                    # cp -f $npkg $olddir
                    cp --update $npkg $olddir
                    if string match -q "*$npkg*" $copyed
                        #do nothing
                    else
                        set copyed "$copyed,$npkg"
                    end
                end
            end
        end
    end
    #remove debs after done copying
    for i in (string split "," $copyed)
        # grep $i | rm
        rm $i
    end
end

function dbni -d "get the list of installed packages the depend on this package"
    set list (printf %s (dpkg --get-selections | string replace "install" "" |sed  ':a;N;$!ba;s/\n/,/g' | sed "s/\s//g"))
    #add comma to the end and the start of lsed -i "/Lsed -i "/Listing.../d"isting.../d"ist
    set list ",$list"
    set list "$list,"
    set installed
    set deps (trimdbnstring rdbn $argv)
    for dep in (string split "," $deps)
        if string match -q "*,$dep,*" $list
            set installed "$installed $dep"
        end
    end
    echo "the following installed packages require $argv[1]"
    echo $installed
end


function trimdbnstring
    #first argument dbn or rdbn
    #second is package name
    printf %s ($argv[1] $argv[2]| sed  "/Recommends/d" \
    |  sed  "/Suggests/d" \
    |  sed  "/Replaces/d" \
    |  sed  "/Breaks/d" \
    |  sed  "/Reverse/d" \
    |  sed  "/Conflicts/d" \
    |  sed  "s/Depends://" \
    |  sed  "1d" \
    |  sed  -E "s/\((.*?)\)//g" \
    |  sed  's/^[[:blank:]]*//g' \
    |  sed  ':a;N;$!ba;s/\n/,/g' \
    |  sed  's/ //g')
end



function trimdpntxt
    sed -i /Recommends/d $argv
    sed -i /Suggests/d $argv
    sed -i /Replaces/d $argv
    sed -i /Breaks/d $argv
    sed -i /Reverse/d $argv
    sed -i /Conflicts/d $argv
    sed -i "s/Depends://" $argv
    #remove firstline
    sed -i 1d $argv
    # remove tags
    sed -i -E "s/\((.*?)\)//g" $argv
    #remove white space at the start of the lines
    sed -i 's/^[[:blank:]]*//g' $argv
    #replace newline with space
    # sed -i ':a;N;$!ba;s/\n/ /g' $argv

    sed -i ':a;N;$!ba;s/\n/,/g' $argv
    sed -i 's/ //g' $argv
end

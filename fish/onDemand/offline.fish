
set -xU repo /storage/0A56-1B19/backup/Termux
source ~/.config/fish/onDemand/packages.fish


function app
    set toInstall
    #loop through given arguments
    for i in $argv
        # set packageToInstall
        switch $i
            case cmake
                set packageToInstall = $cmake
                set packagedir cmake
            case pkgUpdate
                set packageToInstall = $pkgUpdate
                set packagedir pkgUpdate
            case make
                set packageToInstall = $make
                set packagedir make
            case fish
                set packageToInstall = $fish
                set packagedir fish
            case neovim
                set packageToInstall = $neovim
                set packagedir neovim
            case lua
                set packageToInstall = $lua
                set packagedir lua
            case lua-language-server
                set packageToInstall = $luaLanguageServer
                set packagedir coding
            case shfmt
                set packageToInstall = $shfmt
                set packagedir coding
            case stylua
                set packageToInstall = $stylua
                set packagedir coding
            case nodejs
                set packageToInstall = $nodejs
                set packagedir nodejs
            case tree
                set packageToInstall = $tree
                set packagedir tree
            case aria2
                set packageToInstall = $aria2
                set packagedir aria2
            case newsboat
                set packageToInstall = $newsboat
                set packagedir newsboat
            case gnupg
                set packageToInstall = $gnupg
                set packagedir gnupg
            case imagemagick
                set packageToInstall = $imagemagick
                set packagedir imagemagick
            case openssh
                set packageToInstall = $openssh
                set packagedir openssh
            case openssl
                set packageToInstall = $openssl
                set packagedir openssl
            case openssltool or case openssl-tool
                set packageToInstall = $openssltool
                set packagedir openssl-tool
            case libqrencode
                set packageToInstall = $libqrencode
                set packagedir libqrencode
            case w3m
                set packageToInstall = $w3m
                set packagedir w3m
            case exa
                set packageToInstall = $exa
                set packagedir eza
            case eza
                set packageToInstall = $eza
                set packagedir eza
            case fzf
                set packageToInstall = $fzf
                set packagedir fzf
            case fastfetch
                set packageToInstall = $fastfetch
                set packagedir fastfetch
            case ripgrep
                set packageToInstall = $ripgrep
                set packagedir ripgrep
            case rsync
                set packageToInstall = $rsync
                set packagedir rsync
            case termuxapi or case termux-api
                set packageToInstall = $termuxapi
                set packagedir termuxapi
            case emacs
                set packageToInstall = $emacs
                set packagedir emacs
            case wget
                set packageToInstall = $wget
                set packagedir wget
            case osspuuid or case ossp-uuid
                set packageToInstall = $osspuuid
                set packagedir ossp-uuid
            case xmlstarlet
                set packageToInstall = $xmlstarlet
                set packagedir xmlstarlet
            case starship
                set packageToInstall = $starship
                set packagedir starship
            case fd
                set packageToInstall = $fd
                set packagedir a_semi_dependent
            case bat
                set packageToInstall = $bat
                set packagedir a_semi_dependent
            case zoxide
                set packageToInstall = $zoxide
                set packagedir a_semi_dependent
            case duf
                set packageToInstall = $duf
                set packagedir a_semi_dependent
            case dua
                set packageToInstall = $dua
                set packagedir a_semi_dependent
            case hugo
                set packageToInstall = $hugo
                set packagedir a_semi_dependent
            case p7zip
                set packageToInstall = $p7zip
                set packagedir a_semi_dependent
            case zip
                set packageToInstall = $zip
                set packagedir zip
            case unrar
                set packageToInstall = $unrar
                set packagedir all
            case git
                set packageToInstall = $git
                set packagedir git
            case sift
                set packageToInstall = $sift
                set packagedir a_semi_dependent
            case ccrypt
                set packageToInstall = $ccrypt
                set packagedir a_semi_dependent
            case jq
                set packageToInstall = $jq
                set packagedir jq
            case strace
                set packageToInstall = $strace
                set packagedir strace
            case shfmt
                mkdir $HOME/.local/bin
                cp $repo/offline-repo/shfmt/bin/shfmt $HOME/.local/bin
                echo "shfmt installed successfully"
                return
            case omf
                if ! test -d $HOME/.config/omf
                    cp $repo/offline-repo/omf/config/omf $HOME/.config
                end
                cp $repo/offline-repo/omf/share/omf.zip $HOME/.local/share
                unzip $HOME/.local/share/omf.zip -d $HOME/.local/share/
                cp $repo/offline-repo/omf/omf.fish $HOME/.config/fish/conf.d
                rm $HOME/.local/share/omf.zip
                echo "oh-my-fish installed successfully"
                return
            case tealdeer
                cp -r $repo/offline-repo/tealdeer $HOME/
                dpkg -i $HOME/tealdeer/tealdeer_*.deb
                mkdir $HOME/.cache/tealdeer/tldr-pages
                unzip -q $HOME/tealdeer/tldr-pages.zip -d $HOME/.cache/tealdeer/tldr-pages
                rm -r $HOME/tealdeer
                echo \n
                echo "tealdeer installed successfully"
                return
            case ""
                echo "please enter package name"
        end

        # find the package and install it 
        mkdir $phone/temp
        if test ! -d $phone/temp/$packagedir
            cp -r $repo/offline-repo/$packagedir $phone/temp
        end
        for package in (string split , $packageToInstall)
            #find libs debs because they are located in separate directory
            if string match -q "*,$package,*" $libs
                find $repo/offline-repo/libs -name "$package\_*.deb" | while read -l pkg
                    cp $pkg $phone/temp
                    set toInstall $toInstall $pkg
                end
            end
            find $phone/temp/$packagedir -name "$package\_*.deb" | while read pkg
                # find $repo/offline-repo/$packagedir -name "$package\_*.deb" | while read pkg
                # dpkg -i $pkg
                set toInstall $toInstall $pkg
            end
        end
    end
    dpkg -i $toInstall
    rm -r $phone/temp
end


function appremove
    for package in $argv
        set toremove
        for i in (string split ',' $$package)
            set toremove $toremove $i
        end
    end
    dpkg -r $toremove
end


function apprm -d "remove packages and all thair dependencies"
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
                    cp $npkg $olddir
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

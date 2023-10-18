
set -xU repo "/storage/0A56-1B19/backup/Termux"
source ~/.config/fish/onDemand/packages.fish


function app
  #loop through given arguments
  for i in $argv
    # set packageToInstall
    switch $i
      case "cmake"
        set packageToInstall = $cmake
        set packagedir "cmake"
      case "make"
        set packageToInstall = $make
        set packagedir "make"
      case "gnupg"
        set packageToInstall = $gnupg
        set packagedir "gnupg"
      case "imagemagick"
        set packageToInstall = $imagemagick
        set packagedir "imagemagick"
      case "openssh"
        set packageToInstall = $openssh
        set packagedir "openssh"
      case "openssl"
        set packageToInstall = $openssl
        set packagedir "openssl"
      case "openssltool" or case "openssl-tool"
        set packageToInstall = $openssltool
        set packagedir "openssl-tool"
      case "libqrencode"
        set packageToInstall = $libqrencode
        set packagedir "libqrencode"
      case "w3m"
        set packageToInstall = $w3m
        set packagedir "w3m"
      case "exa"
        set packageToInstall = $exa
        set packagedir "eza"
      case "eza"
        set packageToInstall = $eza
        set packagedir "eza"
      case "fzf"
        set packageToInstall = $fzf
        set packagedir "fzf"
      case "ripgrep"
        set packageToInstall = $ripgrep
        set packagedir "ripgrep"
      case "termuxapi" or case "termux-api"
        set packageToInstall = $termuxapi
        set packagedir "termuxapi"
      case "emacs"
        set packageToInstall = $emacs
        set packagedir "emacs"
      case "wget"
        set packageToInstall = $wget
        set packagedir "wget"
      case "osspuuid" or case "ossp-uuid" 
        set packageToInstall = $osspuuid
        set packagedir "ossp-uuid"
      case "xmlstarlet"
        set packageToInstall = $xmlstarlet
        set packagedir "xmlstarlet"
      case "starship"
        set packageToInstall = $starship
        set packagedir "starship"
      case "fd"
        set packageToInstall = $fd
        set packagedir "a_semi_dependent"
      case "bat"
        set packageToInstall = $bat
        set packagedir "a_semi_dependent"
      case "hugo"
        set packageToInstall = $hugo
        set packagedir "a_semi_dependent"
      case "p7zip"
        set packageToInstall = $p7zip
        set packagedir "a_semi_dependent"
      case "zip"
        set packageToInstall = $zip
        set packagedir "zip"
      case "git"
        set packageToInstall = $git
        set packagedir "git"
      case "sift"
        set packageToInstall = $sift
        set packagedir "a_semi_dependent"
      case "ccrypt"
        set packageToInstall = $ccrypt
        set packagedir "a_semi_dependent"
      case "jq"
        set packageToInstall = $jq
        set packagedir "a_semi_dependent"
      case "strace"
        set packageToInstall = $strace
        set packagedir "a_semi_dependent"
      case "shfmt"
        mkdir $HOME/.local/bin
        cp $repo/offline-repo/shfmt/bin/shfmt $HOME/.local/bin
        echo "shfmt installed successfully"
        return
      case ""
        echo "please enter package name"
    end

    # find the package and install it 
    mkdir $phone/temp
    cp -r $repo/offline-repo/$packagedir $phone/temp
    for package in (string split , $packageToInstall)
      find $phone/temp/$packagedir -name "$package\_*.deb" | while read pkg
      # find $repo/offline-repo/$packagedir -name "$package\_*.deb" | while read pkg
      dpkg -i $pkg
    end
  end
  rm -r $phone/temp
end
end

function appu --description "uninstall packages with all dependencies"
  set pkgtorm (string split , $$argv)
  # string replace -a "liblzma" "" $pkgtorm
  pkg uninstall (echo $pkgtorm | string replace "liblzma" "")
end


# make to folder on called old and the other new
# and put pkgs inside theme
function updateorepo
  set -l pkgs "ncurses,ncurses-utils,readline,termux-am-socket,termux-keyring,libbz2,bzip2,libgmp,coreutils,openssl,openssl-tool,ca-certificates,zlib,libnghttp2,libcurl,curl,dash,diffutils,findutils,libmpfr,gawk,grep,gzip,procps,psmisc,sed,libandroid-glob,tar,termux-am,termux-exec,liblzma,xz-utils,termux-tools,bash,dpkg,termux-licenses,libcrypt,libgpg-error,libgcrypt,pcre2,busybox,command-not-found,dos2unix,exa,fzf,inetutils,libpng,libqrencode,libtirpc,libunbound,unbound,neovim,net-tools,starship,termux-api,unzip"
  for i in (string split , $pkgs)
    find "./old" -name "$i\_*.deb" | while read -l pkg
    if test -f $pkg
      rm $pkg
      set npkg (find "./new" -name "$i\_*.deb")
      mv $npkg "./newd"
    end
  end
end

end

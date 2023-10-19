
set -xU repo "/storage/0A56-1B19/backup/Termux"
source ~/.config/fish/onDemand/packages.fish


function app
  set toInstall
  #loop through given arguments
  for i in $argv
    # set packageToInstall
    switch $i
      case "cmake"
        set packageToInstall = $cmake
        set packagedir "cmake"
      case "pkgUpdate"
        set packageToInstall = $pkgUpdate
        set packagedir "pkgUpdate"
      case "make"
        set packageToInstall = $make
        set packagedir "make"
      case "fish"
        set packageToInstall = $fish
        set packagedir "fish"
      case "neovim"
        set packageToInstall = $neovim
        set packagedir "neovim"
      case "lua"
        set packageToInstall = $lua
        set packagedir "lua"
      case "tree"
        set packageToInstall = $tree
        set packagedir "tree"
      case "aria2"
        set packageToInstall = $aria2
        set packagedir "aria2"
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
      case "fastfetch"
        set packageToInstall = $fastfetch
        set packagedir "fastfetch"
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
        set packagedir "jq"
      case "strace"
        set packageToInstall = $strace
        set packagedir "strace"
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
      # dpkg -i $pkg
      set toInstall $toInstall $pkg
    end
  end
end
 dpkg -i $toInstall
rm -r $phone/temp
end



function appu --description "uninstall packages with all dependencies"
  set pkgtorm (string split , $$argv)
  # string replace -a "liblzma" "" $pkgtorm
  pkg uninstall (echo $pkgtorm | string replace "liblzma" "")
end


# make to folder on called old and the other new
# and put pkgs inside theme
function updaterepo
  # here type downloaded packges
  set -l pkgs "plallapla"
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

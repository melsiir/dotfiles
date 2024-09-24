
function bconfig
    if test -f $HOME/storage/downloads/myConfig.zip
        rm -r $HOME/storage/downloads/myConfig.zip
    end
    set -l cdir (pwd)
    mkdir $HOME/tmp
    mkdir $HOME/tmp/home
    mkdir $HOME/tmp/config
    mkdir $HOME/tmp/packages
    if test -f $HOME/.bashrc
        cp $HOME/.bashrc $HOME/tmp/home/
    end
    cp -r $HOME/.termux $HOME/tmp/home/
    rm $HOME/tmp/home/.termux/*.ttf
    rm $HOME/tmp/home/.termux/shell
    cp -r $HOME/.ssh $HOME/tmp/home/
    cp $HOME/.gitconfig $HOME/tmp/home/
    cp $HOME/.gitignore $HOME/tmp/home/
    cp -r $HOME/.config/* $HOME/tmp/config
    cd $HOME/.config
    zip -qr git.zip .git
    mv $HOME/.config/git.zip $HOME/tmp/config
    cp -r $HOME/.stuff $HOME/tmp/home/
    cp $HOME/../usr/var/lib/apt/lists/* $HOME/tmp/packages
    cd $HOME/tmp
    zip -qr myConfig.zip *
    # zip myConfig.zip .bashrc .ssh 
    cp -f myConfig.zip $HOME/storage/downloads/
    cd $cdir
    rm -rf $HOME/tmp
end

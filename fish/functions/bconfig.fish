
function bconfig
    if test -f $HOME/storage/downloads/myConfig.zip
        rm -r $HOME/storage/downloads/myConfig.zip
    end
     set -l cdir (pwd)
    mkdir $HOME/tmp
    cp -r $HOME/.config/* $HOME/tmp
    cd $HOME/.config
    zip -r git.zip .git
    mv $HOME/.config/git.zip $HOME/tmp
    cp -r $HOME/.stuff/keys $HOME/tmp/keys
    cd $HOME/tmp
    zip -r myConfig.zip *
    cp myConfig.zip $HOME/storage/downloads/
    cd $cdir
    rm -rf $HOME/tmp
end


function bconfig
    if test -f $HOME/storage/downloads/myConfig.zip
        rm -r $HOME/storage/downloads/myConfig.zip
    end
     set -l cdir (pwd)
    mkdir $HOME/tmp
    cp -r $HOME/.config/* $HOME/tmp
    cp -r $HOME/.keys $HOME/tmp/keys
    cd $HOME/tmp
    zip -r myConfig.zip *
    cp myConfig.zip $HOME/storage/downloads/
    cd $cdir
    rm -r $HOME/tmp
end

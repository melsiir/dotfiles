function blocal
    if test -d $HOME/storage/downloads/mylocal.zip
        rm -r $HOME/storage/downloads/mylocal.zip-
    end
    set -l cdir (pwd)
    cd $HOME
    zip -r mylocal.zip .local
    cp -r $HOME/mylocal.zip $HOME/storage/downloads/
    cd $cdir
    rm $HOME/mylocal.zip
end

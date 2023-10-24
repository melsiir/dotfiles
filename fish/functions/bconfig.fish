
function bconfig
  if test -f $HOME/storage/downloads/myConfig.zip
    rm -r $HOME/storage/downloads/myConfig.zip
  end
  set -l cdir (pwd)
  mkdir $HOME/tmp
  if test -f $HOME/.bashrc
    cp $HOME/.bashrc $HOME/tmp
  end
  cp -r $HOME/.config/* $HOME/tmp
  cd $HOME/.config
  zip -r git.zip .git
  mv $HOME/.config/git.zip $HOME/tmp
  cp -r $HOME/.stuff/keys $HOME/tmp/keys
  cd $HOME/tmp
  zip -r myConfig.zip *
  zip myConfig.zip .bashrc
  cp -f myConfig.zip $HOME/storage/downloads/
  cd $cdir
  rm -rf $HOME/tmp
end


function bconfig
  if test -f $HOME/storage/downloads/myConfig.zip
    rm -r $HOME/storage/downloads/myConfig.zip
  end
  set -l cdir (pwd)
  mkdir $HOME/tmp
  mkdir $HOME/tmp/packages
  if test -f $HOME/.bashrc
    cp $HOME/.bashrc $HOME/tmp
  end
  cp -r $HOME/.config/* $HOME/tmp
  cd $HOME/.config
  zip -r git.zip .git
  mv $HOME/.config/git.zip $HOME/tmp
  cp -r $HOME/.stuff/keys $HOME/tmp/keys
  cp $HOME/../usr/var/lib/apt/lists/packages-cf.termux.dev_apt_termux-main_dists_stable_InRelease $HOME/tmp/packages
  cp $HOME/../usr/var/lib/apt/lists/packages-cf.termux.dev_apt_termux-main_dists_stable_main_binary-arm_Packages $HOME/tmp/packages
  cd $HOME/tmp
  zip -r myConfig.zip *
  zip myConfig.zip .bashrc
  cp -f myConfig.zip $HOME/storage/downloads/
  cd $cdir
  rm -rf $HOME/tmp
end

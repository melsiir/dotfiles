function mkfile
set sp (string split -r -m1 / $argv)
set last  $sp[-1]
set dir (string replace $last  $sp)
if [ -d $dir ]
touch $argv
end
if [ ! -d $dir ]
mkdir -p $dir
touch $argv
end
end

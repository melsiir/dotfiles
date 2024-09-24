function permission-reset
 sudo chown -R 10300:10300 $argv;
find $argv -type d -print0 | xargs -0 chmod 700;
find $argv -type f -print0 | xargs -0 chmod 600;
end

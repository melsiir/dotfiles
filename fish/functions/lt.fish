function lt --wraps=lite-server
    if [ $argv ]
        cd $argv && lite-server
    else
        lite-server
    end
end

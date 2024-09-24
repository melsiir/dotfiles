# set list (printf %s (cat ./bitward.csv ))
function gpass -d "cheap password manager"
    if test (count $argv) -eq 0
        echo "Please Enter username or email adress!"
        echo "you can try gpass gmail username"
        return
    end
    set sourcePass $HOME/storage/external-1/../../../../DCIM/bitwarden.csv
    command cp -rf $sourcePass $HOME/../usr/tmp
    # set passfile $phone/Aaaa/bitward.csv
    set passfile $HOME/../usr/tmp/bitwarden.csv
    set linenumber (grep -in $argv[1] $passfile | cut -d':' -f1)
    if test (count $linenumber) -eq 0
        echo "entery does not exist!"
        return
    else if test (count $linenumber ) -eq 1
        set passline (sed -n {$linenumber}p $passfile)
        set passArray
        for i in (string split ","  $passline)
            set passArray $passArray $i
        end
        echo \n
        echo "Link:    $passArray[4]"
        echo "Email:    $passArray[9]"
        echo "Password:    $passArray[10]"
        echo "email@password"
        echo "$passArray[9]@$passArray[10]"
        echo \n
        return
    else
        set 2dentry (sed -n {$linenumber[2]}p $passfile)
        if string match -q "*$argv[1]*" $2dentry
            if string length -q $argv[2]
                for k in $linenumber
                    if string match -q "*$argv[2]*" (sed -n {$k}p $passfile)
                        set passline (sed -n {$k}p $passfile)
                        set passArray
                        for i in (string split ","  $passline)
                            set passArray $passArray $i
                        end
                        echo \n
                        echo " Link:    $passArray[4]"
                        echo " Email:    $passArray[9]"
                        echo " Password:    $passArray[10]"
                        echo " email@password"
                        echo " $passArray[9]@$passArray[10]"
                        echo \n
                    end
                end
            else
                for j in $linenumber
                    set passline (sed -n {$j}p $passfile)
                    set passArray
                    for i in (string split ","  $passline)
                        set passArray $passArray $i
                    end
                    echo \n
                    echo " Link:    $passArray[4]"
                    echo " Email:    $passArray[9]"
                    echo " Password:    $passArray[10]"
                    echo " email@password"
                    echo " $passArray[9]@$passArray[10]"
                    echo \n
                end
            end
        end
    end
end

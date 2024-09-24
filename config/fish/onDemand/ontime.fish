
# functiom i use it only one time but keeping just in case i need it
#
#
# rename some web links to appropriate formate

function changeNameBySplit -d "change the name of bulk files into valid extention"

    #you can name something like this
    #render.json?markdownPath=reference&markdownPath=react-dom&markdownPath=render
    #into
    #render.json
    #if you use ? as delemiter
    # if the delemiter is special charactor make sure to scape it with  \
    #run this function inside direcotry which had alot of wierd nes
    #in this case  ? is the separator but change it to what what ever you  wantt


    ls | while read -l line
        if string match -qr "\?" $line
            set sname (string split "?" $line )
            mv $line $sname[1]
        end
    end
end

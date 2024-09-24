
## print the the first line from file

head -1 file
sed -n 1 file
awk "NR == 1" test.txt

## print from line 1 to line 50 from file

head -50 file
sed -n 1,50p file

## remove the first line

sed -i '1d' file

## remove last line

sed -i '$d' file

## remove from 5th line to the last line

sed -i '5,$d' file

## remove all empty lines

sed -i '/^$/d' filename

## remove line contain word panther

sed -i "/panther/d"

## remove line start with word panther

sed -i "/^panther/d"

## remove line end with word panther

sed -i "/panther$/d"

## replace text at specific line

replace at line 3

sed -i "3s/cool/nice/" file.txt

## replace every line contain dog with cat

sed -i '/\bdog\b/c\cat' file.txt

## sort lines in text file alphabiticaly

sort file.txt
or you can pip the stdout into othe file
sort file.txt > file2.txt

## in fish you want find file and do something withit use read -l instead of read -r

## return only line contain .deb

sift  "_(.*?).deb" file1.txt > file2.txt

## selecting from certain charactar to end of something

## usefull with nvim replace and maybe sed

for example replace for the _sign to .deb
_.*.deb
ncurses_6.4.20231001-1_arm.deb
the result after replacing selection with whitespace:
ncurses

## get parent dir for file

dirname $HOME/accounting/account.csv

approximate result
$HOME/accounting

## extract the file name from path

echo ./some/path/file.ext | awk -F/ '{nlast = NF -0;print $nlast}'
the result is file.ext

## get the file perant dir

echo ./some/path/file.ext | awk -F/ '{nlast = NF -1;print $nlast}'
the result is path

## extract the file extention from path or a name

echo ./some/path/file.ext | awk -F. '{nlast = NF -0;print $nlast}'
the result is ext

## print last element of array

someArry[-1]

## make uniqe name

mktemp XXXXXXXX
or
mktemp name.XXXXXXXX

## know the number of items in specific directory

ls -1 | wc -l

## remove duplicate lines from text file

sort file.txt | uniq >> uulist.txt

rename  "image?url=%2F_next%2Fstatic%2Fmedia%2" "" image*

this will rename any file and replace the name image?url=%2F_next%2Fstatic%2Fmedia%2 with nothing "" or id if used "id" for each it contain the wors image at the begening of its name image*or at the meddle if set to *image*  or in the end if set to*image

## remove colors from log files

sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g'

live-server | sed 's/\x1B\[[0-9;]\{1,\}[A-Za-z]//g'

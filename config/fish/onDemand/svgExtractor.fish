
function convertsvg
  # work with standerd svg structure
  mkdir svg
  cp $argv[1] svg/$argv[1]
  # replace new line with space
  sed -i ':a;N;$!ba;s/\n/ /g' ./svg/$argv[1]
  sed -i "s/<svg/\n<svg/g" ./svg/$argv[1]
  sed -i "s/<\/svg>/<\/svg>\n/g" ./svg/$argv[1]
  # remove first line
  sed -i '1d' ./svg/$argv[1]
  sed -i '$d' ./svg/$argv[1]
  # only enable when svg stored in p structure not svg structure
  # sed -i "s/<g/\n<g/g" ./svg/$argv[1]
  sift -m  --only-matching '<svg\s?\S?(..)*<\/svg>' ./svg/$argv[1] | while read result; echo $result > ./svg/(random)(random)(random).svg; end
  cd svg
  clnsvg
  cd ..
  rm svg/$argv[1]
end

function mega
  # this one dont use sift
  # work with standerd svg structure
  mkdir svg
  cp $argv[1] svg/$argv[1]
  # for now replace newline manually using any text editor
  # the regex expression for newline is \n

  sed -i ':a;N;$!ba;s/\n/ /g' ./svg/$argv[1]
  sed -i "s/<view/\n<view/g" ./svg/$argv[1]
  sed -i "s/<\/view>/<\/view>\n/g" ./svg/$argv[1]
  # remove first line
  sed -i '1d' ./svg/$argv[1]
  sed -i '$d' ./svg/$argv[1]
  # only enable when svg stored in p structure not svg structure
  # sed -i "s/<g/\n<g/g" ./svg/$argv[1]
  cat  ./svg/$argv[1] | while read -l line
  set name ./svg/(random)(random)(random).svg
  echo $line > $name
end

rm svg/$argv[1]
cd svg
clnsvg
renameMega
cd ..
 end

 function renameMega
   ls | while read -l file 
   sed -i "s/<svg/\n<svg/g" $file
   sed -i "s/<\/svg>/<\/svg>\n/g" $file
   #extract id
   set ido (grep -o 'id="[^"]*"' $file | cut -d '"' -f2  )
   # remove first line
   sed -i '1d' $file 
   sed -i '$d' $file
   sed -i "s/</\n</g" $file
   sed -i "s/xlink\://g" $file
   mv $file $ido[1].svg
 end
end

function renameById
  find . -type f -name "*.svg"  | while read -l file 
  # #extract id
  set ido (grep -o 'id="[^"]*"' $file | cut -d '"' -f2  )
  mv $file $ido[1].svg
end
end

function renameByClass
  find . -type f -name "*.svg"  | while read -l file 
  # #extract id
  set ido (grep -o 'class="[^"]*"' $file | cut -d '"' -f2  )
  mv $file $ido[1]-(random).svg
end
end


function getsvg
  # this one dont use sift
  # work with standerd svg structure
  mkdir svg
  cp $argv[1] svg/$argv[1]
  # for now replace newline manually using any text editor
  # the regex expression for newline is \n

  sed -i ':a;N;$!ba;s/\n/ /g' ./svg/$argv[1]
  sed -i "s/<svg/\n<svg/g" ./svg/$argv[1]
  sed -i "s/<\/svg>/<\/svg>\n/g" ./svg/$argv[1]
  # remove first line
  sed -i '1d' ./svg/$argv[1]
  sed -i '$d' ./svg/$argv[1]
  # only enable when svg stored in p structure not svg structure
  # sed -i "s/<g/\n<g/g" ./svg/$argv[1]
  cat  ./svg/$argv[1] | while read -l line
  set name ./svg/(random)(random)(random).svg
  echo $line > $name
  sed -i "s/</\n</g" $name
  sed -i "s/xlink\://g" $name
end
cd svg
clnsvg
cd ..
rm svg/$argv[1]
 end

 function convertgsvg
   # work with cases when the svgs are betwen <g> tag instead
   # of normal svg tag
   # except 2 parameters file name and the size of svg ex 48
   mkdir svg
   cp $argv[1] svg/$argv[1]
   sed -i ':a;N;$!ba;s/\n/ /g' ./svg/$argv[1]
   sed -i "s/<svg/\n<svg/g" ./svg/$argv[1]
   sed -i "s/<\/svg>/<\/svg>\n/g" ./svg/$argv[1]
   # remove first line
   sed -i '1d' ./svg/$argv[1]
   sed -i "s/<g/\n<g/g" ./svg/$argv[1]
   sed -i '$d' ./svg/$argv[1]

   # extract svgs from g tags
   sift -m  --only-matching '<g\s?\S?(..)*<\/g>' ./svg/$argv[1] | while read result;
   echo '<svg xmlns="http://www.w3.org/2000/svg" height="'$argv[2]'" width="'$argv[2]'" viewBox="0 0 '$argv[2] $argv[2]'" >'$result'</svg>' > ./svg/(random)(random)(random).svg;
 end
 rm ./svg/$argv[1]
end

function formatforgsvg
  mkdir svg
  cp $argv[1] svg/$argv[1]
  sed -i ':a;N;$!ba;s/\n/ /g' ./svg/$argv[1]
  sed -i "s/<svg/\n<svg/g" ./svg/$argv[1]
  sed -i "s/<\/svg>/<\/svg>\n/g" ./svg/$argv[1]
  # remove first line
  sed -i '1d' ./svg/$argv[1]
  sed -i "s/<g/\n<g/g" ./svg/$argv[1]
  sed -i '$d' ./svg/$argv[1]
end


function gsvg
  # run if html is prepared if not run presvgg
  # except 2 parameters file name and the size of svg ex 48
  sift -m  --only-matching '<g\s?\S?(..)*<\/g>' ./svg/$argv[1] | while read result;
  echo '<svg xmlns="http://www.w3.org/2000/svg" height="'$argv[2]'" width="'$argv[2]'" viewBox="0 0 '$argv[2] $argv[2]'" >'$result'</svg>' > ./svg/(random)(random)(random).svg;
end
rm svg/$argv[1]
end

function appendvb
  ls | while read -l file 
  set width (grep -o 'width="[^"]*"' $file | cut -d '"' -f2  )
  set height (grep -o 'height="[^"]*"' $file | cut -d '"' -f2  )
  set fwidth (string replace px '' $width)
  set fheight (string replace px '' $height)
  sed -i "s/<svg/<svg viewBox=\"0 0 $fwidth $fheight\"/g" $file 
end
end

function popng
  mkdir downloaded
  cp $argv downloaded
  sed -i "s/</\n</g" downloaded/$argv
  sift -m  --only-matching 'src(="(.*?)")' downloaded/$argv | while read result;
  # echo $result | head -n 1 | cut -d'=' -f2 >> x-links.txt
  echo $result  >> x-links.txt
end
sed -i 's/src="//g' x-links.txt
sed -i 's/"$//g' x-links.txt

rm -r downloaded/$argv

# download links
cp x-links.txt downloaded
cd downloaded
cat x-links.txt | while read -l line
curl -O $line
# echo $line
end
cd ..
end

function clnsvg
  # remove and file that don't have svg tag in it
  mkdir safe
  set dir (pwd)
  grep -lir '<svg' $dir  | while read svg; cp "$svg" ./safe;end
  rm *.svg
  cp safe/*.svg ./
  rm -r safe
end

function sp
  rsvg-convert -w $argv[1] -h $argv[2] $argv[3] > $argv[3].png
end

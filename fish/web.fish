#  Calls to various CLI friendly web services
#  
#  Author: [Dmitry](http://dmi3.net) [Source](https://github.com/dmi3/fish)#

#  * `myip` Shows external ip
alias myip='curl ifconfig.co'

#  * `localip` Shows (local) internal ip
# alternative would be `ifdata -pa eth0` from moreutils
alias localip="ip -o route get to 1.1.1.1 | sed -n 's/.*src \([0-9.]\+\).*/\1/p'"

#  * `whereami` is like whoami but shows your external ip and geolocation
alias whereami='curl ifconfig.co/json'

function genname --description "Random name for registration on random websites. How about Helen Lovick? Roger Rice?"
  curl www.pseudorandom.name
end

function genalias --description "Docker-like alias generator: `thirsty_mahavira`, `boring_heisenberg`. Don't know how to name file/project/branch/file? Use this!"
  curl -s https://frightanic.com/goodies_content/docker-names.php | tee /dev/tty | termux-clipboard-set; and echo -e "\ncopied to clipboard"
end

function genemail --description "Random email for registration on random websites. Generate random email in one of Mailinator subdomains and provide link to check it. Useful when <http://bugmenot.com/> is not available."
  set domain (echo -e \
    "notmailinator.com
  veryrealemail.com
  chammy.info
  tradermail.info
  mailinater.com
  suremail.info
  reconmail.com" | shuf -n1)
  set name (curl -s www.pseudorandom.name | string replace ' ' '')
  set email $name@$domain
  printf "$email" | tee /dev/tty | termux-clipboard-set
  echo -e "\ncopied to clipboard\nhttps://www.mailinator.com/v3/index.jsp?zone=public&query=$name#/#inboxpane"
end 

function  genpass --description "Generate random password" --argument-names 'length'
  test -n "$length"; or set length 15
  head /dev/urandom | tr -dc "[:alnum:]~!#\$%^&*-+=?./|" | head -c $length | tee /dev/tty | termux-clipboard-set ; and echo -e "\ncopied to clipboard"
end

function weather --description "Show weather"
  # resize -s $LINES 125
  curl wttr.in/$argv
end

function xsh --description "Prepend this to command to explain its syntax i.e. `xsh iptables -vnL --line-numbers`"
  w3m -o confirm_qq=false "http://explainshell.com/explain?cmd=$argv"
  # replace w3m to any browser like chrome
end

function transfer --description "Upload file to transfer.sh"
  curl --progress-bar --upload-file $argv https://transfer.sh/(basename $argv)   
end

function translate --description "Translate word using [Yandex](https://github.com/dmi3/bin/blob/master/yandex-translate.sh)"
  translate-yandex.sh "$argv"
end

function syn --description "Find synonyms for word"
  test -e ~/.stuff/keys/bighugelabs || echo "Get API key at https://words.bighugelabs.com/account/getkey and put in "(status --current-filename)
  curl http://words.bighugelabs.com/api/2/(cat ~/.stuff/keys/bighugelabs)/$argv/
end

function dictionary --description "search for word in dictionary"
  curl https://api.dictionaryapi.dev/api/v2/entries/en/$argv | jq "" > $HOME/../usr/tmp/text.txt
  set text $HOME/../usr/tmp/text.txt

  # cat $text |  jq ".[0] .word,.[0]  .phonetics[0] .text,.[0]  .phonetics[0] .audio"
  # cat $text | jq ".[0] .meanings[0] .partOfSpeech, .[0] .meanings[0] .definitions[0], .[0] .meanings[0] .definitions[1]"
  # set_color blue;echo "Synonyms"
  # cat $text | jq ".[0] .meanings[0] .synonyms"
  # cat $text | jq ".[0] .meanings[1] .partOfSpeech, .[0] .meanings[1] .definitions[0], .[0] .meanings[0] .definitions[1]"
  # echo "Synonyms"
  # cat $text | jq ".[0] .meanings[1] .synonyms"
  # set_color normal


  cat $text | jq ".[0] .word"
  set_color blue;echo "sound: " (set_color green; cat $text | jq ".[0]  .phonetics[0] .audio")
  set_color blue; echo "pronounciation: " (set_color green; cat  $text | jq ".[0]  .phonetics[0] .text"; set_color normal)
  # cat $text | jq ".[0] .meanings[0] .partOfSpeech, .[0] .meanings[0] .definitions[0], .[0] .meanings[0] .definitions[1]" | string replace "[" "" | string replace "]" "" | string replace "{" "" | string replace "}" "" | string replace -a '"' "" 
  set_color blue;echo "part of speech: " (set_color green;cat $text | jq ".[0] .meanings[0] .partOfSpeech"; set_color normal)
  cat $text | jq ".[0] .meanings[0] .definitions[0], .[0] .meanings[0] .definitions[1]"
  echo \n
  set_color blue;echo "Synonyms: ";set_color normal
  cat $text | jq ".[0] .meanings[0] .synonyms"
  echo \n
  set_color blue; echo "Part of speech" (set_color green;cat $text | jq ".[0] .meanings[1] .partOfSpeech"; set_color normal)
  cat $text | jq ".[0] .meanings[1] .definitions[0], .[0] .meanings[1] .definitions[1]"
  echo \n
  set_color blue;echo "Synonyms: ";set_color normal
  cat $text | jq ".[0] .meanings[1] .synonyms"
end

abbr -ag dic dictionary

function emoji --description "Search emoji by name"
  curl -s -X GET https://www.emojidex.com/api/v1/search/emoji -d code_cont=$argv | jq -r '.emoji | .[] | .moji | select(. != null)' | tr '\n' ' '
end

function waitweb --description 'Wait until web resource is available. Useful when you are waiting for internet to get back, or Spring to start' --argument-names 'url'
  set -q url || set url 'google.com'
  printf "Waithing for the $url"
  while not curl --output /dev/null --silent --head --fail "$url"
    printf '.'
    sleep 10
  end
  printf "\n$url is online!"
  notify-send -u critical "$url is online!"
end

#  * `xkcd` Print color-adjusted xkcd in your terminal! See <https://developer.run/40>
alias xkcd='curl -sL https://c.xkcd.com/random/comic/ | grep -Po "https:[^\"]*" | grep png | xargs curl -s | convert -resize 50% -negate -fuzz 10% -transparent black png: png:- | kitty +kitten icat'

#  * `albumart` Show hi-res album art of currently playing song in Spotify
#    - Requires [sp](https://gist.github.com/wandernauta/6800547)
alias albumart='sp metadata | grep -Po "(?<=url\|).*" | xargs curl -s | grep -Po "https:[^\"]*" | grep "i.scdn.co/image/" | head -1 | xargs curl -s | kitty +kitten icat'


function virustotal --description "Check file hash by virustotal.com"
  test -e ~/.stuff/keys/virustotal || echo "Get API key at https://www.virustotal.com/gui/my-apikey and put in "(status --current-filename)
  curl -sL --request GET \
    --url https://www.virustotal.com/api/v3/files/(sha256sum $argv | cut -f 1 -d " ") \
    --header "x-apikey: "(cat ~/.stuff/keys/virustotal) \
    --header "x-apikey: "(cat ~/.stuff/keys/virustotal) \
    # | jq ".data .attributes .last_analysis_stats, .data .attributes .tags, .data .attributes .total_votes"
  | jq ".data .attributes .last_analysis_stats, .data .attributes .tags, .data .attributes .total_votes, .data .attributes .last_analysis_results .Kaspersky"

  #links
  #jq '.data .attributes .androguard .StringsInformation'
end


function yan --description "Check word in yandex dictionary"
  test -e ~/.stuff/keys/yandex || echo "Get API key at https://yandex.com/dev/dictionary.stuff/keys/get/ and put in ~/.stuff/keys/yandex"
  curl  "https://dictionary.yandex.net/api/v1/dicservice.json/lookup?key=$(cat ~/.stuff/keys/yandex)&lang=en-ru&text=time"
  # | jq ".data .attributes .last_analysis_stats, .data .attributes .tags, .data .attributes .total_votes"
  # |  jq "."
end


function vt-scan
  set dir (pwd)
  set api (cat ~/.stuff/keys/virustotal)
  # cat $api
  set Bash "$HOME/.config/fish/bash"
  chmod 700 $Bash/vt-scan.sh
  ~/.config/fish/bash/vt-scan.sh -k (cat ~/.stuff/keys/virustotal) $argv         
end

# function tempmail
#   curl --request POST \
  #     --url https://temp-mail44.p.rapidapi.com/api/v3/email/new \
  #     --header 'X-RapidAPI-Host: temp-mail44.p.rapidapi.com' \
  #     --header 'X-RapidAPI-Key: 74a5d34881msh5db02856f2ed85bp1a61d9jsne8534c02646e' \
  #     --header 'content-type: application/json' \
  #     --data '{"key1":"value","key2":"value"}'
# end

# function tmread
#   curl --request GET \
  #     --url https://temp-mail44.p.rapidapi.com/api/v3/email/p1amvpvxfh@bestparadize.com/messages \
  #     --header 'X-RapidAPI-Host: temp-mail44.p.rapidapi.com' \
  #     --header 'X-RapidAPI-Key: 74a5d34881msh5db02856f2ed85bp1a61d9jsne8534c02646e'
# end

set mspapi (cat ~/.stuff/keys/mailslurp)

function msp
  # curl -XPOST api.mailslurp.com/createInbox -Hx-api-key:$mspapi

  set RES (curl -sXPOST api.mailslurp.com/createInbox -Hx-api-key:$mspapi)
  set email (echo "$RES" | jq -j '.emailAddress')
  set ID (echo "$RES" | jq -j '.id')
  echo "your new email is ($email | termux-clipboard-set) copyed"
end

function mspsend
  curl -XPOST "api.mailslurp.com/sendEmailQuery?to=$argv[3]&subject=$argv[2]&body=$argv[1]" -Hx-api-key:$mspapi
end


function mspinbox
  curl --request GET \
    --url "https://api.mailslurp.com/inboxes" \
    --header "x-api-key:"(cat ~/.stuff/keys/mailslurp) \
    | jq "."
end

set -l msacApi (cat ~/.stuff/keys/mailsac)

function msacnew
  curl --request POST \
    --url https://mailsac.com/api/addresses/rosewell007 \
    --header 'Mailsac-Key:' $msacApi \
    --header 'content-type: application/json' \
    --data '{"info":"string","forward":"","enablews":false,"webhook":"","webhookSlack":"","webhookSlackToFrom":true}'
end

function msactest
  curl --request GET \
    --url https://mailsac.com/api/me \
    --header 'Mailsac-Key: '(cat ~/.stuff/keys/mailsac)
end

function msacmess
  curl --request GET \
    --url https://mailsac.com/api/addresses/hetoggg6@mailsac.com/messages \
    --header "Mailsac-Key: $msacApi"
end

function msacaddresses
  curl --request GET \
    --url https://mailsac.com/api/addresses \
    --header "Mailsac-Key: $msacApi"
end

function msacdel
  curl --request DELETE \
    --url 'https://mailsac.com/api/addresses/{email}?deleteAddressMessages=SOME_BOOLEAN_VALUE' \
    --header 'Mailsac-Key:'$msacApi
end


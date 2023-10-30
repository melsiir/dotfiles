
function gbat
  # set_color green
  set theTime (date +%H)

  if test $theTime -ge 5;and test $theTime -le 16;
    set_color yellow
    thesun
  else
    set_color green
    themoon
  end

  set_color normal
end



function thesun
  # nature/sun
  echo "               :             "
  echo "      `.       ;        .'   "
  echo "        `.  .-'''-.   .'     "
  echo "          ;'  __   _;'       "
  echo "         /   '_    _`\       "
  echo "        |  _( a (  a  |      "
  echo "   '''''| (_)    >    |``````"
  echo "         \    \    / /       "
  echo "          `.   `--'.'        "
  echo "         .' `-,,,-' `.       "
  echo "       .'      :      `.     "
  echo "               :             "
end

function themoon
  # space/moons
  echo "        _.-'''-._      "
  echo "       .'   .-'``|'.   "
  echo "      /    /    -*- \  "
  echo "     ;   <{      |   ; "
  echo "     |    _\ |       | "
  echo "     ;   _\ -*- |    ; "
  echo "      \   \  | -*-  /  "
  echo "       '._ '.__ |_.'   "
  echo "          '-----'      "

end



function bigmoon
  echo "                        ___---___"
  echo "                      .--         --."
  echo "                    ./   ()      .-. \."
  echo "                   /   o    .   (   )  \\"
  echo "                  / .            '-'    \\"
  echo "                 | ()    .  O         .  |"
  echo "                |                         |"
  echo "                |    o           ()       |"
  echo "                |       .--.          O   |"
  echo "                 | .   |    |            |"
  echo "                  \    `.__.'    o   .  /"
  echo "                   \                   /"
  echo "                    `\  o    ()      /' jgs"
  echo "                      `--___   ___--'"
  echo "                            ---"
end

function milkyway
  echo "                                                       ..       :"
  echo "                    .                  .               .   .  ."
  echo "      .           .                .               .. .  .  *"
  echo "             *          .                    ..        ."
  echo "                           .             .     . :  .   .    .  ."
  echo "            .                         .   .  .  .   ."
  echo "                                         . .  *:. . ."
  echo ".                                 .  .   . .. .         ."
  echo "                         .     . .  . ...    .    ."
  echo "       .              .  .  . .    . .  . ."
  echo "                        .    .     . ...   ..   .       .               ."
  echo "                 .  .    . *.   . ."
  echo "    .                   :.  .           ."
  echo "                 .   .    .    ."
  echo "             .  .  .    ./|\\"
  echo "            .  .. :.    . |             .               ."
  echo "     .   ... .            |"
  echo " .    :.  . .   *.        |     .               ."
  echo "   .  *.             You are here."
  echo " . .    .               .             *.                         ."
end

function treebird
  echo \n
  echo "              ...    *    .   _  .   "
  echo "           *  .  *     .   * (_)   * "
  echo "             .      |*  ..   *   ..  "
  echo "              .  * \|  *  ___  . . * "
  echo "           *   \/   |/ \/{o,o}     . "
  echo "             _\_\   |  / /)  )* _/_ *"
  echo "                 \ \| /,--"-"---  .. "
  echo "           _-----`  |(,__,__/__/_ .  "
  echo "                  \ ||      ..       "
  echo "                   ||| .            *"
  echo "                   |||               "
  echo "           ejm98   |||               "
  echo "             , -=-~' .-^- _          "
end


function spacetravel
  echo "                          .   *        .       ."
  echo "         *      -0-"
  echo "            .                .  *       - )-"
  echo "         .      *       o       .       *"
  echo "   o                |"
  echo "             .     -O-"
  echo "  .                 |        *      .     -0-"
  echo "         *  o     .    '       *      .        o"
  echo "                .         .        |      *"
  echo "     *             *              -O-          ."
  echo "           .             *         |     ,"
  echo "                  .           o"
  echo "          .---."
  echo "    =   _/__~0_\_     .  *            o       '"
  echo "   = = (_________)             ."
  echo "                   .                        *"
  echo "         *               - ) -       *"
  echo "                .               ."
  echo ""
end

function threeTrees
  echo "               ,@@@@@@@,"
  echo "       ,,,.   ,@@@@@@/@@,  .oo8888o."
  echo "    ,&%%&%&&%,@@@@@/@@@@@@,8888\88/8o"
  echo "   ,%&\%&&%&&%,@@@\@@@/@@@88\88888/88'"
  echo "   %&&%&%&/%&&%@@\@@/ /@@@88888\88888'"
  echo "   %&&%/ %&%%&&@@\ V /@@' `88\8 `/88'"
  echo "   `&%\ ` /%&'    |.|        \ '|8'"
  echo "       |o|        | |         | |"
  echo "       |.|        | |         | |"
  echo "jgs \\/ ._\//_/__/  ,\_//__\\/.  \_//__/_"
end

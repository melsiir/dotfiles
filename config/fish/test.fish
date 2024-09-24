function show_spinner

    set -l FRAMES '/-\|'

    # shellcheck disable SC2034
    set -l NUMBER_OR_FRAMES (count $FRAMES)
    set -l CMDS "$argv[2]"
    set -l MSG "$argv[3]"
    set -l PID "$argv[1]"

    set -l i 0
    set -l frameText ""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Display spinner while the commands are being executed.

    while kill -0 "$PID" &>/dev/null
        for i in $frameText
            set frameText "   $i $MSG"
            # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

            # Print frame text.

            printf "%s" "$frameText"

            sleep 0.2

            # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

            # Clear frame text.

            printf "\r"

        end


    end

end

function set_trap
    trap -p "$argv[1]" | grep "$argv[2]" &>/dev/null \
        || trap '$argv[2]' "$argv[1]"
end

function execute
    set -l CMDS "$argv[1]"
    set -l MSG "$argv[-1]"
    set -l TMP_FILE "$(mktemp /data/data/com.termux/files/usr/tmp/XXXXX)"

    set exitCode 0
    set cmdsPID ""

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # If the current process is ended,
    # also end all its subprocesses.

    set_trap EXIT kill_all_subprocesses

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Execute commands in background
    # shellcheck disable=SC2261

    eval "$CMDS" &>/dev/null 2>"$TMP_FILE" & set cmdsPID $last_pid

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Show a spinner if the commands
    # require more time to complete.

    show_spinner "$cmdsPID" "$CMDS" "$MSG"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Wait for the commands to no longer be executing
    # in the background, and then get their exit code.

    wait "$cmdsPID" &>/dev/null
    set exitCode $status

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    # Print output based on what happened.

    echo $exitCode "$MSG"

    if test $exitCode -ne 0
        echo <"$TMP_FILE"
    end
    rm -rf "$TMP_FILE"

    # - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

    return $exitCode

end

function gbat
    # set_color green
    set theTime (date +%H)

    if test $theTime -ge 5; and test $theTime -le 16
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

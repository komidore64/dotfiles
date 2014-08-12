# ~/.bash_logout

IFS='' read -r -d '' LOGOUTMESSAGE <<'END'
                                     _       _
 ___  ___  ___   _   _  ___  _   _  | | __ _| |_ ___ _ __
/ __|/ _ \/ _ \ | | | |/ _ \| | | | | |/ _` | __/ _ \ '__|
\__ \  __/  __/ | |_| | (_) | |_| | | | (_| | ||  __/ |
|___/\___|\___|  \__, |\___/ \__,_| |_|\__,_|\__\___|_|
                 |___/
                                              _
 ___ _ __   __ _  ___ ___    ___ _____      _| |__   ___  _   _
/ __| '_ \ / _` |/ __/ _ \  / __/ _ \ \ /\ / / '_ \ / _ \| | | |
\__ \ |_) | (_| | (_|  __/ | (_| (_) \ V  V /| |_) | (_) | |_| |
|___/ .__/ \__,_|\___\___|  \___\___/ \_/\_/ |_.__/ \___/ \__, |
    |_|                                                   |___/
END

# let's speed things up if we're in tmux (or screen)
[[ "$TERM" =~ "screen" ]] && exit

if which lolcat > /dev/null 2>&1; then
    echo "$LOGOUTMESSAGE" | lolcat
else
    echo "$LOGOUTMESSAGE"
fi

sleep 1

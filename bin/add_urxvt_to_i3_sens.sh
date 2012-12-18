#~/bin/bash

term=urxvt256c
file=/usr/bin/i3-sensible-terminal

if [[ -z $(grep -r $term $file) ]]; then
    sed -i 's/\(for terminal in $TERMINAL\)/\1 '$term'/' $file
fi

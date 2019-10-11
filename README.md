# dotfiles

1. clone repo
1. `git submodule update --init`
1. copy over global.gemset for desired ruby versions
1. install [RVM](http://rvm.io)
1. install a ruby (most likely just `rvm install ruby`)
1. run the installer (`ruby installer/derpfiles.rb --help`)
1. install vundle plugins (`vundle-update`)

### terminal colors

| value             | hex       | rgb             |
| :---------------- | :-------: | :-------------- |
| background        | `#101010` | `16, 16, 16`    |
| foreground        | `#ededed` | `237, 237, 237` |
| black (0)         | `#2E3436` | `46, 52, 54`    |
| dark gray (8)     | `#555753` | `85, 87, 83`    |
| red (1)           | `#993C3C` | `153, 60, 60`   |
| light red (9)     | `#BF4141` | `191, 65, 65`   |
| green (2)         | `#3C993C` | `60, 153, 60`   |
| light green (10)  | `#41BF41` | `65, 191, 65`   |
| yellow (3)        | `#99993C` | `153, 153, 60`  |
| light yellow (11) | `#BFBF41` | `191, 191, 65`  |
| blue (4)          | `#3C6199` | `60, 97, 153`   |
| light blue (12)   | `#4174FB` | `65, 116, 251`  |
| purple (5)        | `#993C99` | `153, 60, 153`  |
| light purple (13) | `#BF41BF` | `191, 65, 191`  |
| cyan (6)          | `#3C9999` | `60, 153, 153`  |
| light cyan (14)   | `#41BFBF` | `65, 191, 191`  |
| light gray (7)    | `#D3D7CF` | `211, 215, 207` |
| white (15)        | `#E3E3E3` | `227, 227, 227` |
| cursor            | `#993C99` | `153, 60, 153`  |

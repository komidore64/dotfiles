# Dotfiles

Works with linux and OS X.

Copy them into your home directory, or clone the repository and run the installer.

## Installation

1. clone repo
1. `git submodule update --init`
1. copy over global.gemset for desired ruby versions
1. install [RVM](http://rvm.io)
1. install a ruby (most likely just `rvm install ruby`)
1. run the installer (`ruby installer/derpfiles.rb --help`)
1. install vundle plugins (`vundle-update`)

### Additional steps for OS X

```bash
# Get your Sublime Text settings
ln -sf /<dotfiles>/config/sublime-text-2 ~/Library/Application\ Support/Sublime\ Text\ 2

# Launching Sublime Text from the terminal
ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl
```

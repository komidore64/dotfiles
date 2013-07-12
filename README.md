# dotfiles

Configured for Linux (including boxes on [Nitrous.IO](https://www.nitrous.io/join/Ne4RmyEvhD8), and Mac OS X.

Copy them into your home directory, or clone the repository and create symlinks.

## vim

My Vim plugins are managed by Vundle which is a Vim plugin itself. It's pretty awesome, very easy to use, and makes getting new plugins a snap.

## sublime text 2

### settings

```bash
# linux
ln -s /<dotfiles>/config/sublime-text-2 ~/.config/

# mac os x
ln -s /<dotfiles>/config/sublime-text-2 ~/Library/Application\ Support/Sublime\ Text\ 2
```

### launch sublime text from the command line

for linux, use my handy script ```subl``` located in ```/bin```

```bash
# mac os x
ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl
# then just run
subl
```

### caveats

be sure to ```git submodule update --init``` first thing

## TODO
* install script?

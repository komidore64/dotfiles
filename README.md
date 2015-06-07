# dotfiles

Configured for linux and OS X.

Copy them into your home directory, or clone the repository and run the installer.

## installation

1. clone repo
2. copy over global.gemset for desired versions
3. install RVM
4. install a ruby
5. run the installer
6. install vundle plugins

### mac os x (additional steps)

```bash
# get your sublime text settings
ln -sf /<dotfiles>/config/sublime-text-2 ~/Library/Application\ Support/Sublime\ Text\ 2

# if you want to launch sublime text from the cli
$ ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl
```

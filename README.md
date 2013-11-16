# dotfiles

Configured for Linux (including boxes on [Nitrous.IO](https://www.nitrous.io/join/Ne4RmyEvhD8)), and Mac OS X.

Copy them into your home directory, or clone the repository and run the installer.

## installation

```bash
ruby installer/derpfiles.rb --help # to see how to use the installer
vundle-update # to install vim plugins after running derpfiles.rb
```
### mac os x (additional steps)

```bash
# get your sublime text settings
ln -s /<dotfiles>/config/sublime-text-2 ~/Library/Application\ Support/Sublime\ Text\ 2

# if you want to launch sublime text from the cli
$ ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl
```

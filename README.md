# dotfiles

Configured for Linux (including boxes on [Nitrous.IO](https://www.nitrous.io/join/Ne4RmyEvhD8)), and Mac OS X.

Copy them into your home directory, or clone the repository and run the installer.

## installation

```sh
mkdir -p ~/.rvm/gemsets && ln -s /<dotfiles>/rvm/gemsets/global.gems ~/.rvm/gemsets/
\curl -sSL https://get.rvm.io | bash -s stable --ruby
ruby installer/derpfiles.rb --help # to see how to use the installer
vundle-update # to install vim plugins after running derpfiles.rb
```
### mac os x (additional steps)

```bash
# get your sublime text settings
ln -sf /<dotfiles>/config/sublime-text-2 ~/Library/Application\ Support/Sublime\ Text\ 2

# if you want to launch sublime text from the cli
$ ln -s "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" ~/bin/subl
```

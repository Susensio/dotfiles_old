# dotfiles

Set up:

``` bash
git init --bare $HOME/.dotfiles.git
echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"' >> $HOME/.bash_aliases
source ~/.bashrc
dotfiles config --local status.showUntrackedFiles no
dotfiles remote add origin https://github.com/Susensio/dotfiles.git
```

Usage:
``` bash
dotfiles status
dotfiles add .vimrc
dotfiles commit -m "Add vimrc"
dotfiles push origin master
```

Install to another server:
``` bash
echo 'alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"' >> $HOME/.bash_aliases
source ~/.bashrc
echo ".dotfiles.git" >> .gitignore
git clone --bare https://github.com/Susensio/dotfiles.git
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no
```

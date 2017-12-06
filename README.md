# dotfiles

Collection of .dotfiles used in Raspberry Pi (3 model B and Zero W) and other steps to follow up in a new installed Raspbian.

## Backup from Raspberry Pi

Fresh set up:
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

Install to another system:
``` bash
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
git clone --bare https://github.com/Susensio/dotfiles.git $HOME/.dotfiles.git/
dotfiles config --local status.showUntrackedFiles no
dotfiles checkout 

if [ $? = 0 ]; then
  echo "Checked out dotfiles.";
else
  echo "Backing up pre-existing dot files.";
  mkdir -p .dotfiles-backup
  dotfiles checkout 2>&1 | egrep "^\s+" | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
  dotfiles checkout
fi;
```

## Smooth YouTube on Chromium

Make sure we have at least 128 Mb shared GPU memory and updated system:

``` bash
sudo apt-get update; sudo apt-get dist-upgrade -y
```

We need installed some libraries to get Chromium's ability to use Raspberry Pi GPU:

``` bash
sudo apt-get install mesa-vdpau-drivers -y
```

Then, open Chromium browser, go to ```chrome://flags``` and set enabled next flags:

```
#enable-gpu-rasterization
#enable-zero-copy
#ignore-gpu-blacklist
```

Next open in editor Chromium shortcut (chromium-browser.desktop) and find the line:

``` bash
Exec=chromium-browser %U
```

Edit it like this:

``` bash
Exec=chromium-browser --enable-native-gpu-memory-buffers %U
```


## Credits

* Git bare instructions:
[Nicola Paolucci](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)
and
[Harfang's Perch](https://harfangk.github.io/2016/09/19/manage-dotfiles-with-a-git-bare-repository.html)

* Chromium playback performance:
[Sergey Kovalenko](https://www.linkedin.com/pulse/how-get-smooth-youtubeflash-video-playback-raspberry-pi-kovalenko/)



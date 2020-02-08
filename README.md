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

We need installed some libraries to get Chromium's ability to use Raspberry Pi GPU:

``` bash
sudo apt-get update; sudo apt-get dist-upgrade -y
sudo apt-get install mesa-vdpau-drivers -y
```

Then, open Chromium browser, go to ```chrome://flags``` and set enabled next flags:

```
#enable-gpu-rasterization/etc/default/locale
#enable-zero-copy
#ignore-gpu-blacklist
```

Next open in editor Chromium shortcut (chromium-browser.desktop) and set the line:

```
Exec=chromium-browser --enable-native-gpu-memory-buffers %U
```

## Logitech K400+ keyboard + trackpad

Enable *natural scrolling* and *middle button emulation*. Must be set in every boot: save as K400-setup.desktop in ~/.config/autostart).

```
[Desktop Entry]
Type=Application
Name=K400 setup
Comment=Setup K400+ keyboard to use virtual middle button and natural scrolling
NoDisplay=true
Exec=sh -c 'xinput set-prop "keyboard:Logitech K400 Plus" "libinput Middle Emulation Enabled" 1; xinput set-prop "keyboard:Logitech K400 Plus" "libinput Natural Scrolling Enabled" 1'
```

## Increase swap allocation

For better perfomance in low memory situations, set ```CONF_SWAPSIZE=1024``` in ```/etc/dphys-swapfile```.


## Change pi user

```bash
NEWUSER="susensio"

sudo adduser $NEWUSER
# PASSWORD PROMPT

for GROUP in $(groups pi | sed ‘s/.*:\s//’); do sudo adduser $NEWUSER $GROUP; done

sudo sed -i "s/pi/${NEWUSER}/" /etc/sudoers.d/010_pi-nopasswd
sudo mv /etc/sudoers.d/010_pi-nopasswd /etc/sudoers.d/010_${NEWUSER}-nopassdw
```


## Monday first on gnome calendar

File '/etc/default/locale' must contain
```bash
LC_TIME="en_GB.UTF-8"
```


## Credits

* Git bare instructions:
[Nicola Paolucci](https://developer.atlassian.com/blog/2016/02/best-way-to-store-dotfiles-git-bare-repo/)
and
[Harfang's Perch](https://harfangk.github.io/2016/09/19/manage-dotfiles-with-a-git-bare-repository.html)

* Chromium playback performance:
[Sergey Kovalenko](https://www.linkedin.com/pulse/how-get-smooth-youtubeflash-video-playback-raspberry-pi-kovalenko/)



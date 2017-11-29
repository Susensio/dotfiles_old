# Navigation and listing
alias ls="ls --color -F"
alias ll="ls -lhA"
alias la="ls -A"
alias cd..="cd .."
function mcd {
 mkdir -p $1
 cd $1;
}

# System
alias reboot="sudo reboot"
alias df="pydf"
#alias df="df -Th --total"
#alias du="ncdu"
alias dus="du -Sh | sort -n -r | more"
alias histg="history | grep"
#alias historytop:"history | awk '{CMD[$2]++;count++;}END { for (a in CMD)print CMD[a] " " CMD[a]/count*100 "% " a;}' | grep -v "./" | column -c3 -s " " -t | sort -nr | nl |  head -n10"

# Continue download
alias wget="wget -c"

# Get external IP
alias myip="curl canhazip.com"

alias diff="diff --color"

# Git dotfiles
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"

# Autocompletion tldr
cachedir=~/.local/share/tldr # Or whatever else the location of the tldr cache is
complete -W "$(q=($cachedir/*/*); sed 's@\.md @ @g' <<<${q[@]##*/})" tldr

# Extrat from common file formats
function extract {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: extract <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in $@
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar) 
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *)
                         echo "extract: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
 fi
}

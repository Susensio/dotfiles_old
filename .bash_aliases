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
alias histg="history | grep "
alias gh="history | grep "
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

# ghf - [G]rep [H]istory [F]or top ten commands and execute one
# usage:
#  Most frequent command in recent history
#   ghf
#  Most frequent instances of {command} in all history
#   ghf {command}
#  Execute {command-number} after a call to ghf
#   !! {command-number}
function latest-history { history | tail -n 50 ; }
function grepped-history { history | grep "$1" ; }
function chop-first-column { awk '{for (i=2; i<NF; i++) printf $i " "; print $NF}' ; }
function add-line-numbers { awk '{print NR " " $0}' ; }
function top-ten { sort | uniq -c | sort -r | head -n 10 ; }
function unique-history { chop-first-column | top-ten | chop-first-column | add-line-numbers ; }
function ghf {
  if [ $# -eq 0 ]; then latest-history | unique-history; fi
  if [ $# -eq 1 ]; then grepped-history "$1" | unique-history; fi
  if [ $# -eq 2 ]; then
    `grepped-history "$1" | unique-history | grep ^$2 | chop-first-column`;
  fi
}

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

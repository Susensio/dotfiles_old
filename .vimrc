" Plugins
set nocompatible              " required
filetype off                  " required

so ~/.vim/plugins.vim

" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'columns' to 82 characters.
  autocmd FileType text setlocal columns=82

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Add optional packages.
"
" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
if has('syntax') && has('eval')
  packadd matchit
endif

" Make text more readable
set background=dark
set number relativenumber
colorscheme elflord
highlight LineNr ctermfg=grey

" Tabs and indent
set tabstop=4
set shiftwidth=4
set expandtab

" Temp files
set undodir=~/.vim/.undo//
set backupdir=~/.vim/.backup//
"" set directory=~/.vim/.swp//

" Code folding
set foldmethod=indent
set foldlevel=99
nnoremap <space> za

"set clipboard=unnamedplus

" Line wrap
set wrap
set linebreak
set textwidth=0
imap <silent> <Down> <C-o>gj
imap <silent> <Up> <C-o>gk

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!

" Tricks from https://vim-bootstrap.com/
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

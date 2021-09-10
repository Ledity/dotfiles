set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required

Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo

Plugin 'tpope/vim-fugitive'

" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub

Plugin 'git://git.wincent.com/command-t.git'

" git repos on your local machine (i.e. when working on your own plugin)

" Plugin 'file:///home/gmarik/path/to/plugin'

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.

Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}

"" 

Plugin 'frazrepo/vim-rainbow'
Plugin 'itchyny/lightline.vim'

" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line

call vundle#end()            " required
filetype plugin indent on    " required

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

" ------------------------- Here-Starts-True-Vimrc ------------------------- "

syntax on
colorscheme koehler
set t_Co=256
autocmd WinEnter,FileType asm colorscheme elflord

set showcmd

set mouse=a

set nu

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

set exrc
set secure

set nrformats+=alpha
noremap <C-b> <C-a>

" Powerline plugin config
" The colorscheme for lightline.vim.
" 		Currently, wombat, solarized, powerline, powerlineish,
" 		jellybeans, molokai, seoul256, darcula,
" 		selenized_dark, selenized_black, selenized_light, selenized_white,
" 		Tomorrow, Tomorrow_Night, Tomorrow_Night_Blue,
" 		Tomorrow_Night_Bright, Tomorrow_Night_Eighties, PaperColor,
" 		landscape, one, materia, material, OldHope, nord, deus,
"		simpleblack, srcery_drk, ayu_mirage, ayu_light, ayu_dark,
" 		apprentice and 16color are available.

set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'one',
      \ }

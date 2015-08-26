set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'majutsushi/tagbar.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'wincent/command-t'
Plugin 'Lokaltog/vim-powerline'
" Plugin 'hdima/python-syntax'
call vundle#end()            " required
filetype plugin indent on    " required
set shiftwidth=4
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
"

" 代码高亮用的
syntax enable
filetype plugin on
set number

" 颜色配置
colorscheme molokai

" 标签映射
execute "set <M-i>=\ei"
execute "set <M-o>=\eo"
execute "set <M-p>=\ep"
execute "set <M-u>=\eu"
execute "set <M-l>=\el"
execute "set <M-n>=\en"
execute "set <M-y>=\ey"
execute "set <M-c>=\ec"

nmap <M-p> :TagbarToggle<CR>
imap <M-p> <esc>:TagbarToggle<CR>i
nmap <M-u> :NERDTreeToggle<CR>
imap <M-u> <esc>:NERDTreeToggle<CR>
nmap <C-c> :q<CR>
nmap <M-o> :tabn<CR>
imap <M-o> <esc>:tabn<CR>
nmap <M-i> :tabp<CR>
imap <M-i> <esc>:tabp<CR>
nmap <C-z> :undo<CR>
nmap <C-s> :w<CR>
imap <C-s> <esc>:w<CR>
imap <M-c> <esc>:pc<CR>
nmap <M-c> :pc<CR>
nmap <M-l> :w<CR>:PymodeLint<CR>
imap <M-l> <esc>:w<CR>:PymodeLint<CR>

" find reference用的是新开窗口 new是上下分，vnew是左右分
let g:pymode_rope_goto_definition_cmd = 'e'
let g:pymode_rope_goto_definition_bind = '<M-n>'

set backspace=indent,eol,start " 让backspace能正常工作的配置

" 这是对PowerLine的设置
set encoding=utf-8
set laststatus=2
let g:Powerline_symbols='unicode'

" tab设置
set ts=4
set expandtab

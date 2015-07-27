set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
Plugin 'fatih/vim-go'
Plugin 'Shougo/neocomplete.vim'
Plugin 'majutsushi/tagbar.git'
Plugin 'scrooloose/nerdtree.git'
Plugin 'wincent/command-t'
Plugin 'Lokaltog/vim-powerline'
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
let g:go_disable_autoinstall = 0
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_command = "goimports" "保存的时候自动运行goimports
" 自动补全自动启动
let g:neocomplete#enable_at_startup = 1

" 颜色配置
colorscheme molokai

" 标签分析
let g:tagbar_type_go = {
    \ 'ctagstype' : 'go',
    \ 'kinds'     : [
        \ 'p:package',
        \ 'i:imports:1',
        \ 'c:constants',
        \ 'v:variables',
        \ 't:types',
        \ 'n:interfaces',
        \ 'w:fields',
        \ 'e:embedded',
        \ 'm:methods',
        \ 'r:constructor',
        \ 'f:functions'
    \ ],
    \ 'sro' : '.',
    \ 'kind2scope' : {
        \ 't' : 'ctype',
        \ 'n' : 'ntype'
    \ },
    \ 'scope2kind' : {
        \ 'ctype' : 't',
        \ 'ntype' : 'n'
    \ },
    \ 'ctagsbin'  : 'gotags',
    \ 'ctagsargs' : '-sort -silent'
    \ }

" 标签映射
nmap <F8> :TagbarToggle<CR>
nmap <F7> :NERDTreeToggle<CR>
nmap <C-c> :q<CR>
nmap <C-0> :tabn<CR>
nmap <C-9> :tabp<CR>
nmap <F6> :w<CR>:GoLint<CR>
nmap <F5> :GoDef<CR>
nmap <C-z> :undo<CR>

set backspace=indent,eol,start " 让backspace能正常工作的配置

" 这是对PowerLine的设置
set laststatus=2
let g:Powerline_symbols='unicode'

" tab设置
set ts=4
set expandtab

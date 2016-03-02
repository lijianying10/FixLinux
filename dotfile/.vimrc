"开启光亮光标行
set cursorline
hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white

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
Plugin 'solarnz/thrift.vim'
call vundle#end()            " required
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
nmap <M-l> :w<CR>:GoLint<CR>
nmap <M-n> :GoDef<CR>
nmap <C-z> :undo<CR>
nmap <M-y> :GoErrCheck<CR>
nmap <C-s> :w<CR>
imap <C-s> <esc>:w<CR>
imap <M-c> <esc>:pc<CR>
nmap <M-c> :pc<CR>

set backspace=indent,eol,start " 让backspace能正常工作的配置

" 这是对PowerLine的设置
set encoding=utf-8
set laststatus=2
let g:Powerline_symbols='unicode'

" tab设置
set ts=4
set expandtab

" 解决esc延迟问题
set timeoutlen=1000 ttimeoutlen=0


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""实用设置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"设置当文件被改动时自动载入
set autoread
"共享剪贴板  
set clipboard+=unnamed 
"从不备份  
set nobackup
" 语法高亮
syntax enable
" 去掉输入错误的提示声音
set noeb
" 在处理未保存或只读文件的时候，弹出确认
set confirm
" 自动缩进
set autoindent
" 在行和段开始处使用制表符
set smarttab
" 显示行号
set number
" 历史记录数
set history=1000
"禁止生成临时文件
set noswapfile
"搜索忽略大小写
set ignorecase
"搜索逐字符高亮
set hlsearch
set incsearch
"行内替换
set gdefault
"编码设置

" 我的状态行显示的内容（包括文件类型和解码）
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
" 带有如下符号的单词不要被换行分割
set iskeyword+=_,$,@,%,#,-

set report=0
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=1
" 光标移动到buffer的顶部和底部时保持3行距离
set scrolloff=5
" 高亮显示普通txt文件（需要txt.vim脚本）
au BufRead,BufNewFile *  setfiletype txt

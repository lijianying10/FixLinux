filetype off                  " required

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')
" Initialize plugin system
Plug 'fatih/vim-go'
Plug 'mileszs/ack.vim'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'vim-airline/vim-airline'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" for HTML
Plug 'mattn/emmet-vim'
" for typescript
Plug 'leafgarland/typescript-vim'
" for JS
Plug 'pangloss/vim-javascript'
" for SNIP tool
Plug 'SirVer/ultisnips'
" Snippets are separated from the engine. Add this if you want them:
Plug 'honza/vim-snippets'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'zchee/deoplete-go', { 'do': 'make'}
Plug 'w0rp/ale'
call plug#end()

let g:python3_host_prog = '/usr/bin/python3'
" let g:python_host_prog = '/usr/bin/python'
let g:loaded_python_provider=1
let g:python_host_skip_check=1
let g:deoplete#enable_at_startup = 1

" 代码高亮用的
syntax enable
filetype plugin on
set number
let g:go_fmt_command = "goimports" "保存的时候自动运行goimports
let g:go_highlight_build_constraints = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_structs = 1
let g:go_highlight_types = 1

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
" execute "set <M-i>=\ei"
" execute "set <M-o>=\eo"
" execute "set <M-p>=\ep"
" execute "set <M-u>=\eu"
" execute "set <M-l>=\el"
" execute "set <M-n>=\en"
" execute "set <M-y>=\ey"
" execute "set <M-c>=\ec"

nmap <M-p> :TagbarToggle<CR>
imap <M-p> <esc>:TagbarToggle<CR>i
nmap <M-u> :NERDTreeToggle<CR>
imap <M-u> <esc>:NERDTreeToggle<CR>
nmap <C-c> :q<CR>
nmap <M-o> :tabn<CR>
imap <M-o> <esc>:tabn<CR>
nmap <M-i> :tabp<CR>
imap <M-i> <esc>:tabp<CR>
nmap <M-l> :w<CR>:GoMetaLinter<CR>
nmap <M-n> :GoDef<CR>
nmap <C-z> :undo<CR>
nmap <M-y> :GoErrCheck<CR>
nmap <C-s> :w<CR>
imap <C-s> <esc>:w<CR>
imap <M-c> <esc>:pc<CR>
nmap <M-c> :pc<CR>
nmap <leader>r :Ack<space>
nmap <leader>t :FZF<CR>

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

"高亮显示搜索匹配到的字符串
set hlsearch

"在搜索模式下，随着搜索字符的逐个输入，实时进行字符串匹配，并对首个匹配到的字符串高亮显示
set incsearch

" 解决Tmux下 背景颜色不一致的问题
set t_ut=

" tab 也使用airline
let g:airline#extensions#tabline#enabled = 1

" 使用Powerline字体
let g:airline_powerline_fonts = 1
let g:ackprg = 'ack -s -H --nopager --nocolor --nogroup --column --smart-case'

function SetClipData()
  let clipdata = getreg("")
  call system("echo -n '".clipdata."' > /tmp/clipdata")
endfunction

func GetClipData()
    let clipdata = system("cat /tmp/clipdata")
    call append(getpos(".")[1],split(clipdata,"\n"))
endfunction

nmap <leader>c :call SetClipData()<CR>
nmap <leader>v :call GetClipData()<CR>
inoremap { {}<ESC>i
inoremap ( ()<ESC>i
inoremap " ""<ESC>i
inoremap ' ''<ESC>i

augroup gopkgs
  autocmd!
  autocmd FileType go command! -buffer Import exe 'GoImport' fzf#run({'source': 'gopkgs'})[0]
  autocmd FileType go command! -buffer Doc exe 'GoDoc' fzf#run({'source': 'gopkgs'})[0]
augroup END

" for js check
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1

" Snippets tool config
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" tabs for golang
au FileType go set noexpandtab
au FileType go set shiftwidth=4
au FileType go set softtabstop=4
au FileType go set tabstop=4

let g:deoplete#enable_at_startup = 1
let g:deoplete#sources#go#gocode_binary='/go/bin/gocode'
let g:deoplete#sources#go#builtin_objects=1
let g:deoplete#sources#go#sort_class = ['package', 'func', 'type', 'var', 'const']

" For ale
let g:ale_linters = {'go': ['gofmt']}
" Error and warning signs.
let g:ale_sign_error = '⤫'
let g:ale_sign_warning = '⚠'
" Enable integration with airline.
let g:airline#extensions#ale#enabled = 1

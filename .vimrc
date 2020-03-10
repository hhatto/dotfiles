set mouse=
set vb t_vb=
set t_Co=256
sy on

set ruler
set expandtab
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4
set fileencoding=utf-8
set fileencodings=utf-8
set hlsearch
set number
set showmatch
set matchtime=3
set backspace=indent,eol,start
set wildmenu
set incsearch
set laststatus=2
set pastetoggle=<F5>
filetype plugin indent on

autocmd FileType typescript :set sw=2 ts=2
autocmd FileType vue :set sw=2 ts=2
autocmd FileType yaml :set sw=2 ts=2

set viminfo+='500,\"1000,:0,n~/.viminfo
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

colorscheme badwolf

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif
endif

packloadall

set completeopt=menuone
autocmd! User jedi-vim call s:jedivim_hook()   " vim-plugの遅延ロード呼び出し
function! s:jedivim_hook()              " jedi-vimを使うときだけ呼び出す処理を関数化
  let g:jedi#auto_initialization    = 0 " 自動で実行される初期化処理を無効
  let g:jedi#auto_vim_configuration = 0 " 'completeopt' オプションを上書きしない
  let g:jedi#popup_on_dot           = 0 " ドット(.)を入力したとき自動で補完しない
  let g:jedi#popup_select_first     = 0 " 補完候補の1番目を選択しない
  let g:jedi#show_call_signatures   = 0 " 関数の引数表示を無効(ポップアップのバグを踏んだことがあるため)
  autocmd FileType python setlocal omnifunc=jedi#completions   " 補完エンジンはjediを使う
endfunction

let g:acp_enableAtStartup = 0

" for ale
let g:ale_linters = {
            \ 'markdown': [],
            \ 'c': [],
            \ 'cpp': [],
            \ 'go': ['gometalinter'],
            \ 'python': ['flake8'],
            \}
let g:ale_python_pycodestyle_options = '--max-line-length=160'
let g:ale_python_flake8_options = '--max-line-length=160'
let g:ale_lint_delay = 1500
let g:ale_go_gometalinter_options = '--fast --enable=staticcheck --enable=gosimple --enable=unused'

" vim-go
let g:go_fmt_autosave = 1
let g:go_fmt_command = "goimports"

let g:airline#extensions#tabline#enabled = 1

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'davidhalter/jedi-vim'
Plugin 'psf/black'
call vundle#end()

" for w0rp/ale
let g:ale_completion_enabled = 1
let g:ale_completion_delay = 1000
let g:ale_lint_delay = 1000

" Use neocomplcache.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

" for jedi
let g:jedi#show_call_signatures = 0

" omni completion
imap <C-f> <C-x><C-o>

" jedi-vim jump
map <C-k> \d
map <C-j> \n
map <C-n> :cn<cr>
map <C-p> :cp<cr>

highlight SignColumn ctermbg=red

let g:black_linelength = 120
autocmd BufWritePre *.py execute ':Black'

augroup vimrc-local
    autocmd!
    autocmd BufNewFile,BufReadPost * call s:vimrc_local(expand('<afile>:p:h'))
augroup END
function! s:vimrc_local(loc)
    let s:dir = getcwd()
    let files = findfile('.vimrc.local', fnameescape(s:dir) . ';', -1)
    for i in reverse(filter(files, 'filereadable(v:val)'))
        source `=i`
    endfor
endfunction

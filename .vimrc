set backspace=indent,eol,start
set synmaxcol=200
set nobackup
set backupskip=/tmp/*,/private/tmp/*
set shiftwidth=4
set ambiwidth=double
set softtabstop=4
set tabstop=4
set expandtab
set showmatch
set magic
set smartcase
set hlsearch
set incsearch
syntax on
set history=80
set encoding=utf-8
set fileencodings=utf-8
set autoindent
set tabstop=4
set nu
set noeb
set novb
filetype plugin on
filetype plugin indent on

set viminfo+='500,\"1000,:0,n~/.viminfo
set laststatus=2
set statusline=%5.85f\ %=%16(\ %m%r[%{&fileencoding}][%{&filetype}][%{&fileformat}]%)\ [%04l/%04L][%03c][%4P]\ \|\ %{strftime('%m\/%d\ %H\:%M')}

if (exists('+colorcolumn'))
    set colorcolumn=120
    highlight ColorColumn ctermbg=9
endif

autocmd! BufRead,BufNewFile *.leg set et
autocmd! BufRead,BufNewFile *.js color desert
autocmd! BufRead,BufNewFile *.md set filetype=markdown
autocmd! BufRead,BufNewFile *.rst set filetype=rst
autocmd! BufRead,BufNewFile *.cmdtbl set filetype=cpp
autocmd! BufRead,BufNewFile Jenkinsfile set filetype=groovy
autocmd FileType ocaml setlocal sw=2 ts=2
autocmd FileType ruby setlocal sw=2 ts=2
autocmd FileType cpp setlocal sw=2 ts=2
autocmd FileType cmake setlocal sw=2 ts=2
autocmd FileType rst setlocal sw=4 ts=4
autocmd FileType cs setlocal fileformat=dos
autocmd FileType go :highlight goErr cterm=bold ctermfg=214
autocmd FileType go :match goErr /\<err\>/
autocmd FileType proto syn keyword protoRepeated     repeated
autocmd FileType proto syn keyword protoOptional     optional
autocmd FileType proto highlight protoRepeated cterm=bold ctermfg=215
autocmd FileType proto match protoRepeated /\<repeated\>/
autocmd FileType proto highlight protoOptional cterm=bold ctermfg=218
autocmd FileType proto match protoOptional /\<optional\>/
autocmd FileType proto match protoOptional /\<optional\>/
autocmd FileType rust :packadd completor.vim
autocmd FileType c :packadd completor.vim
autocmd FileType cpp :packadd completor.vim
"autocmd FileType python :packadd completor.vim

augroup vimrcEx
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line('$') |
    \   exe "normal! g`\"" |
    \ endif
augroup END

set pastetoggle=<F5>

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" for jedi
let g:jedi#show_call_signatures = 0

"highlight Pmenu termbg=#003000

" for pathogen
execute pathogen#infect()

Plugin 'w0rp/ale'
Plugin 'xwsoul/vim-zephir'
"Plugin 'fatih/vim-go'
Plugin 'cespare/vim-toml'
let g:go_disable_autoinstall = 0
let g:go_fmt_command = "goimports"
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_def_mapping_enabled = 0

call plug#begin('~/.vim/plugged')
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
call plug#end()

" for tagbar
nmap <F8> :TagbarToggle<CR>

" omni completion
imap <C-f> <C-x><C-o>

" for syntastic
"let g:syntastic_python_checkers = ['python3', 'flake8']
""let g:syntastic_python_pep8_args = '--max-line=140'
"let g:syntastic_python_flake8_args = '--max-line=140'
"let g:syntastic_go_checkers = ['govet', 'goimports', 'errcheck']   " for big project
""let g:syntastic_go_checkers = ['go', 'golint', 'govet', 'goimports']
""let g:syntastic_go_checkers = ['go', 'govet', 'goimports']
""let g:syntastic_go_checkers = ['govet', 'goimports', 'golint']
"let g:syntastic_go_golint_args = '-min_confidence=1.0'
"let g:syntastic_sh_checkers = ['shellcheck']
"let g:syntastic_csharp_checkers = []
"let g:syntastic_rust_checkers = ['cargo']
""let g:syntastic_rust_checkers = ['rustc']

" for w0rp/ale
let g:ale_completion_delay = 1000
let g:ale_lint_delay = 1000

"NeoBundle Scripts-----------------------------
if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif

  " Required:
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

" Required:
call neobundle#begin(expand('~/.vim/bundle'))

" Let NeoBundle manage NeoBundle
" Required:
NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimproc', {
    \ 'build' : {
        \     'windows' : 'echo "Sorry, cannot update vimproc binary file in Windows."',
        \     'cygwin'  : 'make -f make_cygwin.mak',
        \     'mac'     : 'make -f make_mac.mak',
        \     'unix'    : 'make -f make_unix.mak',
        \    },
    \ }
" Add or remove your Bundles here:
NeoBundle 'Shougo/neosnippet.vim'
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'flazz/vim-colorschemes'

" You can specify revision/branch/tag.
NeoBundle 'Shougo/vimshell', { 'rev' : '3787e5' }

NeoBundle 'rust-lang/rust.vim'
NeoBundle 'racer-rust/vim-racer'

NeoBundle 'vim-scripts/Conque-GDB'

" Required:
call neobundle#end()

" Required:
filetype plugin indent on

" If there are uninstalled bundles found on startup,
" this will conveniently prompt you to install them.
NeoBundleCheck
"End NeoBundle Scripts-------------------------

"NeoBundleLazy 'OmniSharp/omnisharp-vim', {
"\   'autoload': { 'filetypes': [ 'cs', 'csi', 'csx' ] },
"\   'build': {
"\     'windows' : 'msbuild server/OmniSharp.sln',
"\     'mac': 'xbuild projectf-client-csharp.sln',
"\     'unix': 'xbuild projectf-client-csharp.sln',
"\   },
"\ }

"let g:OmniSharp_start_server = 0

let g:acp_enableAtStartup = 0

let g:OmniSharp_start_without_solution = 1
let g:OmniSharp_autoselect_existing_sln = 1
let g:OmniSharp_sln_list_index = 1

" Use neocomplcache.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3

let g:rustfmt_autosave = 0
let g:rustfmt_options = '--config-path $HOME/.rustfmt.toml'
let g:rustfmt_command = '$HOME/.cargo/bin/rustfmt'
let g:rustfmt_fail_silently = 1

" for ale
let g:ale_linters = {
\   'markdown': [],
\   'c': [],
\   'cpp': [],
\}


" for gtags
map <C-g> :Gtags
map <C-i> :Gtags -f %<CR>
map <C-]> :GtagsCursor<CR>
map <C-n> :cn<CR>
map <C-m> :cp<CR>

" for Racer (Rust)
set hidden
let g:racer_cmd = "~/.cargo/bin/racer"
let $RUST_SRC_PATH="~/.ghq/github.com/rust-lang/rust/src"
autocmd FileType rust map <C-]> gD

""let g:ale_rust_rls_executable = "~/.cargo/bin/rls"

" for Go

"color 256-grayvim
color fruitycterm

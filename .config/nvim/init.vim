if &compatible
  set nocompatible
endif

" reset augroup
augroup MyAutoCmd
  autocmd!
augroup END

" colors
if has('nvim')
  " For Neovim 0.1.3 and 0.1.4
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1

  " Or if you have Neovim >= 0.1.5
  if (has("termguicolors"))
    set termguicolors
  endif
elseif has('patch-7.4.1778')
  set guicolors
endif

set nu
set expandtab
set autoindent
set smartindent
set tabstop=4
set shiftwidth=4

filetype plugin indent on

autocmd BufNewFile,BufRead *.graphql  set filetype=graphql

set pumblend=10

call plug#begin('~/.config/nvim/plugged')
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'mattn/vim-goimports'
Plug 'jacoborus/tender.vim'
Plug 'raphamorim/lucario'
Plug 'gosukiwi/vim-atom-dark'
Plug 'dense-analysis/ale'
Plug 'sjl/badwolf'
Plug 'michalbachowski/vim-wombat256mod'
" Plug 'stsewd/sphinx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'florentc/vim-tla'
Plug 'evanleck/vim-svelte', {'branch': 'main'}
Plug 'RustemB/sixtyfps-vim'
Plug 'rajasegar/vim-astro', {'branch': 'main'}
Plug 'tomlion/vim-solidity'
Plug 'github/copilot.vim'
Plug 'swyddfa/esbonio'
call plug#end()

let g:copilot_enabled = 1

autocmd BufReadPost *
  \ if line("'\"") > 0 && line("'\"") <= line("$") |
  \   exe "normal g`\"" |
  \ endif

autocmd BufWritePre *.go :silent call CocAction('runCommand', 'editor.action.organizeImport')

colorscheme badwolf
" colorscheme wombat256mod

let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_diagnostics_virtual_text_enabled = 0
let g:lsp_settings = {
  \ 'pyls-all': {
  \   'workspace_config': {
  \     'pyls': {
  \       'configurationSources': ['flake8']
  \     }
  \   }
  \ },
  \ 'gopls': {
  \   'workspace_config': {
  \     'usePlaceholders': v:true,
  \     'analyses': {
  \       'fillstruct': v:true,
  \     },
  \   },
  \   'initialization_options': {
  \     'usePlaceholders': v:true,
  \     'analyses': {
  \       'fillstruct': v:true,
  \     },
  \   },
  \ },
  \}

" augroup LspGo
"   au!
"   autocmd User lsp_setup call lsp#register_server({
"       \ 'name': 'go-lang',
"       \ 'cmd': {server_info->['gopls']},
"       \ 'whitelist': ['go'],
"       \ })
"   autocmd FileType go setlocal omnifunc=lsp#complete
"   "autocmd FileType go nmap <buffer> gd <plug>(lsp-definition)
"   "autocmd FileType go nmap <buffer> ,n <plug>(lsp-next-error)
"   "autocmd FileType go nmap <buffer> ,p <plug>(lsp-previous-error)
" augroup END

nmap <silent> <space><space> :<C-u>CocList<cr>
nmap <silent> <C-k> <Plug>(coc-definition)

autocmd FileType python :silent ALEDisable
autocmd FileType typescript :silent ALEDisable
autocmd FileType typescript :set expandtab
autocmd FileType typescript :set sw=2 ts=2
autocmd FileType typescriptreact :set sw=2 ts=2
autocmd FileType typescriptreact :silent ALEDisable
autocmd FileType go :set noexpandtab

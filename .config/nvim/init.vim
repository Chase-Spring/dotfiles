" Plugin Section
call plug#begin("~/.vim/plugged")
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'sheerun/vim-polyglot'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    Plug 'joshdick/onedark.vim'
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
    Plug 'ggreer/the_silver_searcher'
    Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'dense-analysis/ale', {'for': 'ruby'}
call plug#end()

" Config Section
" Vimscript file settings ------------- {{{
augroup filetype_vim
    autocmd!
    autocmd FileType vim setlocal foldmethod=marker
augroup END
" }}}

" UI Config
""""""""""""""""""""""""""""""""""""""""
let mapleader="\<Space>"
let maplocalleader="\\"
syntax enable
set cursorline
set number
set relativenumber
set scrolloff=15
set guifont=jetbrains_mono_semi_light:h13
set splitright
set splitbelow
set signcolumn=yes

" Spaces and tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" Vim keys and configs
""""""""""""""""""""""""""""""""""""""""
augroup filetypes
    autocmd FileType javascript nnoremap <buffer> <localleader>c I// <esc>
    autocmd FileType python nnoremap <buffer> <localleader>c I# <esc>
augroup END

" JK no more editing... and training
inoremap jk <esc>
inoremap <esc> <nop>

" Stronger H and L to beginning / end of line
nnoremap H 0
nnoremap L $

" Slap quotes around visual blocks
vnoremap <leader>' <esc>`>a'<esc>`<i'<esc>
vnoremap <leader>" <esc>`>a"<esc>`<i"<esc>

" Hit vimrc faster
nnoremap <leader>ev :split $MYVIMRC<cr>/Vim keys and configs<cr>
nnoremap <leader>rv :source $MYVIMRC<cr>

" Folding
nnoremap <leader>f za
set foldmethod=syntax
set foldnestmax=2

" Full cap a word
" From insert mode
inoremap <c-u> <esc>viwUea
" From normal mode
noremap <c-u> viwUe

" Kill noob crutch arrow keys
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>

" Python
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set fileformat=unix

" Integrated Terminal Config
""""""""""""""""""""""""""""""""""""""""
" turn terminal to normal mode with escape
tnoremap <Esc> <C-\><C-n>
" start terminal in insert mode
au BufEnter * if &buftype == 'terminal' | :startinsert | endif
" open terminal on ctrl+n
function! OpenTerminal()
  split term://bash
  resize 10
endfunction
nnoremap <c-n> :call OpenTerminal()<CR>

" Plugin Config
""""""""""""""""""""""""""""""""""""""""

" OneDark
if (has("termguicolors"))
     set termguicolors
 endif
 colorscheme onedark

" NERDTree
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>

" Fzf
nnoremap <leader>s :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
let $FZF_DEFAULT_COMMAND = 'ag -g ""'

" Coc
" Use gd to go to definition
nmap <silent> <leader>gd <Plug>(coc-definition)
" Use K to see documentation
nmap <silent> <leader>K :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction
" Use <Leader>rn to smart rename
nmap <leader>rn <Plug>(coc-rename)
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()





" ASCII-cat, because why not?
echom ">^.^<"

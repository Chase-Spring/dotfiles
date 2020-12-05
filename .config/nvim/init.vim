" Load Plugins ------------------------ {{{
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
" }}}

" UI Config --------------------------- {{{
syntax enable
set cursorline
set number
set relativenumber
set scrolloff=15
set guifont=jetbrains_mono_semi_light:h13
set splitright
set splitbelow
set signcolumn=yes
set foldmethod=syntax
set foldnestmax=2
set foldlevelstart=1

" OneDark
if (has("termguicolors"))
     set termguicolors
 endif
 colorscheme onedark

set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
" }}}

" Remaps ------------------------------ {{{
let mapleader="\<Space>"
let maplocalleader="\\"

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
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>rv :source $MYVIMRC<cr>

" More intuitive folding
nnoremap <leader>f za

" Full cap a word
inoremap <c-u> <esc>viwUea
noremap <c-u> viwUe
" }}}

" Autocommands ------------------------ {{{
augroup all_files
    autocmd!
    autocmd FileType * exe "normal zr"
augroup END

augroup vimscript_files
    autocmd!
    autocmd FileType vim
      \ setlocal foldmethod=marker |
      \ exe "normal zM"
augroup END

augroup misc_filetypes
    autocmd!
    autocmd FileType javascript nnoremap <buffer> <localleader>c I// <esc>
    autocmd FileType python nnoremap <buffer> <localleader>c I# <esc>
    autocmd FileType python
        \ setlocal tabstop=4 |
        \ setlocal softtabstop=4 |
        \ setlocal shiftwidth=4 |
        \ setlocal textwidth=79 |
        \ setlocal expandtab |
        \ setlocal fileformat=unix
augroup END
" }}}

" Plugin Configs ---------------------- {{{
" NERDTree ---------------------------- {{{
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = []
let g:NERDTreeStatusline = ''
" Toggle
nnoremap <silent> <C-b> :NERDTreeToggle<CR>
" }}}

" Fzf --------------------------------- {{{
nnoremap <leader>s :FZF<CR>
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \}
let $FZF_DEFAULT_COMMAND = 'ag -g ""'
" }}}

" Coc --------------------------------- {{{
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
" }}}
" }}}

" ASCII-cat, because why not?
echom ">^.^<"

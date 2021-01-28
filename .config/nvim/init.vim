" Set Leaders for plugins ------------- {{{
let mapleader="\<Space>"
let maplocalleader="\\"
" }}}

" Load Plugins ------------------------ {{{
" Source files only if they exist ----- {{{
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction
" }}}

" My plugins
call SourceIfExists('~/.vim/plugin/grep-operator.vim')

" External Plugins
call plug#begin("~/.vim/plugged")
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    let g:coc_global_extensions = [
                \ 'coc-tsserver',
                \ 'coc-python',
                \ ]
    Plug 'sheerun/vim-polyglot'
    Plug 'tpope/vim-fugitive'
    Plug 'vim-airline/vim-airline'
    Plug 'joshdick/onedark.vim'
	Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
	Plug 'junegunn/fzf.vim'
    Plug 'ggreer/the_silver_searcher'
    Plug 'scrooloose/nerdtree'
    Plug 'ryanoasis/vim-devicons'
    Plug 'dense-analysis/ale', {'for': ['ruby']}
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
set hidden
set nowrap

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

" Generic Config ----------------------- {{{
set ignorecase
set smartcase
" }}}

" Remaps ------------------------------ {{{
" Unbind for tmux
map <C-a> <Nop>

" JK no more editing... and training
inoremap jk <esc>
inoremap <esc> <nop>

" Autocomplete characters for coding -- {{{
inoremap ( ()<left>
inoremap [ []<left>
inoremap { {}<left>
inoremap {<CR> {<CR>}<ESC>O
inoremap {;<CR> {<CR>};<ESC>O

inoremap <expr> ) strpart(getline('.'), col('.')-1, 1) == ")" ? "\<Right>" : ")"
inoremap <expr> } strpart(getline('.'), col('.')-1, 1) == "}" ? "\<Right>" : "}"
inoremap <expr> ' strpart(getline('.'), col('.')-1, 1) == "'" ? "\<Right>" : "''<left>"
inoremap <expr> " strpart(getline('.'), col('.')-1, 1) == "\"" ? "\<Right>" : '""<left>'
inoremap <expr> ] strpart(getline('.'), col('.')-1, 1) == "]" ? "\<Right>" : "]"
" }}}

" Clear the last highlight
nnoremap <leader><cr> :nohlsearch<cr>

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

augroup js_files
    autocmd!
    autocmd FileType javascript nnoremap <buffer> <localleader>c I// <esc>
augroup END

augroup python_files
    autocmd!
    autocmd FileType python nnoremap <buffer> <localleader>c I# <esc>
    autocmd FileType python
        \ setlocal tabstop=4 |
        \ setlocal softtabstop=4 |
        \ setlocal shiftwidth=4 |
        \ setlocal expandtab |
        \ setlocal fileformat=unix
augroup END
" }}}

" Vimscript Tweaks -------------------- {{{
" Set silver searcher as default lgrep command
set grepprg=ag\ --vimgrep\ $* 
set grepformat=%f:%l:%c:%m
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
" Custom functions -------------------- {{{
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
" }}}
" Enable eslint if it's there
if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
    let g:coc_global_extensions += ['coc-eslint']
endif

nmap <silent> <leader>d <Plug>(coc-definition)
nmap <silent> <leader>K :call <SID>show_documentation()<CR>
nmap <leader>rn <Plug>(coc-rename)
" Tab in insert mode to trigger completion
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
" }}}
" }}}

" ASCII-cat, because why not?
echom ">^.^<"

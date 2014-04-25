"
" Load Vim Bundles in ~/.vimrc.bundle
"
filetype off
filetype plugin indent off
if filereadable(expand('~/.vimrc.bundle'))
  source $HOME/.vimrc.bundle
endif

"
" Shortcuts
"
nmap <leader>l :set list!<CR>
nmap <leader><leader>r :source ~/.vimrc<CR>
nmap <leader><leader>c :CtrlPClearCache<CR>
nmap < <<
nmap > >>

"
" Editor / Syntax Specific
"

" Use the same symbols as TextMate for tabstops and EOLs
set noswapfile
set listchars=tab:▸\ ,eol:¬
set shiftwidth=4
set softtabstop=4
set tabstop=4
set nocompatible
set runtimepath+=$GOROOT/misc/vim
set shortmess=ITao
set expandtab

"
" Searching
"
set hlsearch            " highlight searches
set incsearch           " do incremental searching
set showmatch           " jump to matches when entering regexp
set ignorecase          " ignore case when searching

" Syntastic
let g:syntastic_mode_map = {
  \ 'mode': 'active',
  \ 'active_filetypes': [],
  \ 'passive_filetypes': []
  \ }
let g:syntastic_puppet_puppetlint_args = '--no-80chars-check --no-double_quoted_strings-check --no-variable_scope-check --no-class_parameter_defaults'
let g:syntastic_python_checkers        = ['pyflakes', 'pep8']
let g:syntastic_python_pep8_args       = '--ignore=E221,E501,E502,W391 --max-line-length=1000'
let g:syntastic_javascript_checkers    = ['jshint']
let g:syntastic_coffee_checkers        = ['coffeelint', 'coffee']
let g:syntastic_haml_checkers          = ['haml_lint', 'haml']
let g:syntastic_ruby_checkers          = ['mri', 'rubocop']
let g:syntastic_sass_checkers          = ['sass']

" Tabulararize
if exists(":Tabularize")
  nmap <leader>t= :Tabularize /=<CR>
  vmap <leader>t= :Tabularize /=<CR>
  nmap <leader>t{ :Tabularize /{<CR>
  vmap <leader>t{ :Tabularize /{<CR>
  nmap <leader>t: :Tabularize /:\zs<CR>
  vmap <leader>t: :Tabularize /:\zs<CR>
  nmap <leader>t, :Tabularize /,\zs<CR>
  vmap <leader>t, :Tabularize /,\zs<CR>
  nmap <leader>t> :Tabularize /=><CR>
  vmap <leader>t> :Tabularize /=><CR>
  nmap <leader>t\| :Tabularize /\|<CR>
  vmap <leader>t\| :Tabularize /\|<CR> vmap <Leader>a: :Tabularize /:\zs<CR>
endif

"
" Powerline
"
set laststatus=2
set encoding=utf-8
set t_Co=256
let g:Powerline_symbols = 'fancy'
set noshowmode

"
" UI / Interface
"
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
set number
set guioptions=aAce
set splitbelow
set splitright

"
" Syntax Specific
"

" Python
let g:python_highlight_all=1
let g:python_highlight_builtins=1

" Go
let g:go_highlight_array_whitespace_error=1
let g:go_highlight_chan_whitespace_error=1
let g:go_highlight_extra_types=1
let g:go_highlight_space_tab_error=1
let g:go_highlight_trailing_whitespace_error=1
"au BufWritePost *.go !gofmt -w %
"autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Ruby
compiler ruby
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1


"
" Wildmenu
"
if has("wildmenu")
  set wildmenu
  set wildmode=list:longest,list:full
  set wildignore+=*.a,*.o,*.so,*.pyo,*.pyc,*.rbc,*.dSYM,*.beam,*.jar,*.class
  set wildignore+=*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd
  set wildignore+=*.tar.gz,*.tar.bz2,*.zip
  set wildignore+=.DS_Store,.git,.hg,.svn
  set wildignore+=*~,*.swp,*.swo,*.tmp,*.un~,*.log
  set wildignore+=*.vagrant/,*.env/
  set wildignore+=*log/*,*tmp/*,*script/*,*classes/*,*static_components/*,deploy/*
  set wildignore+=*node_modules/*,*.bundle/*,*vendor/*
endif

"
" File settings
"
set undofile

"
" File extension specific
"
augroup jinja
  au!
  au BufNewFile,BufRead *.jinja2,*.j2 set ft=jinja
augroup END

"
" Snippets
"
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-k>"
let g:UltiSnipsJumpForwardTrigger="<C-b>"
let g:UltiSnipsJumpBackwardTrigger="<C-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"
" Functions
"

" Remove trailing whitespace on save
function! Preserve(command)
  " Allow me to preserve whitespace on certain files
  " if necessary. Simply perform:
  " :let b:pw=1<cr> to preserve whitespace on that buffer
  if exists('b:pw') || exists('b:preserve')
    return
  endif
  " Save last search, and cursor position.
  let _s=@/
  let l = line(".")
  let c = col(".")
  " Do the business:
  execute a:command
  " Clean up: restore previous search history, and cursor position
  let @/=_s
  call cursor(l, c)
endfunction

" Execute clear whitespace on save
augroup whitespace
  autocmd!
  autocmd BufWritePre * :call Preserve("%s/\\s\\+$//e")
augroup END

function! SynStack()
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " > ")
endfunc

nnoremap <F7> :call SynStack()<CR>

function! ToggleWhitespaceSave()
  if exists('b:pw') && b:pw == 1
    unlet b:pw
    echo 'Stripping whitespace on save'
  else
    let b:pw = 1
    echo 'Preserving whitespace on save'
endif
endfunction

nnoremap <leader>pw :call ToggleWhitespaceSave()<cr>
" Clear search highlighting on esc
nnoremap <esc> :noh<return><esc>


syntax on
filetype on
filetype plugin on
filetype indent on

"
" Install functions
"
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status != 'unchanged' || a:info.force
    !./install.py --clang-completer --gocode-completer --racer-completer --tern-completer
  endif
endfunction

"
" Install Plugins
"
call plug#begin()

Plug 'tpope/vim-sensible'

Plug 'easymotion/vim-easymotion'
Plug 'rstacruz/sparkup', {'rtp': 'vim/'}
Plug 'jonathanfilip/vim-lucius'
Plug 'tomasr/molokai'
Plug 'aclindsa/detectindent'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown' " goes after tabular
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-git'
Plug 'tpope/vim-surround'
Plug 'rking/ag.vim'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'Chiel92/vim-autoformat'
Plug 'terryma/vim-multiple-cursors'

" Language Specific
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'hdima/python-syntax'
Plug 'vim-ruby/vim-ruby'
Plug 'tpope/vim-rbenv'
Plug 'thoughtbot/vim-rspec'
Plug 'kchmck/vim-coffee-script'
Plug 'JuliaLang/julia-vim'
Plug 'fatih/vim-go'
Plug 'fatih/vim-hclfmt'
Plug 'tomtom/tcomment_vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'slim-template/vim-slim'
Plug 'cespare/vim-toml'
Plug 'jez/vim-github-hub'
Plug 'elixir-lang/vim-elixir'
Plug 'carlosgaldino/elixir-snippets'

" Snippets
Plug 'justinj/vim-react-snippets'

" vim-scripts repos
Plug 'L9'
Plug 'FuzzyFinder'

call plug#end()

"
" UI / Interface
"
set encoding=utf-8
let g:solarized_termcolors=256
set background=dark
colorscheme solarized
set number
set guioptions=aAce
set splitbelow
set splitright
set colorcolumn=80
" set guifont=FiraCode-Retina:h13
set guifont=FuraMonoForPowerlineNerdFontCompleteMono---Medium:h13

if has('gui_running')
  set guifont=FuraMonoForPowerlineNerdFontCompleteMono---Medium:h13
else
  set t_Co=256
  syntax enable
  let g:solarized_termtrans = 1
  let g:solarized_termcolors=256
  set background=dark
  silent! colorscheme lucius
endif

" vim-devicons
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif
let g:webdevicons_enable                    = 1
let g:webdevicons_enable_ctrlp              = 1
let g:webdevicons_enable_nerdtree           = 1
let g:webdevicons_enable_airline_tabline    = 1
let g:webdevicons_enable_airline_statusline = 1

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:WebDevIconsNerdTreeAfterGlyphPadding = '  '
let g:DevIconsEnableFoldersOpenClose = 1
let g:webdevicons_conceal_nerdtree_brackets = 1
let g:webdevicons_enable_nerdtree = 1

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
" vim-airline
"
let g:airline_powerline_fonts = 1
let g:airline_theme='molokai'
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

"
" CtrlP
"
let g:ctrlp_custom_ignore = {
  \ 'dir': '\v[\/](\.git|\.hg|\.svn|\.DS_STORE|\/vendor)$',
  \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
\}
let g:ctrlp_show_hidden = 1
" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

"
" Searching
"
set hlsearch            " highlight searches
set incsearch           " do incremental searching
set showmatch           " jump to matches when entering regexp
set ignorecase          " ignore case when searching

"
" Syntastic
"
let g:syntastic_mode_map = {
  \ 'mode': 'active',
  \ 'active_filetypes': [],
  \ 'passive_filetypes': []
  \ }
let g:syntastic_puppet_puppetlint_args = '--no-80chars-check --no-double_quoted_strings-check --no-variable_scope-check --no-class_parameter_defaults'
let g:syntastic_python_checkers        = ['pyflakes', 'pep8']
let g:syntastic_python_pep8_args       = '--ignore=E221,E501,E502,W391 --max-line-length=1000'
let g:syntastic_javascript_checkers    = ['eslint']
let g:syntastic_coffee_checkers        = ['coffeelint', 'coffee']
let g:syntastic_haml_checkers          = ['haml_lint', 'haml']
let g:syntastic_ruby_checkers          = ['mri', 'rubocop', 'reek']
let g:syntastic_sass_checkers          = ['sass']
let g:syntastic_shell                  = "/bin/sh"
let g:syntastic_elixir_checkers        = ['elixir']
let g:syntastic_enable_elixir_checker  = 1

"
" NERDTree
"
map <leader><leader>n :NERDTreeToggle<CR>
map <leader><leader>nf :NERDTreeFind<CR>
let g:NERDTreeWinSize = 30
autocmd FileType nerdtree setlocal nolist
" Close if only NERDTree is open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

"
" Completion / Snippets
"
"
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#auto_completion_start_length = 1
let g:neocomplete#sources#buffer#cache_limit_size = 50000
let g:neocomplete#data_directory = $HOME.'/.vim/cache/noecompl'
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#enable_auto_select = 1

if !exists('g:neocomplete#keyword_patterns')
let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
" Neosnippet
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

"
" Tabulararize
"
nmap <leader><leader>t= :Tabularize /=<CR>
vmap <leader><leader>t= :Tabularize /=<CR>
nmap <leader><leader>t{ :Tabularize /{<CR>
vmap <leader><leader>t{ :Tabularize /{<CR>
nmap <leader><leader>t: :Tabularize /:\zs<CR>
vmap <leader><leader>t: :Tabularize /:\zs<CR>
nmap <leader><leader>t, :Tabularize /,\zs<CR>
vmap <leader><leader>t, :Tabularize /,\zs<CR>
nmap <leader><leader>t> :Tabularize /=><CR>
vmap <leader><leader>t> :Tabularize /=><CR>
nmap <leader><leader>t\| :Tabularize /\|<CR>
vmap <leader><leader>t\| :Tabularize /\|<CR> vmap <Leader>a: :Tabularize /:\zs<CR>

"
" Powerline
"
set laststatus=2
set t_Co=256
let g:Powerline_symbols = 'fancy'
set noshowmode

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
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

au FileType go nmap <leader><leader>gr :GoRun<CR><CR>
au FileType go nmap <leader><leader>gb :GoBuild<CR><CR>
au FileType go nmap <leader><leader>gt :GoTest<CR><CR>
au FileType go nmap <leader><leader>gc :GoCoverage<CR><CR>
au FileType go nmap <leader><leader>gl :GoLint<CR><CR>
au Filetype go nnoremap <leader><leader>gd :vsplit <CR>:exe "GoDef" <CR><CR>
" Imports turned off by default now
let g:go_fmt_command = "goimports"
"au BufWritePost *.go !gofmt -w %
"autocmd FileType go autocmd BufWritePre <buffer> Fmt

" Ruby
" compiler ruby
" autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
" autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
" autocmd FileType ruby,eruby let g:rubycomplete_rails = 1

" RSpec.vim mappings
map <Leader><Leader>rt :call RunCurrentSpecFile()<CR>
map <Leader><Leader>rs :call RunNearestSpec()<CR>
map <Leader><Leader>rl :call RunLastSpec()<CR>
map <Leader><Leader>ra :call RunAllSpecs()<CR>
let g:rspec_runner = "os_x_iterm2"
if has('gui_running')
  let g:rspec_command = "if [ -f ./bin/rspec ]; then ./bin/rspec {spec}; else if [ `bundle exec which rspec` ]; then bundle exec rspec {spec}; else rspec {spec}; fi; fi"
else
  let g:rspec_command = "!if [ -f ./bin/rspec ]; then ./bin/rspec {spec}; else if [ `bundle exec which rspec` ]; then bundle exec rspec {spec}; else rspec {spec}; fi; fi"
endif

" Javascript
let g:jsx_ext_required = 0

"
" HCL
"
let g:hcl_fmt_autosave=1

noremap <leader><leader>f :Autoformat<CR><CR>

" Markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_frontmatter=1

"
" TComment
"
noremap <D-/> :TComment<CR>


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
  set wildignore+=*log/*,*tmp/*,*classes/*,*static_components/*,deploy/*
  set wildignore+=*node_modules/*,*.bundle/*,*vendor/*,vendor/ruby/*
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

" Tell Neosnippet about the other snippets
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'

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

" Disabling the directional keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

map <c-i> <Esc>
imap <c-i> <Esc>

"
" Buffers
"

" multiple buffers
set hidden

" New tab
nmap <leader>T :enew<cr>

" Navigate buffers
noremap <silent> <C-h> :bprev<CR>
noremap <silent> <C-l> :bnext<CR>

" Closes the current buffer
nnoremap <silent> <Leader>bq :Bclose<CR>

" close buffer
nmap <leader>bd :bd<CR>
" close all buffers
nmap <leader>D :bufdo bd<CR>

syntax on
filetype on
filetype plugin on
filetype indent on

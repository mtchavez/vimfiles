"
" Vim Setup
"
" vim: set sw=2 ts=2 sts=2 et tw=78 foldmarker={,} foldlevel=0 foldmethod=marker spell:

"
" Environment
"

" Identify platform
silent function! OSX()
  return has('macunix')
endfunction
silent function! LINUX()
  return has('unix') && !has('macunix') && !has('win32unix')
endfunction
silent function! WINDOWS()
  return  (has('win32') || has('win64'))
endfunction

" Basics
" Must be first line
set nocompatible
if !WINDOWS()
  set shell=/bin/sh
endif

" Windows Compatible
" On Windows, also use '.vim' instead of 'vimfiles'; this makes synchronization
" across (heterogeneous) systems easier.
if WINDOWS()
  set runtimepath=$HOME/.vim,$VIM/vimfiles,$VIMRUNTIME,$VIM/vimfiles/after,$HOME/.vim/after
endif

" Arrow Key Fix
" https://github.com/spf13/spf13-vim/issues/780
if &term[:4] ==# 'xterm' || &term[:5] ==# 'screen' || &term[:3] ==# 'rxvt'
  inoremap <silent> <C-[>OC <RIGHT>
endif

"
" Bundles/Plugins
"

" Load in bundles
if filereadable(expand('~/.vimrc.plug'))
  source ~/.vimrc.plug
endif

"
" General
"
set encoding=utf-8
set background=dark
set number
" set guioptions=aAce
set splitbelow
set splitright
set colorcolumn=80
" set guifont=FiraCode-Retina:h13
set guifont=FuraMonoForPowerlineNerdFontCompleteMono---Medium:h13

filetype plugin indent on   " Automatically detect file types.
filetype plugin on
syntax on                   " Syntax highlighting
set mouse=a                 " Automatically enable mouse usage
set mousehide               " Hide the mouse cursor while typing
scriptencoding utf-8

if has('clipboard')
  if has('unnamedplus')  " When possible use + register for copy-paste
    set clipboard=unnamed,unnamedplus
  else         " On mac and Windows, use * register for copy-paste
    set clipboard=unnamed
  endif
endif

set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
set viewoptions=folds,options,cursor,unix,slash " Better Unix / Windows compatibility
set virtualedit=onemore             " Allow for cursor beyond last character
set history=1000                    " Store a ton of history (default is 20)
" set spell                           " Spell checking on
set hidden                          " Allow buffer switching without saving
set iskeyword-=.                    " '.' is an end of word designator
set iskeyword-=#                    " '#' is an end of word designator
set iskeyword-=-                    " '-' is an end of word designator

" Instead of reverting the cursor to the last position in the buffer, we
" set it to the first line when editing a git commit message
augroup commitmsg
  au FileType gitcommit au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
augroup END

" Setting up the directories
set backup                    " Backups are nice ...
if has('persistent_undo')
  set undofile                " So is persistent undo ...
  set undolevels=1000         " Maximum number of changes that can be undone
  set undoreload=10000        " Maximum number lines to save for undo on a buffer reload
endif

"
" Vim UI
"
if !has('gui_running') && filereadable(expand('~/.vim/plugged/vim-lucius/colors/lucius.vim'))
  set t_Co=256
  set background=dark
  silent! colorscheme lucius
elseif filereadable(expand('~/.vim/plugged/vim-colors-solarized/colors/solarized.vim'))
  let g:solarized_termcolors=256
  let g:solarized_termtrans=1
  let g:solarized_contrast='normal'
  let g:solarized_visibility='normal'
  color solarized             " Load a colorscheme
  colorscheme solarized
endif

let g:sol = {
\  'gui': {
\   'base03': '#002b36',
\   'base02': '#073642',
\   'base01': '#586e75',
\   'base00': '#657b83',
\   'base0': '#839496',
\   'base1': '#93a1a1',
\   'base2': '#eee8d5',
\   'base3': '#fdf6e3',
\   'yellow': '#b58900',
\   'orange': '#cb4b16',
\   'red': '#dc322f',
\   'magenta': '#d33682',
\   'violet': '#6c71c4',
\   'blue': '#268bd2',
\   'cyan': '#2aa198',
\   'green': '#719e07'
\  },
\  'cterm': {
\   'base03': 8,
\   'base02': 0,
\   'base01': 10,
\   'base00': 11,
\   'base0': 12,
\   'base1': 14,
\   'base2': 7,
\   'base3': 15,
\   'yellow': 3,
\   'orange': 9,
\   'red': 1,
\   'magenta': 5,
\   'violet': 13,
\   'blue': 4,
\   'cyan': 6,
\   'green': 2
\  }
\}

set tabpagemax=15               " Only show 15 tabs
set showmode                    " Display the current mode
set cursorline                  " Highlight current line

highlight clear SignColumn      " SignColumn should match background
highlight clear LineNr          " Current line number row will have same background color in relative mode
"highlight clear CursorLineNr    " Remove highlight color from current line number

if has('cmdline_info')
  set ruler                   " Show the ruler
  set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
  set showcmd                 " Show partial commands in status line and
  " Selected characters/lines in visual mode
endif

if has('statusline')
  set laststatus=2
  " Broken down into easily includeable segments
  set statusline=%<%f\                     " Filename
  set statusline+=%w%h%m%r                 " Options

  set statusline+=%{fugitive#statusline()} " Git Hotness

  set statusline+=\ [%{&ff}/%Y]            " Filetype
  set statusline+=\ [%{getcwd()}]          " Current dir
  set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
endif

set backspace=indent,eol,start  " Backspace for dummies
set linespace=0                 " No extra spaces between rows
set number                      " Line numbers on
set showmatch                   " Show matching brackets/parenthesis
set incsearch                   " Find as you type search
set hlsearch                    " Highlight search terms
set winminheight=0              " Windows can be 0 line high
set ignorecase                  " Case insensitive search
set smartcase                   " Case sensitive when uc present
set wildmenu                    " Show list instead of just completing
set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
set scrolljump=5                " Lines to scroll when cursor leaves screen
set scrolloff=3                 " Minimum lines to keep above and below cursor
set foldenable                  " Auto fold code
set list
set listchars=tab:›\ ,trail:•,extends:#,nbsp:. " Highlight problematic whitespace

if has('gui_runningbundles')
  set guifont=FuraMonoForPowerlineNerdFontCompleteMono---Medium:h13
endif

"
" Formatting
"
set nowrap                      " Do not wrap long lines
set autoindent                  " Indent at the same level of the previous line
set shiftwidth=2                " Use indents of 2 spaces
set expandtab                   " Tabs are spaces, not tabs
set tabstop=2                   " An indentation every four columns
set softtabstop=2               " Let backspace delete indent
set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
set splitright                  " Puts new vsplit windows to the right of the current
set splitbelow                  " Puts new split windows to the bottom of the current
"set matchpairs+=<:>             " Match, to be used with %
set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
set noswapfile
" set runtimepath+=$GOROOT/misc/vim

"
" Key mappings
"

" Wrapped lines goes down/up to next row, rather than next line in file.
noremap j gj
noremap k gk

" Shift key fixes
if has('user_commands')
  command! -bang -nargs=* -complete=file E e<bang> <args>
  command! -bang -nargs=* -complete=file W w<bang> <args>
  command! -bang -nargs=* -complete=file Wq wq<bang> <args>
  command! -bang -nargs=* -complete=file WQ wq<bang> <args>
  command! -bang Wa wa<bang>
  command! -bang WA wa<bang>
  command! -bang Q q<bang>
  command! -bang QA qa<bang>
  command! -bang Qa qa<bang>
endif
cmap Tabe tabe


" Code folding options
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

" Find merge conflict markers
map <leader>fc /\v^[<\|=>]{7}( .*\|$)<CR>

" Shortcuts
" Change Working Directory to that of the current file
cmap cwd lcd %:p:h
cmap cd. lcd %:p:h

" Visual shifting (does not exit Visual mode)
vnoremap < <gv
vnoremap > >gv

" Allow using the repeat operator with a visual selection (!)
" http://stackoverflow.com/a/8064607/127816
vnoremap . :normal .<CR>

" For when you forget to sudo.. Really Write the file.
cmap w!! w !sudo tee % >/dev/null

" Some helpers to edit mode
" http://vimcasts.org/e/14
cnoremap %% <C-R>=fnameescape(expand('%:h')).'/'<cr>
map <leader>ew :e %%
map <leader>es :sp %%
map <leader>ev :vsp %%
map <leader>et :tabe %%

" Adjust viewports to the same size
map <Leader>= <C-w>=

" nmap <leader>l :set list!<CR>
" nmap <leader><leader>r :source ~/.vimrc<CR>
nmap <leader>cc :CtrlPClearCache<CR>
nmap < <<
nmap > >>

" Clear search highlighting on esc
nnoremap <esc> :noh<return><esc>

" Buffers
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

"
" Plugins
"

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
" vim-easytags
"
let g:easytags_by_filetype = '~/.vimtags'
let g:easytags_autorecurse = 1
let g:easytags_async = 1
let g:easytags_auto_update = 1
let g:easytags_on_cursorhold = 1
let g:easytags_python_enabled = 1
let g:easytags_auto_highlight = 0
let g:easytags_events = ['']
nmap <leader>ut :UpdateTags!<cr>

"
" CtrlP
"
let g:ctrlp_custom_ignore = {
      \ 'dir': '\v[\/](\.git|\.hg|\.svn|\.DS_STORE|vendor|node_modules|tmp)$',
      \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg|log)$',
      \}
let g:ctrlp_show_hidden = 1
let g:ctrlp_working_path_mode = 'ra'
" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>
nnoremap <silent> <D-t> :CtrlP<CR>
nnoremap <silent> <D-r> :CtrlPMRU<CR>

if executable('ag')
  let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
elseif executable('ack-grep')
  let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
elseif executable('ack')
  let s:ctrlp_fallback = 'ack %s --nocolor -f'
  " On Windows use "dir" as fallback command.
elseif WINDOWS()
  let s:ctrlp_fallback = 'dir %s /-n /b /s /a-d'
else
  let s:ctrlp_fallback = 'find %s -type f'
endif

let g:ctrlp_user_command = s:ctrlp_fallback
" if exists('g:ctrlp_user_command')
"   unlet g:ctrlp_user_command
" endif
"
" let g:ctrlp_user_command = {
"       \ 'types': {
"       \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
"       \ 2: ['.hg', 'hg --cwd %s locate -I .'],
"       \ },
"       \ 'fallback': s:ctrlp_fallback
"       \ }

if isdirectory(expand('~/.vim/plugged/ctrlp-funky/'))
  " CtrlP extensions
  let g:ctrlp_extensions = ['funky']
  let g:ctrlp_funky_syntax_highlight = 1
  let g:ctrlp_funky_matchtype = 'path'

  "funky
  nnoremap <Leader>fu :CtrlPFunky<Cr>
  " narrow the list down with a word under cursor
  nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
endif

" TagBar
if isdirectory(expand('~/.vim/plugged/tagbar/'))
  nnoremap <silent> <leader>tt :TagbarToggle<CR>
endif

let g:tagbar_type_coffee = {
      \ 'ctagstype' : 'coffee',
      \ 'kinds'     : [
      \ 'c:classes',
      \ 'm:methods',
      \ 'f:functions',
      \ 'v:variables',
      \ 'f:fields',
      \ ]
      \ }

" Fugitive
if isdirectory(expand('~/.vim/plugged/vim-fugitive/'))
  nnoremap <silent> <leader>gs :Gstatus<CR>
  nnoremap <silent> <leader>gd :Gdiff<CR>
  nnoremap <silent> <leader>gc :Gcommit<CR>
  nnoremap <silent> <leader>gb :Gblame<CR>
  nnoremap <silent> <leader>gl :Glog<CR>
  nnoremap <silent> <leader>gp :Git push<CR>
  nnoremap <silent> <leader>gr :Gread<CR>
  nnoremap <silent> <leader>gw :Gwrite<CR>
  nnoremap <silent> <leader>ge :Gedit<CR>
  " Mnemonic _i_nteractive
  nnoremap <silent> <leader>gi :Git add -p %<CR>
  nnoremap <silent> <leader>gg :SignifyToggle<CR>
endif

"
" Syntastic
"
" let g:syntastic_mode_map = {
" \ 'mode': 'active',
" \ 'active_filetypes': [],
" \ 'passive_filetypes': []
" \ }
" let g:syntastic_puppet_puppetlint_args = '--no-80chars-check --no-double_quoted_strings-check --no-variable_scope-check --no-class_parameter_defaults'
" let g:syntastic_python_checkers        = ['pyflakes', 'pep8']
" let g:syntastic_python_pep8_args       = '--ignore=E221,E501,E502,W391 --max-line-length=1000'
" let g:syntastic_javascript_checkers    = ['eslint']
" let g:syntastic_coffee_checkers        = ['coffeelint', 'coffee']
" let g:syntastic_haml_checkers          = ['haml_lint', 'haml']
" let g:syntastic_ruby_checkers          = ['mri', 'rubocop', 'reek']
" let g:syntastic_sass_checkers          = ['sass']
" let g:syntastic_shell                  = "/bin/sh"
" let g:syntastic_elixir_checkers        = ['elixir']
" let g:syntastic_enable_elixir_checker  = 1
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:elm_syntastic_show_warnings = 1

"
" Ale
"
" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

" Cycle through errors
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
map <leader>af :ALEFix<CR>

let g:ale_fixers = {
    \ 'ruby': ['rubocop'] }

"
" NERDTree
"
map <leader>nt :NERDTreeToggle<CR>
map <leader>nf :NERDTreeFind<CR>
let g:NERDTreeWinSize = 30
augroup ntree
  autocmd FileType nerdtree setlocal nolist
augroup END
" Close if only NERDTree is open
" autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
  if a:fg !=# ''
    exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermfg='. a:fg .' guifg=#'. a:guifg
  endif
  if a:bg !=# 'none'
    exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' guibg=#'. a:guibg
  endif
  " exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg=#'. a:guibg .' guifg=#'. a:guifg
  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

let g:NERDTreeShowBookmarks=1
let g:NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$', '\.log$']
let g:NERDTreeChDirMode=0
let g:NERDTreeQuitOnOpen=1
let g:NERDTreeMouseMode=2
let g:NERDTreeShowHidden=1
let g:NERDTreeKeepTreeInNewTab=1
let g:NERDShutUp=1
let g:nerdtree_tabs_open_on_gui_startup=0

let g:NERDTreeSyntaxDisableDefaultExtensions = 1
let g:NERDTreeDisableExactMatchHighlight = 1
let g:NERDTreeDisablePatternMatchHighlight = 1

" Session List
set sessionoptions=blank,buffers,curdir,folds,tabpages,winsize
if isdirectory(expand('~/.vim/plugged/sessionman.vim/'))
  nmap <leader>sl :SessionList<CR>
  nmap <leader>ss :SessionSave<CR>
  nmap <leader>sc :SessionClose<CR>
endif

" vim-devicons
" Load after nerdtree
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

let g:WebDevIconsUnicodeDecorateFolderNodes = 1
let g:DevIconsEnableFoldersOpenClose = 1

augroup devicons
  autocmd!
  autocmd FileType nerdtree setlocal nolist
  autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\]" contained conceal containedin=ALL
  autocmd FileType nerdtree syntax match hideBracketsInNerdTree "\[" contained conceal containedin=ALL
  autocmd FileType nerdtree setlocal conceallevel=3
  autocmd FileType nerdtree setlocal concealcursor=nvic
augroup END

function! DeviconsColors(config)
  let l:colors = keys(a:config)
  augroup devicons_colors
    autocmd!
    for l:color in l:colors
      if l:color ==# 'normal'
        exec 'autocmd FileType nerdtree if &background == ''dark'' | '.
              \ 'highlight devicons_'.l:color.' guifg='.g:sol.gui.base01.' ctermfg='.g:sol.cterm.base01.' | '.
              \ 'else | '.
              \ 'highlight devicons_'.l:color.' guifg='.g:sol.gui.base1.' ctermfg='.g:sol.cterm.base1.' | '.
              \ 'endif'
      elseif l:color ==# 'emphasize'
        exec 'autocmd FileType nerdtree if &background == ''dark'' | '.
              \ 'highlight devicons_'.l:color.' guifg='.g:sol.gui.base1.' ctermfg='.g:sol.cterm.base1.' | '.
              \ 'else | '.
              \ 'highlight devicons_'.l:color.' guifg='.g:sol.gui.base01.' ctermfg='.g:sol.cterm.base01.' | '.
              \ 'endif'
      else
        exec 'autocmd FileType nerdtree highlight devicons_'.l:color.' guifg='.g:sol.gui[l:color].' ctermfg='.g:sol.cterm[l:color]
      endif
      exec 'autocmd FileType nerdtree syntax match devicons_'.l:color.' /\v'.join(a:config[l:color], '|').'/ containedin=ALL'
    endfor
  augroup END
endfunction
let g:devicons_colors = {
      \'normal': ['', '', '', '', ''],
      \'emphasize': ['', '', '', '', '', '', '', '', '', '', ''],
      \'yellow': ['', '', ''],
      \'orange': ['', '', '', 'λ', '', ''],
      \'red': ['', '', '', '', '', '', '', '', ''],
      \'magenta': [''],
      \'violet': ['', '', '', ''],
      \'blue': ['', '', '', '', '', '', '', '', '', '', '', '', ''],
      \'cyan': ['', '', '', ''],
      \'green': ['', '', '', '']
      \}
call DeviconsColors(g:devicons_colors)


"
" Completion / Snippets
"
"
"" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : ''
      \ }
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#auto_completion_start_length = 1
let g:neocomplete#sources#buffer#cache_limit_size = 50000
let g:neocomplete#data_directory = $HOME.'/.vim/cache/noecompl'
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 2
let g:neocomplete#enable_auto_select = 1
" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.elm = '\.'


if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" YCM
let g:ycm_semantic_triggers = { 'elm' : ['.'] }

" Neosnippet
if has('neosnippet')
  imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: pumvisible() ? "\<C-n>" : "\<TAB>"
  smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
        \ "\<Plug>(neosnippet_expand_or_jump)"
        \: "\<TAB>"
endif

"
" Tabulararize
"
nmap <leader>a& :Tabularize /&<CR>
vmap <leader>a& :Tabularize /&<CR>
nmap <leader>a= :Tabularize /^[^=]*\zs=<CR>
vmap <leader>a= :Tabularize /^[^=]*\zs=<CR>
nmap <leader>a=> :Tabularize /=><CR>
vmap <leader>a=> :Tabularize /=><CR>
nmap <leader>a: :Tabularize /:<CR>
vmap <leader>a: :Tabularize /:<CR>
nmap <leader>a:: :Tabularize /:\zs<CR>
vmap <leader>a:: :Tabularize /:\zs<CR>
nmap <leader>a, :Tabularize /,<CR>
vmap <leader>a, :Tabularize /,<CR>
nmap <leader>a,, :Tabularize /,\zs<CR>
vmap <leader>a,, :Tabularize /,\zs<CR>
nmap <leader>a{ :Tabularize /{<CR>
vmap <leader>a{ :Tabularize /{<CR>
nmap <leader>a> :Tabularize /=><CR>
vmap <leader>a> :Tabularize /=><CR>
nmap <leader>a<Bar> :Tabularize /<Bar><CR>
vmap <leader>a<Bar> :Tabularize /<Bar><CR>
nmap <leader>a\| :Tabularize /\|<CR>
vmap <leader>a\| :Tabularize /\|<CR> vmap <leader>a: :Tabularize /:\zs<CR>

" TComment
noremap <D-/> :TComment<CR>

" Wildmenu
if has('wildmenu')
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

" Snippets
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger='<C-k>'
let g:UltiSnipsJumpForwardTrigger='<C-b>'
let g:UltiSnipsJumpBackwardTrigger='<C-z>'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit='vertical'

" Tell Neosnippet about the other snippets
if has('neosnippet')
  let g:neosnippet#snippets_directory='~/.vim/plugged/vim-snippets/snippets'
endif

"
" Syntax Specific
"

" Python
let g:python_highlight_all=1
let g:python_highlight_builtins=1
augroup jinja
  au!
  au BufNewFile,BufRead *.jinja2,*.j2 set ft=jinja
augroup END


" Go
let g:go_highlight_array_whitespace_error=1
let g:go_highlight_chan_whitespace_error=1
let g:go_highlight_extra_types=1
let g:go_highlight_space_tab_error=1
let g:go_highlight_trailing_whitespace_error=1
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

augroup gocmds
  au FileType go nmap <leader><leader>gr :GoRun<CR><CR>
  au FileType go nmap <leader><leader>gb :GoBuild<CR><CR>
  au FileType go nmap <leader><leader>gt :GoTest<CR><CR>
  au FileType go nmap <leader><leader>gc :GoCoverage<CR><CR>
  au FileType go nmap <leader><leader>gl :GoLint<CR><CR>
  au Filetype go nnoremap <leader><leader>gd :vsplit <CR>:exe "GoDef" <CR><CR>
augroup END
" Imports turned off by default now
let g:go_fmt_command = 'goimports'
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
let g:rspec_runner = 'os_x_iterm2'
if has('gui_running')
  let g:rspec_command = 'if [ -f ./bin/rspec ]; then ./bin/rspec {spec}; else if [ `bundle exec which rspec` ]; then bundle exec rspec {spec}; else rspec {spec}; fi; fi'
else
  let g:rspec_command = '!if [ -f ./bin/rspec ]; then ./bin/rspec {spec}; else if [ `bundle exec which rspec` ]; then bundle exec rspec {spec}; else rspec {spec}; fi; fi'
endif

" Javascript
let g:jsx_ext_required = 0

" Elm
let g:elm_format_autosave = 1

"
" HCL
"
let g:hcl_fmt_autosave=1

noremap <leader><leader>f :Autoformat<CR><CR>

" Markdown
let g:vim_markdown_folding_disabled=1
let g:vim_markdown_frontmatter=1

" Elixir
let g:alchemist#elixir_erlang_src = '/usr/local/opt/elixir'

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
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), ' > ')
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

" Initialize directories
function! InitializeDirectories()
  let parent = $HOME
  let prefix = 'vim'
  let dir_list = {
        \ 'backup': 'backupdir',
        \ 'views': 'viewdir',
        \ 'swap': 'directory' }

  if has('persistent_undo')
    let dir_list['undo'] = 'undodir'
  endif

  " To specify a different directory in which to place the vimbackup,
  " vimviews, vimundo, and vimswap files/directories, add the following to
  " your .vimrc.before.local file:
  let common_dir = parent . '/.' . prefix

  for [dirname, settingname] in items(dir_list)
    let directory = common_dir . dirname . '/'
    if exists("*mkdir")
      if !isdirectory(directory)
        call mkdir(directory)
      endif
    endif

    if !isdirectory(directory)
      echo "Warning: Unable to create backup directory: " . directory
      echo "Try: mkdir -p " . directory
    else
      let directory = substitute(directory, " ", "\\\\ ", "g")
      exec "set " . settingname . "=" . directory
    endif
  endfor
endfunction
call InitializeDirectories()

" Disabling the directional keys
" map <up> <nop>
" map <down> <nop>
" map <left> <nop>
" map <right> <nop>
" imap <up> <nop>
" imap <down> <nop>
" imap <left> <nop>
" imap <right> <nop>
"
" map <c-i> <Esc>
" imap <c-i> <Esc>

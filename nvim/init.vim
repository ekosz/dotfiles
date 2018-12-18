" ==== Plugins =====================  {{{
" ==================================
filetype off                   " required!

call plug#begin('~/.vim/plugged')

function! DoRemote(arg)
  UpdateRemotePlugins
endfunction

" My Bundles here:
" GLOBALS
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-dispatch'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'vim-utils/vim-husk'
Plug 'sheerun/vim-polyglot'
Plug 'w0rp/ale'
Plug 'sjl/gundo.vim', { 'on': 'GundoToggle' }
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'sickill/vim-pasta'
Plug 'mileszs/ack.vim', { 'on': 'Ack' }
Plug '/usr/local/opt/fzf' | Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'
Plug 'terryma/vim-expand-region'
Plug 'vim-scripts/gitignore'
Plug 'editorconfig/editorconfig-vim'
Plug 'SirVer/ultisnips'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'easymotion/vim-easymotion'
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/echodoc.vim'
Plug 'reasonml-editor/vim-reason-plus'
Plug 'roxma/nvim-completion-manager'

" UI HELPERS
Plug 'bling/vim-airline'
Plug 'airblade/vim-gitgutter'

" RUBY
Plug 'tpope/vim-rails', { 'for': 'ruby' }
Plug 'thoughtbot/vim-rspec', { 'for': 'ruby' }

" JAVASCRIPT
Plug 'ternjs/tern_for_vim', { 'for': ['javascript'], 'do': 'npm i' }
" Fast lookup of npm bins
Plug 'jaawerth/nrun.vim'

" The best colors
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim/' }
Plug 'vim-airline/vim-airline-themes'

call plug#end()

" }}}

" ==== General ===================== {{{
" ==================================
filetype plugin indent on
syntax enable

set shell=/bin/zsh " Use zsh as shell
set foldmethod=syntax " fold based on syntax
set foldnestmax=10 " deepest fold is 10 levels
set nofoldenable " dont fold by default
set foldlevel=1 " this is just what i use
set modelines=0 " turn off modelines
set tabstop=2  " 2 space indents by default
set shiftwidth=2 " ...
set softtabstop=2 " ...
set expandtab " ...
set undofile " Save a file of all of the undos
set undolevels=1000 " Maximum number of changes that can be undone
set backupdir=~/.vim/vimtmp,. " store backups in the .vim directory
set directory=~/.vim/vimtmp,. " ...
set undodir=~/.vim/vimtmp,. " ...
set encoding=utf-8 " Always use UTF8 encodding
set scrolloff=3 " Min. lines to keep above or below the cursor when scrolling
set autoindent " Auto indent new lines
set noshowmode " Don't show current mode, let airline handle that
set hidden " Don't unload buffers when leaving them
set wildmenu " Enable command-line like completion
set wildmode=list:longest " List all matches and complete till longest common string
set visualbell " Disable annoying beep
set cursorline " Show line where cursor is
set ruler " Show current cursor position
set backspace=indent,eol,start " Backspace over everything in insert mode
set laststatus=2 " Always show the status line
set relativenumber " Use relative line numbers
set ignorecase " Ignore case when searching
set smartcase " Be case sensitive when there are capital letters
set gdefault " Globally replace be default
set incsearch " Start searching after first letter
set showmatch " Show the matching paren when hovering over one
set hlsearch " Highlight found search results
set splitbelow " Split below be default
set splitright " Split to the right by default
set winminwidth=5 " Windows can not get smaller than 5 columns
set winwidth=110 " Windows are set to 110 columns by default
set textwidth=79 " Wrap text around the 79 column
set formatoptions=qrn1 " Misc formating options
set colorcolumn=100 " Color the 100th column
set pastetoggle=<F3> " Go into paste mode with F3
set complete=.,b,u,] " Tab complete correctly
set t_Co=256 " Give me all the colors pls
set nobackup " Don't make backups
set noswapfile " Don't make swap files
set list " Show unprintable characters
set listchars=tab:▸\  " Char representing a tab
set listchars+=extends:❯ " Char representing an extending line
set listchars+=precedes:❮ " Char representing an extending line in the other direction
set listchars+=nbsp:␣ " Non breaking space
set listchars+=trail:· " Show trailing spaces as dots
set showbreak=↪  " Show wraped lines with this char
set linebreak " Don't break lines in the middle of words
set fillchars+=vert:\  " Don't show pipes in vertical splits
set background=dark " I use a dark background
set nowrap " Don't wrap lines
set synmaxcol=300 " do not highlith very long lines
" set completeopt+=menuone " Better auto complete
" set completeopt-=preview

colorscheme Tomorrow-Night-Eighties
" }}}

" ==== Auto commands =============== {{{
" ==================================

fun! StripTrailingWhitespace()
  " Only strip if the b:noStripeWhitespace variable isn't set
  if exists('b:noStripWhitespace')
    return
  endif
  %s/\s\+$//e
endfun

augroup miscGroup
  autocmd!

  " Jump to last cursor position unless it's invalid or in an event handler
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  autocmd BufWritePre * call StripTrailingWhitespace()
  autocmd FocusLost * :wa " Save on focus

  autocmd FileType php setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufNewFile,BufRead Gemfile set filetype=ruby
  autocmd BufNewFile,BufRead *.embl set filetype=emblem
  autocmd BufNewFile,BufRead *.hiccup set filetype=clojure
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{babel,eslint,stylelint,jshint}*rc,\.tern-*,*.json set ft=json
  autocmd BufNewFile,BufRead .tags set ft=tags

  "Fugitive
  autocmd QuickFixCmdPost *grep* cwindow " Auto open quickfix after grep
  autocmd QuickFixCmdPost *log* cwindow " Auto open quickfix after log

  "Spelling
  autocmd BufRead,BufNewFile *.md setlocal spell
  autocmd FileType gitcommit setlocal spell

  " Javascript formatting
  " Use prettier to format JS with gq
  autocmd FileType javascript set formatprg=prettier\ --stdin\ --print-width\ 100\ --single-quote\ --trailing-comma\ all
augroup END

autocmd FileType javascript.jsx set commentstring={/*\ %s\ */}

" }}}

" ==== Mappings ==================== {{{
" ==================================

"NERDTree
map <F2> :NERDTreeToggle<CR>

"Gundo
nnoremap <F5> :GundoToggle<CR>

" easymotion
nmap S <Plug>(easymotion-overwin-f2)

" `noremap` means to make a nonrecursive mapping
" that means that vim will not take other mapping
" into account when doing your new map

" Disable useless and annoying keys
noremap Q <Nop>

" Add keys for LanguageClient
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>

" Remap :E to :e
cnoreabbrev <expr> E getcmdtype() == ":" && getcmdline() == "E" ? "e" : "E"
" Remap :W to :w
cnoreabbrev <expr> W getcmdtype() == ":" && getcmdline() == "W" ? "w" : "W"

" Make Y work as expected
nnoremap Y y$

" Always use very magic regex mode when searching
nnoremap / /\v
vnoremap / /\v
nnoremap ? ?\v

nnoremap <tab> %
vnoremap <tab> %

" Resize windows with the arrow keys
nnoremap <up> <C-W>+
nnoremap <down> <C-W>-
nnoremap <left> 3<C-W>>
nnoremap <right> 3<C-W><

" Don't use those stupid arrow keys!
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

"Don't need help
inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>

"Fast escapes
inoremap jj <ESC>
inoremap jk <ESC>
inoremap kj <ESC>

"Search buffers
nmap ; :Buffers<CR>

" Fix for nvim
if has('nvim')
  nmap <BS> <C-W>h
endif

" vim-expand-region
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Better scrolling
map <ScrollWheelUp> <C-Y>
map <S-ScrollWheelUp> <C-U>
map <ScrollWheelDown> <C-E>
map <S-ScrollWheelDown> <C-D><Paste>

" Move highlited code up and down
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Search for the word under the cursor in the current directory
nmap <M-k>    mo:Ack! "\b<cword>\b" <CR>
nmap ˚        mo:Ack! "\b<cword>\b" <CR>
nmap <M-S-k>  mo:Ggrep! "\b<cword>\b" <CR>

" nvim-completion-manager
" tab is used to tab through options
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" }}}

" ==== Leader Mappings ============= {{{
" ==================================

let mapleader=","
let maplocalleader = '\\'

nnoremap <leader><space> :noh<cr>
nnoremap <leader><leader> :Files<CR>

"-- a --"
nmap <Leader>a :Ag<CR>
"-- b --"
"-- c --"
"-- d --"
vmap <leader>d "+d
"-- e --"
nmap <Leader>eo :lopen<CR>      " open location window
nmap <Leader>ec :lclose<CR>     " close location window
nmap <Leader>ee :ll<CR>         " go to current error/warning
nmap <Leader>en :lnext<CR>      " next error/warning
nmap <Leader>ep :lprev<CR>      " previous error/warning

"-- f --"
nnoremap <leader>ff :NERDTreeFind<CR>
nnoremap <leader>F :History<CR>
"-- g --"
nnoremap <leader>git :e ~/.gitconfig<cr>
nnoremap <leader>gs :Gstatus<cr>
nnoremap <leader>gq :Gcommit -av<cr>
nnoremap <leader>gw :Gwrite<cr>
nnoremap <leader>gcom :Gcommit -v<cr>
nnoremap <leader>gp :Gpush origin<cr>
"-- h --"
" Hex read
nmap <leader>hr :%!xxd<CR> :set filetype=xxd<CR>

" Hex write
nmap <leader>hw :%!xxd -r<CR> :set binary<CR> :set filetype=<CR>
"-- i --"
nmap <silent> <leader>i <Plug>IndentGuidesToggle
"-- j --"
"-- k --"
"-- l --"
nnoremap <leader>l :call NumberToggle()<cr>
"-- m --"
nnoremap <leader>md :!mkdir -p %:p:h<cr>
nnoremap <leader>mmd :!jscodeshift -t ~/Code/bucket/lattice/codemods/convert-recompose-to-react-class.js %:p<cr>
nnoremap <leader>mmu :!jscodeshift -t ~/Code/bucket/lattice/codemods/convert-to-compat-mutation.js %:p<cr>
"-- n --"
"-- o --"
"-- p --"
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P
"-- q --"
"-- r --"
nnoremap <leader>rvim :so $MYVIMRC<cr>
nnoremap <leader>rs :call RunCurrentSpecFile()<cr>
nnoremap <leader>rts :call RunNearestSpec()<cr>
"-- s --"
nnoremap <leader>S :%S/<C-r><C-w>/
vnoremap <leader>S y:%s/<C-r>"/
nnoremap <leader>snip :UltiSnipsEdit<cr>
"-- t --"
nnoremap <leader>tb :TagbarToggle<CR>
nnoremap <leader>tmux :e ~/.tmux.conf<cr>
"-- u --"
"-- v --"
" Edit vimrc file
nnoremap <leader>vim :e $MYVIMRC<CR>
"-- w --"
"-- x --"
"-- y --"
vmap <leader>y "+y
"-- z --"
nnoremap <leader>zsh :e ~/.zshrc<cr>

" }}}


" ==== Misc Plugin Configs ========= {{{
" ==================================

let g:LanguageClient_autoStart = 1
let g:LanguageClient_serverCommands = {
    \ 'reason': ['ocaml-language-server', '--stdio'],
    \ 'ocaml': ['ocaml-language-server', '--stdio'],
    \ }

" Python3
let g:python3_host_prog = '/usr/local/bin/python3'

" Gundo Settings
let g:gundo_right = 1

" ALE
let g:ale_sign_warning = '▲'
let g:ale_sign_error = '✗'
" NUKE FLOW TO OBLIVION. NEVER RUN FLOW. FLOW WILL CONSUME ALL YOUR RESOURCES
" AND BRING YOUR modern cutting edge hardware to a pathetic crawl. You will
" hard reboot daily. You will pull your hair out. You will hate life.
"
" UNLESS YOU DISABLE FLOW. DO THE RIGHT THING.
let g:ale_linters = {
  \   'javascript': ['eslint'],
  \   'jsx': ['eslint'],
  \   'javascript.jsx': ['eslint'],
\}
highlight link ALEWarningSign String
highlight link ALEErrorSign Title

" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
set rtp+=/usr/local/opt/fzf
set rtp+=~/.fzf

" Tell ack.vim to use ag (the Silver Searcher) instead
let g:ackprg = 'ag --vimgrep'

" vim-spec
let g:rspec_command = "compiler rspec | set makeprg=zeus | Make rspec {spec}"

" airline
let g:airline_theme='tomorrow'
let g:airline#extensions#tagbar#enabled = 0

" vim-jsx
let g:jsx_ext_required = 0 " Allow JSX in normal JS files

" editorconfig-vim
" Work with Fugitive
let g:EditorConfig_exclude_patterns = ['fugitive://.*']

" easymotion
let g:EasyMotion_do_mapping = 0 " Disable default mappings
" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" Easytags
set tags=./.tags,.tags;
let g:easytags_events = ['BufReadPost', 'BufWritePost']
let g:easytags_async = 1
let g:easytags_dynamic_files = 2
let g:easytags_resolve_links = 1

" Tagbar
let g:tagabar_show_linenumbers = -1
let g:tagbar_singleclick = 1
let g:tagbar_auto_open = 1

" Ultisnips
let g:UltiSnipsSnippetDirectories=[$HOME.'/.config/nvim/UltiSnips']

" NERDTree
let g:NERDTreeWinSize=60
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore = ['^\.tags$', '^\.DS_Store$', '^\.git$']

" Indent Guides
let g:indent_guides_guide_size = 1
let g:indent_guides_start_level = 2
let g:indent_guides_default_mapping = 0

" ==== Functions =============== {{{
" ==================================

"Switch between numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set number
  else
    set relativenumber
  endif
endfunc

"Find replace in a project
function! FindReplace(find, replace)
  call Ag(find)
  call Cdo
endfunc

" }}}

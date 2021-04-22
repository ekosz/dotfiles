" ==== Plugins =====================  {{{
" ==================================
filetype off                   " required!

" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" GLOBALS
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-obsession' " Vim session managment
Plug 'tpope/vim-fugitive' " Vim git plugin
Plug 'tpope/vim-abolish' " Better find/replace
" Plug 'w0rp/ale'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'sheerun/vim-polyglot' " Have vim understand all languges
Plug 'mileszs/ack.vim', { 'on': 'Ack' }
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'mhinz/vim-startify' " Fancy start screen
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()}}

" ReasonML
Plug 'rescript-lang/vim-rescript'

" Fountain
Plug 'kblin/vim-fountain'

" Tmux
Plug 'tmux-plugins/vim-tmux-focus-events' " Fix focus events in Tmux
Plug 'christoomey/vim-tmux-navigator' " Make moving into tmux panes easy
Plug 'edkolev/tmuxline.vim' " Generate Tmux from airline

" UI HELPERS
Plug 'bling/vim-airline'
" Plug 'airblade/vim-gitgutter'

" The best colors
Plug 'chriskempson/tomorrow-theme', { 'rtp': 'vim/' }
Plug 'vim-airline/vim-airline-themes'

" Initialize plugin system
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
" set cursorline " Show line where cursor is
set ruler " Show current cursor position
set backspace=indent,eol,start " Backspace over everything in insert mode
set laststatus=2 " Always show the status line
set relativenumber " Use relative line numbers
set number " Show current line number
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
set nowritebackup " Don't make backups " Don't make backups
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
set ttyfast " Make vim fast?
set cmdheight=2 " Give more space for displaying messages.
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300
set shortmess+=c " Don't pass messages to |ins-completion-menu|.
" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
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


  autocmd FileType php setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4
  autocmd BufNewFile,BufRead Gemfile set filetype=ruby
  autocmd BufNewFile,BufRead *.embl set filetype=emblem
  autocmd BufNewFile,BufRead *.hiccup set filetype=clojure
  autocmd BufNewFile,BufReadPost *.md set filetype=markdown
  autocmd BufRead,BufNewFile .{babel,eslint,stylelint,jshint}*rc,\.tern-*,*.json set ft=json
  autocmd BufNewFile,BufRead .tags set ft=tags

  autocmd BufWritePre *.{js,jsx,ts,tsx} :Prettier
  autocmd BufWritePre *.res,*.resi :RescriptFormat

  "Spelling
  autocmd BufRead,BufNewFile *.md setlocal spell
  autocmd FileType gitcommit setlocal spell
augroup END

command! -nargs=0 Prettier :CocCommand prettier.formatFile

" ==== Mappings ==================== {{{
" ==================================

"NERDTree
map <F2> :NERDTreeToggle<CR>

" `noremap` means to make a nonrecursive mapping
" that means that vim will not take other mapping
" into account when doing your new map

" Disable useless and annoying keys
noremap Q <Nop>

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

" Move highlited code up and down
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Search for the word under the cursor in the current directory
nmap <M-k>    mo:Ack! "\b<cword>\b" <CR>
nmap ˚        mo:Ack! "\b<cword>\b" <CR>
nmap <M-S-k>  mo:Ggrep! "\b<cword>\b" <CR>

" COC Mappings
" https://github.com/neoclide/coc.nvim#example-vim-configuration
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" gd - go to definition of word under cursor
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)

" gi - go to implementation
nmap <silent> gi <Plug>(coc-implementation)

" gr - find references
nmap <silent> gr <Plug>(coc-references)

" K - get hint on whatever's under the cursor
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

nmap <silent> [q <Plug>(coc-diagnostic-prev)
nmap <silent> ]q <Plug>(coc-diagnostic-next)

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

com! FormatXML :%!python3 -c "import xml.dom.minidom, sys; print(xml.dom.minidom.parse(sys.stdin).toprettyxml())"

" }}}

" ==== Leader Mappings ============= {{{
" ==================================

let mapleader=","
let maplocalleader = '\\'

nnoremap <leader><space> :noh<cr>
nnoremap <leader><leader> :Files<CR>

"-- a --"
nmap <Leader>a :Ack! --ignore-dir="__generated__" --ignore-dir="node_modules" --ignore-dir="relay-artifacts" --ignore-dir="meepo-types" --ignore-dir="patches" --ignore-dir="build"
"-- b --"
"-- c --"
nnoremap <silent> <leader>co  :<C-u>CocList outline<cr>
nnoremap <silent> <leader>cs  :<C-u>CocList -I symbols<cr>

" list commands available (and others)
nnoremap <silent> <leader>cc  :<C-u>CocList commands<cr>

" restart when thigs gets wonky
nnoremap <silent> <leader>cR  :<C-u>CocRestart<CR>

" View all errors
nnoremap <silent> <leader>cl  :<C-u>CocList locationlist<CR>

" manage extensions
nnoremap <silent> <leader>cx  :<C-u>CocList extensions<cr>

" show actions for selcted code
nnoremap <leader>ca <Plug>(coc-codeaction-selected)
vnoremap <leader>ca <Plug>(coc-codeaction-selected)

" show fix
nnoremap <silent> <leader>cf  :<C-u>CocFix<cr>

" rename the current word in the cursor
nmap <leader>cr  <Plug>(coc-rename)

" format selected
vmap <leader>cf  <Plug>(coc-format-selected)
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
nnoremap <leader>mmr :!jscodeshift -t ~/Code/lattice/codemods/convert-recompse-to-hooks.js %:p<cr>
nnoremap <leader>mmc :!jscodeshift -t ~/Code/lattice/codemods/convert-react-class-to-function.js %:p<cr>
nnoremap <leader>mmu :!jscodeshift -t ~/Code/lattice/codemods/convert-to-compat-mutation.js %:p<cr>
"-- n --"
"-- o --"
"-- p --"
nmap <leader>p "+p
nmap <leader>P "+P
vmap <leader>p "+p
vmap <leader>P "+P
"-- q --"
"-- r --"
" Reload vimrc file
nnoremap <leader>rvim :so $MYVIMRC<CR>
"-- s --"
nnoremap <leader>S :%S/<C-r><C-w>/
vnoremap <leader>S y:%s/<C-r>"/
"-- t --"
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
nnoremap <leader>tb :TagbarToggle<CR>

" ==== Misc Plugin Configs ========= {{{
" ==================================
" ALE
" let g:ale_sign_warning = '▲'
" let g:ale_sign_error = '✗'
" " NUKE FLOW TO OBLIVION. NEVER RUN FLOW. FLOW WILL CONSUME ALL YOUR RESOURCES
" " AND BRING YOUR modern cutting edge hardware to a pathetic crawl. You will
" " hard reboot daily. You will pull your hair out. You will hate life.
" "
" " UNLESS YOU DISABLE FLOW. DO THE RIGHT THING.
" let g:ale_linters = {
"   \   'javascript': ['eslint', 'stylelint'],
"   \   'jsx': ['eslint'],
"   \   'javascript.jsx': ['eslint', 'stylelint'],
"   \   'terraform': ['tflint'],
" \}
" let g:ale_fixers = {
"   \   'javascript': ['prettier'],
"   \   'jsx': ['eslint', 'prettier'],
"   \   'javascript.jsx': ['prettier'],
" \}
" let g:ale_fix_on_save = 1
" highlight link ALEWarningSign String
" highlight link ALEErrorSign Title

" FZF (replaces Ctrl-P, FuzzyFinder and Command-T)
" set rtp+=/usr/local/opt/fzf
" set rtp+=~/.fzf
let g:fzf_buffers_jump = 1

" Tell ack.vim to use ag (the Silver Searcher) instead
let g:ackprg = 'ag --vimgrep'

" Set where rescript lang server is at
let g:rescript_type_hint_bin = "~/Code/reason-language-server/bin.exe"

" startify
let g:startify_change_to_dir = 0
let g:startify_change_to_vcs_root = 1

" airline
let g:airline_theme='tomorrow'
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#tmuxline#enabled = 1
let airline#extensions#tmuxline#snapshot_file = "~/.vim/tmux-status.conf"
" let g:airline#extensions#ale#enabled = 1

" NERDTree
let g:NERDTreeWinSize=60
let g:NERDTreeShowHidden=1
let g:NERDTreeIgnore = ['^\.tags$', '^\.DS_Store$', '^\.git$']

" }}}

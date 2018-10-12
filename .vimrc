set nocompatible
filetype off
behave xterm

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Set the runtime path to include Vundle and initialize.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required.
Plugin 'gmarik/Vundle.vim'

" Solarized colors.
" Plugin 'altercation/vim-colors-solarized'

" Project helpers.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allows to have a set of templates for new file creation. (E.g. C header
" guards, shell script copyrights)
Plugin 'aperezdc/vim-template'
" Simple window with all open buffers.
Plugin 'fholgado/minibufexpl.vim'
" Fuzzy finder.
Plugin 'junegunn/fzf'
" The ripgrep
Plugin 'jremmen/vim-ripgrep'
" Git wrapper.
Plugin 'tpope/vim-fugitive'
" gitk for Vim.
Plugin 'junegunn/gv.vim'
" Vim scripts for vim-session.
Plugin 'xolox/vim-misc'
" Session management.
Plugin 'xolox/vim-session'
" Finder in a separate window with ag.
Plugin 'dyng/ctrlsf.vim'
" Multiple cursors.
Plugin 'terryma/vim-multiple-cursors'

" C/C++ helpers.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Very usefull completer.
Plugin 'Valloric/YouCompleteMe'
" Generates config files for YouCompleteMe.
Plugin 'rdnetto/YCM-Generator'
" Light status bar.
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Easy switch between source and header files.
Plugin 'derekwyatt/vim-fswitch'
" Simple add implementation in cpp files based on content of the header file.
Plugin 'derekwyatt/vim-protodef'
" Browse the tags of the current file. (E.g. variables, functions, etc.)
Plugin 'majutsushi/tagbar'
" Syntax checker.
Plugin 'scrooloose/syntastic'
" Additional Vim syntax highlighting for C++ (including C++11/14).
Plugin 'octol/vim-cpp-enhanced-highlight'
" Debug with gdb in split terminal window.
Plugin 'vim-scripts/Conque-GDB'
" Subvert command + case-correction by crs/crm/crc/cru.
Plugin 'tpope/vim-abolish'
" CMake projects.
Plugin 'vhdirk/vim-cmake'

Plugin 'bumaociyuan/vim-swift'

" Other.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text filtering and alignment.
Plugin 'godlygeek/tabular'
" Vim motions on speed.
Plugin 'easymotion/vim-easymotion'
" Markdown vim mode.
Plugin 'tpope/vim-markdown'
" Simple quoting/parenthesizing.
Plugin 'tpope/vim-surround'
" Marks with git changes.
Plugin 'airblade/vim-gitgutter'
" Doxygen commentaries generator.
Plugin 'vim-scripts/DoxygenToolkit.vim'
" CSV table view.
Plugin 'chrisbra/csv.vim'
" Plugin to toggle, display and navigate marks.
Plugin 'kshenoy/vim-signature'
" View vim registers.
Plugin 'junegunn/vim-peekaboo'
" Change buffer state without removing of windows layout.
Plugin 'vim-scripts/bufkill.vim'
" Enhanced terminal integration.
Plugin 'wincent/terminus'

" All of your Plugins must be added before the following line.
call vundle#end()            " required
filetype plugin indent on    " required

" Some YouCompleteMe settings.
let g:ycm_error_symbol = '!!'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist = ['~/*']

" Some vim-session settings.
let g:session_autosave = 'yes'
let g:session_autoload = 'no'
let g:session_autosave_periodic = 5

" Some MBE settings.
let g:miniBufExplorerAutoStart = 0

" Template settings.
let g:email='real93@live.ru'
let g:username='Korepanov Vyacheslav'


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Environment settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 1 || has("gui_running")
  syntax on
  set hlsearch
endif

colorscheme Tomorrow-Night-Eighties
set background=dark

" Setup keymap and alternative input language.
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
set cinoptions=N-s
highlight lCursor guifg=NONE guibg=Cyan

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

if has("autocmd")
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " Show Vim how to read doc-files.
  autocmd BufReadPre *.doc,*.DOC set ro
  autocmd BufReadPost *.doc,*.DOC silent %!antiword -m cp1251.txt "%"

  " Auto source vimrc after write to it.
  autocmd! BufWritePost $MYVIMRC source $MYVIMRC

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  autocmd BufRead,BufNewFile *.h,*.cpp,*.hpp set number filetype=cpp.doxygen

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END
endif " has("autocmd")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = ','

" Open new tab by Ctrl+T, close by Ctrl+W after leader key.
nmap <leader><C-t> :tabnew<CR>
nmap <leader><C-w> :tabclose<CR>

nmap <C-p> :FZF<CR>

" Copy&paste to primary buffer.
nnoremap <leader>y "+y
nnoremap <leader>Y "+Y
nnoremap <leader>p "+p

" Paste an empty line down or up to the line with cursor.
nmap <leader>o o<esc>
nmap <leader>O O<esc>

" In command mode use Ctrl+V to paste from the primary buffer.
cmap <C-V> <C-R>+
cmap <S-Insert> <C-R>+

" Use F2 key as in QtCreator. (Jumps to the declaration of the symbol)
map <F2> :YcmCompleter GoToDefinitionElseDeclaration<CR>

" Switch highlight.
map <F3> :set hls!<cr>

" Use F4 key as in QtCreator. (Toggle header and cpp files)
map <F4> :write<CR>:FSHere<CR>

" Some plugins shortcuts.
nmap <leader>bf :MBEOpen<CR>:MBEFocus<CR>
nmap <C-F> :CtrlSF <C-r><C-w>

" Disable some keys.
imap <silent> <up>       <nop>
imap <silent> <down>     <nop>
imap <silent> <left>     <nop>
imap <silent> <right>    <nop>
imap <silent> <home>     <nop>
imap <silent> <end>      <nop>
imap <silent> <pageup>   <nop>
imap <silent> <pagedown> <nop>
imap <silent> <c-home>   <nop>
imap <silent> <c-end>    <nop>
imap <silent> <del>      <nop>
nmap <silent> <up>       <nop>
nmap <silent> <down>     <nop>
nmap <silent> <left>     <nop>
nmap <silent> <right>    <nop>
nmap <silent> <home>     <nop>
nmap <silent> <end>      <nop>
nmap <silent> <pageup>   <nop>
nmap <silent> <pagedown> <nop>
nmap <silent> <c-home>   <nop>
nmap <silent> <c-end>    <nop>
nmap <silent> <del>      <nop>
vmap <silent> <up>       <nop>
vmap <silent> <down>     <nop>
vmap <silent> <left>     <nop>
vmap <silent> <right>    <nop>
vmap <silent> <home>     <nop>
vmap <silent> <end>      <nop>
vmap <silent> <pageup>   <nop>
vmap <silent> <pagedown> <nop>
vmap <silent> <c-home>   <nop>
vmap <silent> <c-end>    <nop>
vmap <silent> <del>      <nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Options
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set autoindent          " auto set the indent of a new line
set autoread
set backspace=2         " indent, eol, start
if has('unnamedplus')
    set clipboard=unnamedplus   " copy all to clipboard
else
    set clipboard=unnamed   " copy all to clipboard
endif
set cmdheight=2         " height of command line
set copyindent          " make 'autoindent' use existing indent structure
set cursorline          " highlight the screen line of the cursor
set directory=~/.vim/swap
set fileencoding=utf-8  " encoding for a local file
set fileencodings=utf8,koi8r,cp1251,cp866,ucs-2le   " список предполагаемых кодировок, в порядке предпочтения
set fileformat=unix     " eol format
set fileformats=unix,dos
set foldcolumn=2        " width of the column with folds
set history=50          " keep 50 lines of command line history
set ignorecase          " ignore case when using a search pattern
set infercase           " adjust case of match for keyword completion
set incsearch           " do incremental searching
set expandtab           " expand <Tab> to spaces in Insert mode
set fileencoding=utf-8  " encoding for a local file
set fileencodings=utf8,koi8r,cp1251,cp866,ucs-2le   " список предполагаемых кодировок, в порядке предпочтения
set fileformat=unix     " eol format
set fileformats=unix,dos
set foldcolumn=2        " width of the column with folds
set hidden
set history=50          " keep 50 lines of command line history
set ignorecase          " ignore case when using a search pattern
set infercase           " adjust case of match for keyword completion
set incsearch           " do incremental searching
set linebreak
set laststatus=2        " always show window statusline
set list                " show tabs, trail spaces and other symbols
set listchars=tab:>·,trail:-,extends:},precedes:{,nbsp:%
set matchpairs=(:),{:},[:],<:>,"/*":"*/"    " pairs that match for `%`
set maxmem=4096         " max amount of memory in Kb used for one buffer
set maxmemtot=65536     " max amount of memory in Kb used for all buffers
set number              " numbers at the left side
set relativenumber      " relative numbers
set ruler               " show the cursor position all the time
set scrolloff=4
set selectmode=         " disable Select mode by mouse and keyboard
set sessionoptions+=unix,slash
set shiftround          " round to 'shiftwidth' for '<<' and '>>'
set shiftwidth=4        " number of spaces used for each step of (auto)indent
set showbreak=~::       " string to put before wrapped screen lines
set showcmd             " display incomplete commands
set showfulltag         " show full tag pattern when completing tag
set showmatch           " when inserting a bracket, briefly jump to its match
set showmode            " display the current mode in the status line
set smartcase           " override 'ignorecase' when pattern has upper case characters
set smartindent         " do clever autoindenting
set smarttab            " a <Tab> in an indent inserts 'shiftwidth' spaces
set softtabstop=4       " number of spaces to insert for a <Tab>
set spelllang=en_us,ru_yo
set tabstop=8           " number of spaces a <Tab> in the text stands for
set undofile
set undodir=~/.vim/undo
set undolevels=10000    " maximum number of changes that can be undone
set visualbell          " disable beeping
set wildignorecase      " ignore case when completing file names
set wildmenu            " command-line completion shows a list of matches

set wildignore+=*/tmp/*,*.so,*.swp,*.zip,moc_*.cpp,*.moc,*.o,qrc_*.cpp,*.pro.user*

set colorcolumn=80
highlight ColorColumn ctermbg=darkgray


set secure
set exrc


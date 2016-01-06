if &term =~ '256color'
    " disable Background Color Erase (BCE) so that color schemes
    " render properly when inside 256-color tmux and GNU screen.
    " see also http://sunaku.github.io/vim-256color-bce.html
    set t_ut=
endif

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


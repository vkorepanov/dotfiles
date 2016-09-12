" Set the runtime path to include Vundle and initialize.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required.
Plugin 'gmarik/Vundle.vim'

" Solarized colors.
Plugin 'altercation/vim-colors-solarized'

" Project helpers.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allows to have a set of templates for new file creation. (E.g. C header
" guards, shell script copyrights)
Plugin 'aperezdc/vim-template'
" Simple window with all open buffers.
Plugin 'fholgado/minibufexpl.vim'
" Fuzzy finder binded to Ctrl+P.
Plugin 'kien/ctrlp.vim'
" The silver searcher.
Plugin 'rking/ag.vim'
" Git wrapper.
Plugin 'tpope/vim-fugitive'
" gitk for Vim.
Plugin 'gregsexton/gitv'
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
" Auto pairs.
Plugin 'jiangmiao/auto-pairs'
" Marks with git changes.
Plugin 'airblade/vim-gitgutter'
" Doxygen commentaries generator.
Plugin 'vim-scripts/DoxygenToolkit.vim'
" CSV table view.
Plugin 'chrisbra/csv.vim'

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

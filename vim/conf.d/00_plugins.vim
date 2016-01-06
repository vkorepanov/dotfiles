" Set the runtime path to include Vundle and initialize.
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage Vundle, required.
Plugin 'gmarik/Vundle.vim'

" Project helpers.

" Allows to have a set of templates for new file creation. (E.g. C header
" guards, shell script copyrights)
Plugin 'aperezdc/vim-template'
" Simple window with all open buffers.
Plugin 'fholgado/minibufexpl.vim'
" Fuzzy finder binded to Ctrl+P.
Plugin 'kien/ctrlp.vim'
" The silver searcher.
Plugin 'rking/ag.vim'
" Filesystem explorer.
Plugin 'scrooloose/nerdtree'
" Git wrapper.
Plugin 'tpope/vim-fugitive'
" Vim scripts for vim-session.
Plugin 'xolox/vim-misc'
" Session management.
Plugin 'xolox/vim-session'
" Unused plugins.
"Plugin 'SirVer/ultisnips'
"Plugin 'benmills/vimux'

" C/C++ helpers.

" Very usefull completer.
Plugin 'Valloric/YouCompleteMe'
" Light status bar.
Plugin 'bling/vim-airline'
" Easy switch between source and header files.
Plugin 'derekwyatt/vim-fswitch'
" Simple add implementation in cpp files based on content of the header file.
Plugin 'derekwyatt/vim-protodef'
" Browse the tags of the current file. (E.g. variables, functions, etc.)
Plugin 'majutsushi/tagbar'
" Syntax checker.
Plugin 'scrooloose/syntastic'
" Unused.
"Plugin 'vim-scripts/c.vim'

" All of your Plugins must be added before the following line.
call vundle#end()            " required
filetype plugin indent on    " required

" Some YouCompleteMe settings.
let g:ycm_error_symbol = '!!'
let g:ycm_global_ycm_extra_conf = '~/.vim/.ycm_extra_conf.py'
let g:ycm_extra_conf_globlist = ['~/*']

" Some vim-session settings.
let g:session_autosave = 'yes'
let g:session_autoload = 'yes'
let g:session_autosave_periodic = 5

" Some NERDTree settings.
let g:NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1

" Some MBE settings.
let g:miniBufExplorerAutoStart = 0

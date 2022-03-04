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
Plugin 'VundleVim/Vundle.vim'

" Solarized colors.
" Plugin 'altercation/vim-colors-solarized'

" Project helpers.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Allows to have a set of templates for new file creation. (E.g. C header
" guards, shell script copyrights)
Plugin 'aperezdc/vim-template'
" Fuzzy finder.
Plugin 'junegunn/fzf'
" The ripgrep
Plugin 'jremmen/vim-ripgrep'
" gitk for Vim.
Plugin 'junegunn/gv.vim'
" Finder in a separate window with ag.
Plugin 'dyng/ctrlsf.vim'
" Multiple cursors.
Plugin 'terryma/vim-multiple-cursors'
Plugin 'Chiel92/vim-autoformat'

" Plugin 'w0rp/ale'

" C/C++ helpers.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Intellisense engine for Vim8 & Neovim, full language server protocol support
Plugin 'neoclide/coc.nvim'
" Light status bar.
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
" Easy switch between source and header files.
Plugin 'derekwyatt/vim-fswitch'
" Additional Vim syntax highlighting for C++ (including C++11/14).
Plugin 'octol/vim-cpp-enhanced-highlight'
" Subvert command + case-correction by crs/crm/crc/cru.
Plugin 'tpope/vim-abolish'
" CMake projects.
Plugin 'vhdirk/vim-cmake'
if has('nvim')
    Plugin 'sakhnik/nvim-gdb'
endif

Plugin 'jackguo380/vim-lsp-cxx-highlight'

" Web
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Pug autocomplete.
Plugin 'dNitro/vim-pug-complete'
Plugin 'digitaltoad/vim-pug'

Plugin 'vim-ruby/vim-ruby'

" Rust
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
Plugin 'rust-lang/rust.vim'

" Other.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Text filtering and alignment.
Plugin 'godlygeek/tabular'
" Markdown vim mode.
Plugin 'tpope/vim-markdown'
" Simple quoting/parenthesizing.
Plugin 'tpope/vim-surround'
" Git
Plugin 'tpope/vim-fugitive'
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
" Asynchronous build and test dispatcher
Plugin 'tpope/vim-dispatch'
Plugin 'ryanoasis/vim-devicons'
" A multi-language debugging system for Vim
Plugin 'puremourning/vimspector'
if has('nvim')
    Plugin 'radenling/vim-dispatch-neovim'
endif

if has('mac')
    let g:python_host_prog = '/System/Library/Frameworks/Python.framework/Versions/2.7/bin/python'
    Plugin 'gfontenot/vim-xcode'
endif

" All of your Plugins must be added before the following line.
call vundle#end()            " required
filetype plugin indent on    " required

let g:ale_linters_explicit = 1
let g:ale_linter_aliases = {'html': ['html', 'javascript', 'css']}
let g:ale_linters = {
            \ 'javascript': ['eslint'],
            \ 'typescript': ['tslint', 'eslint'],
            \ 'html': ['tidy'],
            \ 'pug': ['puglint'],
            \ 'sass': ['stylelint'],
            \ 'css': ['stylelint'],
            \ 'sh': ['shellcheck'],
            \ 'haskell': ['hfmt', 'hlint', 'ghc', 'stack-ghc'],
            \}

" Template settings.
let g:email=system('git config user.email')
let g:username=system('git config user.name')

" Fzf settings.
let g:fzf_history_dir = '~/.local/share/fzf-history'

" Chromatica
if has('mac')
    let g:chromatica#libclang_path='/usr/local/opt/llvm/lib'
else
    let g:chromatica#libclang_path='/usr/lib/llvm/10/lib64'
endif
let g:chromatica#enable_at_startup=1

" nvimgdb
if has('nvim')
    let g:nvimgdb_config_override = { 'key_until':      '<f6>' }
endif

let g:vimspector_install_gadgets = [ 'debugpy', 'vscode-cpptools', 'CodeLLDB' ]

let g:rustfmt_autosave = 1

" jackguo380/vim-lsp-cxx-highlight
if (has("nvim"))
    let g:lsp_cxx_hl_use_nvim_text_props = 1
else
    let g:lsp_cxx_hl_use_text_props = 1
endif

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

colorscheme Tomorrow-Night
set background=dark

set iminsert=0
set imsearch=0
set cinoptions=N-sg0

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Autocommands
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')


if has("autocmd")
  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  autocmd FileType vue command! -nargs=0 Format :normal :CocCommand prettier.formatFile<CR>

  " Show Vim how to read doc-files.
  autocmd BufReadPre *.doc,*.DOC set ro
  autocmd BufReadPost *.doc,*.DOC silent %!antiword -m cp1251.txt "%"

  " Auto source vimrc after write to it.
  autocmd! BufWritePost $MYVIMRC source $MYVIMRC

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " autocmd BufRead,BufNewFile *.h,*.cpp,*.hpp set number filetype=cpp.doxygen

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  autocmd CursorHold * silent call CocActionAsync('highlight')

  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')

  augroup END
endif " has("autocmd")

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has('nvim')
    tnoremap <Esc> <C-\><C-n>
    tnoremap <C-v><Esc> <Esc>
endif

nmap <C-w>Z :cclose<CR>

let mapleader = ','

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Alt+Enter for actions
nmap <A-cr> :CocAction<CR>

" use <c-space>for trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

command! -nargs=0 Format :call CocActionAsync('format')
" command! -nargs=0 Format :normal :CocCommand prettier.formatFile<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

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
nmap <silent> <F2> <Plug>(coc-definition)

" Switch highlight.
map <F3> :set hls!<cr>

" Use F4 key as in QtCreator. (Toggle header and cpp files)
" map <F4> :write!<CR>:FSHere<CR>
nmap <silent> <F4> :CocCommand clangd.switchSourceHeader<CR>

" Some plugins shortcuts.
nmap <C-F> :CtrlSF <C-r><C-w>
nmap <leader>af :Format<CR>

" Vimspector
nmap <F6> <Plug>VimspectorContinue
nmap <F5> <Plug>VimspectorPause
nmap <F8> <Plug>VimspectorToggleBreakpoint
nmap <F10> <Plug>VimspectorStepOver
nmap <F11> <Plug>VimspectorStepInto
nmap <S-F11> <Plug>VimspectorStepOut

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

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif

if !has('nvim')
    set maxmem=4096         " max amount of memory in Kb used for one buffer
    set maxmemtot=65536     " max amount of memory in Kb used for all buffers
else
    set termguicolors       " 24-bit colors in the TUI
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
set expandtab           " expand <Tab> to spaces in Insert mode
set fileencoding=utf-8  " encoding for a local file
set fileencodings=utf8,koi8r,cp1251,cp866,ucs-2le   " список предполагаемых кодировок, в порядке предпочтения
set fileformat=unix     " eol format
set fileformats=unix,dos
set foldcolumn=2        " width of the column with folds
set hidden
set history=5000        " keep 5000 lines of command line history
set ignorecase          " ignore case when using a search pattern
set incsearch           " do incremental searching
set infercase           " adjust case of match for keyword completion
set laststatus=2        " always show window statusline
set linebreak
set list                " show tabs, trail spaces and other symbols
set listchars=tab:>·,trail:-,extends:},precedes:{,nbsp:%
set matchpairs=(:),{:},[:],<:>,"/*":"*/"    " pairs that match for `%`
set nobackup
set nowritebackup
set number              " numbers at the left side
set relativenumber      " relative numbers
set ruler               " show the cursor position all the time
set scrolloff=4
set selectmode=         " disable Select mode by mouse and keyboard
set sessionoptions+=unix,slash
set shiftround          " round to 'shiftwidth' for '<<' and '>>'
set shiftwidth=4        " number of spaces used for each step of (auto)indent
set shortmess+=c        " Don't pass messages to |ins-completion-menu|
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
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
set tabstop=8           " number of spaces a <Tab> in the text stands for
set undodir=~/.vim/undo
set undofile
set undolevels=10000    " maximum number of changes that can be undone
set updatetime=300
set visualbell          " disable beeping
set wildignorecase      " ignore case when completing file names
set wildmenu            " command-line completion shows a list of matches
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,moc_*.cpp,*.moc,*.o,qrc_*.cpp,*.pro.user*

set colorcolumn=80
highlight ColorColumn ctermbg=darkgray


set secure
set exrc


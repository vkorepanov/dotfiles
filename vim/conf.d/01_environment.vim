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
highlight lCursor guifg=NONE guibg=Cyan


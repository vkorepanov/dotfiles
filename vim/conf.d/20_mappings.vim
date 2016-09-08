let mapleader = ','

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

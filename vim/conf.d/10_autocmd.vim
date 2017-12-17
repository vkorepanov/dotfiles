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

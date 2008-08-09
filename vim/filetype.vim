augroup filetypedetect
  autocmd BufNewFile,BufRead *.txt     setf txt
augroup END

augroup aes256
  autocmd!

  autocmd BufReadPre *.aes       set viminfo=
  autocmd BufReadPre *.aes       set noswapfile
  autocmd BufReadPre *.aes       set readonly

  autocmd BufReadPost *.aes      let $vimpass = inputsecret("Password: ")
  autocmd BufReadPost *.aes      silent '[,']!openssl enc -d -aes-256-cbc -a -salt -pass pass:$vimpass

  autocmd BufWritePre *.aes      silent '[,']!openssl enc -e -aes-256-cbc -a -salt -pass pass:$vimpass

  autocmd BufWritePost *.aes     u
augroup END

augroup sh
  autocmd!

  autocmd BufNewFile *.sh silent 0read ~/.vim/skel/sh
augroup END

augroup ruby
  autocmd!

  autocmd BufNewFile *.rb silent 0read ~/.vim/skel/ruby
augroup END

" CURSOR ASSUMES PREVIOUS POSITION
autocmd BufReadPost * if line("'\"") > 0             |
\                       if line("'\"") <= line("$")  |
\                         exe("norm '\"")            |
\                       else                         |
\                         exe "norm $"               |
\                       endif                        |
\                     endif

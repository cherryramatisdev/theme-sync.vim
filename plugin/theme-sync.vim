if exists("g:loaded_theme_sync")
  finish
endif
let g:loaded_theme_sync = 1

augroup ThemeSyncOS
  autocmd! 
  autocmd VimEnter * call theme#StartTimer(0)
  autocmd BufRead * call theme#StartTimer(0)
augroup END

call timer_start(1000, function('theme#StartTimer'), {'repeat': -1})

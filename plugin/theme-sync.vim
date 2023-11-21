if exists("g:loaded_theme_sync")
  finish
endif
let g:loaded_theme_sync = 1

augroup ThemeSyncOS
  autocmd! 
  autocmd VimEnter * call theme#SwitchTheme(0)
  autocmd BufRead * call theme#SwitchTheme(0)
augroup END

call timer_start(1000, function('theme#SwitchTheme'), {'repeat': -1})

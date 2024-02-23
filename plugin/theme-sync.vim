if exists("g:loaded_theme_sync")
  finish
endif
let g:loaded_theme_sync = 1

augroup ThemeSyncOS
  autocmd! 
  autocmd VimEnter * call theme#DecideTheme(0)
  autocmd BufRead * call theme#DecideTheme(0)
augroup END

let g:theme_sync_disable_timer = 0

if g:theme_sync_disable_timer == 1
  call timer_start(1000, function('theme#DecideTheme'), {'repeat': -1})
endif

if exists("g:loaded_theme_sync")
  finish
endif
let g:loaded_theme_sync = 1

augroup ThemeSyncOS
  autocmd! 
  autocmd VimEnter * call theme#SwitchTheme()
  autocmd BufRead * call theme#SwitchTheme()
augroup END

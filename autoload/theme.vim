function! theme#CheckIsDark() abort
  let l:appearance = system("defaults read -g AppleInterfaceStyle")

  return l:appearance =~ "Dark"
endfunction

function! theme#SwitchTheme() abort
  if !exists('g:theme_sync_dark_colorscheme') || !exists('g:theme_sync_light_colorscheme')
    echoerr "Please setup the g:theme_sync_light_colorscheme and g:theme_sync_dark_colorscheme for allowing to theme sync"
    return
  endif

  if theme#CheckIsDark()
    set background=dark
    execute('colorscheme ' . g:theme_sync_dark_colorscheme)
  else
    set background=light
    execute('colorscheme ' . g:theme_sync_light_colorscheme)
  endif
endfunction

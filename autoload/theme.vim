function! s:CheckIsDark() abort
  let l:appearance = system('defaults read -g AppleInterfaceStyle')

  return l:appearance =~ 'Dark'
endfunction

" TODO: horrible function name
function! s:SetThemeIfNotSetted(mode, colorscheme) abort
  if (&background =~ 'dark' && a:mode =~ 'dark') || (&background =~ 'light' && a:mode =~ 'light')
    return
  endif

  execute('set background=' . a:mode)
  execute('colorscheme ' . a:colorscheme)
endfunction

function! theme#SwitchTheme(timer_id) abort
  if !exists('g:theme_sync_dark_colorscheme') || !exists('g:theme_sync_light_colorscheme')
    echoerr "Please setup the g:theme_sync_light_colorscheme and g:theme_sync_dark_colorscheme for allowing to theme sync"
    return
  endif

  if s:CheckIsDark()
    call s:SetThemeIfNotSetted('dark', g:theme_sync_dark_colorscheme)
  else
    call s:SetThemeIfNotSetted('light', g:theme_sync_light_colorscheme)
  endif
endfunction

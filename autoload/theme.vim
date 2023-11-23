" TODO: refactor this
function! theme#SwitchTheme(...) abort
  if exists('a:2')
    if (a:2 == 'Dark' && &background == 'dark' && exists('g:colors_name')) || (a:2 != 'Dark' && &background == 'light' && exists('g:colors_name'))
      return
    endif

    if a:2 == 'Dark'
      set background=dark
      call execute('colorscheme ' . g:theme_sync_dark_colorscheme)
    else
      set background=light
      call execute('colorscheme ' . g:theme_sync_light_colorscheme)
    endif
  endif 
endfunction

function! theme#StartTimer(timer_id) abort
  if !exists('g:theme_sync_dark_colorscheme') || !exists('g:theme_sync_light_colorscheme')
    echoerr "Please setup the g:theme_sync_light_colorscheme and g:theme_sync_dark_colorscheme for allowing to theme sync"
    return 
  endif

  call job_start(['defaults', 'read', '-g', 'AppleInterfaceStyle'], {
        \   'out_cb': 'theme#SwitchTheme',
        \   'err_cb': 'theme#SwitchTheme',
        \ })
endfunction

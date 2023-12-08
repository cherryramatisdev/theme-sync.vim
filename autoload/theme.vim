" TODO: refactor this
function! theme#SwitchTheme(...) abort
  if exists('a:2')
    if (a:2 =~ 'Dark\|dark' && &background == 'dark' && exists('g:colors_name')) || (a:2 =~# 'Dark\|dark' && &background == 'light' && exists('g:colors_name'))
      return
    endif

    if a:2 =~ 'Dark\|dark'
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


  if !exists('g:theme_sync_get_theme_cmd')
    let l:get_theme_cmd = ['defaults', 'read', '-g', 'AppleInterfaceStyle']
  else
    let l:get_theme_cmd = g:theme_sync_get_theme_cmd
  endif

  if has('nvim')
    lua require('theme_sync').switch_theme()
  else
    call job_start(l:get_theme_cmd, {
          \   'out_cb': 'theme#SwitchTheme',
          \   'err_cb': 'theme#SwitchTheme',
          \ })
  endif
endfunction

" TODO: refactor this
function! theme#SwitchTheme(...) abort
  if exists('a:2')
    if has('nvim')
      let l:target = a:2[0]
    else
      let l:target = a:2
    endif

    " if (l:target =~ 'Dark\|dark' && &background == 'dark' && exists('g:colors_name')) || (l:target =~# 'Dark\|dark' && &background == 'light' && exists('g:colors_name'))
    "   return
    " endif

    if l:target =~ 'Dark\|dark'
      set background=dark
      call execute('colorscheme ' . g:theme_sync_dark_colorscheme)
    else
      set background=light
      call execute('colorscheme ' . g:theme_sync_light_colorscheme)
    endif
  endif
endfunction

function! theme#DecideTheme(timer_id) abort
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
    call jobstart(l:get_theme_cmd, {
          \ 'on_stdout': 'theme#SwitchTheme',
          \ 'on_stderr': 'theme#SwitchTheme',
          \ })
  else
    call job_start(l:get_theme_cmd, {
          \   'out_cb': 'theme#SwitchTheme',
          \   'err_cb': 'theme#SwitchTheme',
          \ })
  endif
endfunction

function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  "Limelight
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!
endfunction

" Ensure :q to quit even when Goyo is active
function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    "Limelight!
    if b:quitting_bang
      qa!
    else
      qa
    endif
  else
    if b:quitting_bang
      bd!
    else
      bd
    endif
  endif
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()

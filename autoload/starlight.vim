
if !exists("g:starlight_no_history")
  let g:starlight_no_history = 0
endif


function! s:pattern_from_visual_selection() abort
    let [lnum_start, cnum_start] = getpos("'<")[1:2]
    let [lnum_end, cnum_end] = getpos("'>")[1:2]
    let col_start = cnum_start - 1
    let col_end = cnum_end - (&selection != 'exclusive' ? 1 : 2)
    let lines = getline(lnum_start, lnum_end)
    if len(lines) == 0
        return ''
    endif
    let lines[-1] = lines[-1][:col_end]
    let lines[0] = lines[0][col_start:]
    call map(lines, 'escape(v:val, "$*.[\\^~")')
    return join(lines, "\\n")
  endfunction


function! s:jump_to_result() abort
  if v:count > 0
    execute "normal" v:count . "n"
  endif
endfunction

function! s:search(pat)
  let @/ = a:pat
  if !g:starlight_no_history
    call histadd('search', a:pat)
  endif
endfunction

function! starlight#visual() abort
  if visualmode() == ''
    " not catching this prevents the mapping to execute `:hlsearch`
    throw "startlight does'nt support visual-block"
  endif
  let pat = <SID>pattern_from_visual_selection()
  call <SID>search(pat)
  call <SID>jump_to_result()
endfunction

function! starlight#exact_word()
  call <SID>search('\<'.expand('<cword>').'\>')
  call <SID>jump_to_result()
endfunction

function! starlight#word()
  call <SID>search(expand('<cword>'))
  call <SID>jump_to_result()
endfunction

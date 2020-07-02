if exists("g:starlight_loaded")
  finish
endif
let g:starlight_loaded = 1


let s:post_searchindex = exists(":SearchIndex") ? "<Plug>SearchIndex" : ""

nnoremap <silent> <script> <Plug>(starlight-*) :<C-U>call starlight#exact_word()<CR>:set hlsearch<CR>
xnoremap <silent> <script> <Plug>(starlight-visual-*) :<C-U>call starlight#visual()<CR>:set hlsearch<CR>
nnoremap <silent> <script> <Plug>(starlight-g*) :<C-U>call starlight#word()<CR>:set hlsearch<CR>


if !exists("g:starlight_no_mappings") || ! g:starlight_no_mappings
  execute "xmap <silent> *  <Plug>(starlight-visual-*)" . s:post_searchindex
  execute "nmap <silent> *  <Plug>(starlight-*)" . s:post_searchindex
  execute "nmap <silent> g* <Plug>(starlight-g*)" . s:post_searchindex
endif

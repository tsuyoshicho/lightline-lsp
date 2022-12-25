if exists('g:loaded_lightline_lsp')
  finish
endif
let g:loaded_lightline_lsp = 1

let s:save_cpo = &cpo
set cpo&vim

augroup lightline#lsp
  autocmd!
  autocmd User lsp_diagnostics_updated
    \ if exists('*lightline#update')
    \ |   call lightline#update()
    \ | endif
augroup END

let &cpo = s:save_cpo
unlet s:save_cpo

let s:indicator_errors       = get(g:, 'lightline#lsp#indicator_errors', 'E: ')
let s:indicator_warnings     = get(g:, 'lightline#lsp#indicator_warnings', 'W: ')
let s:indicator_informations = get(g:, 'lightline#lsp#indicator_warnings', 'I: ')
let s:indicator_hints        = get(g:, 'lightline#lsp#indicator_warnings', 'H: ')
let s:indicator_ok           = get(g:, 'lightline#lsp#indicator_ok', 'OK')
let s:indicator_checking     = get(g:, 'lightline#lsp#indicator_checking', 'Linting...')


""""""""""""""""""""""
" Lightline components

" diagnostics status
function! s:status_print(type, indicator) abort
  if !lightline#lsp#linted()
    return ''
  endif
  " { 'error': 1, 'warning': 0, 'information': 0, 'hint': 0 }
  let l:counts = lsp#get_buffer_diagnostics_counts()
  let l:count = l:counts[a:type]
  return l:count == 0 ? '' : printf(a:indicator . '%d', l:count)
endfunction

function! lightline#lsp#errors() abort
  return s:status_print('error', s:indicator_errors)
endfunction

function! lightline#lsp#warnings() abort
  return s:status_print('warning', s:indicator_warnings)
endfunction

function! lightline#lsp#infomations() abort
  return s:status_print('information', s:indicator_informations)
endfunction

function! lightline#lsp#hints() abort
  return s:status_print('hint', s:indicator_hints)
endfunction

function! lightline#lsp#ok() abort
  if !lightline#lsp#linted()
    return ''
  endif
  let l:counts = lsp#get_buffer_diagnostics_counts()
  let l:total_count = l:counts.error + l:counts.warning
  return l:total_count == 0 ? s:indicator_ok : ''
endfunction

function! lightline#lsp#checking() abort
  " currently lsp server status API nothing.
  return v:false ? s:indicator_checking : ''
endfunction

" server(whitelist first item) status
" use undocumented API
let s:server_status = {
          \ 'unknown server' : 'warning',
          \ 'exited'         : 'error',
          \ 'starting'       : 'warning',
          \ 'failed'         : 'error',
          \ 'running'        : 'ok',
          \ 'not running'    : 'warning',
          \ }

function! lightline#lsp#status_ok() abort
  return s:lsp_status('ok')
endfunction

function! lightline#lsp#status_warning() abort
  return s:lsp_status('warning')
endfunction

function! lightline#lsp#status_error() abort
  return s:lsp_status('error')
endfunction

function! s:lsp_status(type) abort
  let servers = lsp#get_allowed_servers()

  if empty(servers)
    return ''
  endif

  let now = localtime()
  let count = len(servers)
  let index = 0
  if count > 1
    let interval = get(g:, 'lightline#lsp#server_interval', 30)
    let index = ((now % (count * interval)) / interval) % count
  endif

  let server_name = servers[index]
  let status = lsp#get_server_status(server_name)

  if s:server_status[status] ==? a:type
    return server_name . ':' .  status
  endif
  return ''
endfunction

""""""""""""""""""
" Helper functions

function! lightline#lsp#linted() abort
  " currently vim-lsp enabled check API nothing.
  " currently lsp server status API nothing.
  return get(g:, 'lsp_diagnostics_enabled', 0)
endfunction

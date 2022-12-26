# lightline-lsp

This plugin provides [vim-lsp](https://github.com/prabirshrestha/vim-lsp) indicator for the [lightline.vim](https://github.com/itchyny/lightline.vim) statusline plugin.

Forked from [lightline-ale](https://github.com/maximbaz/lightline-ale).

## Table Of Contents

- [Current project status](#current-project-status)
- [Installation](#installation)
- [Integration](#integration)
- [Configuration](#configuration)
- [License](#license)

## Current project status

- [x] diagnostics count/status : work
- [x] server name/status       : work

## Installation

Install using a plugin manager of your choice, for example:

```viml
call dein#add('prabirshrestha/async.vim') " Dependency: vim-lsp async lib
call dein#add('vim-lsp')                  " Dependency: lsp client
call dein#add('itchyny/lightline.vim')    " Dependency: status line
call dein#add('tsuyoshicho/lightline-lsp')
```

## Integration

### 1. Register the components

```viml
" init
" let g:lightline = {}

" diagnostics
" already previous setting exists, you would be using expand() function to  dictionary expand.
let g:lightline.component_expand = {
      \  'lsp_diag_checking' : 'lightline#lsp#checking',
      \  'lsp_diag_error'    : 'lightline#lsp#error',
      \  'lsp_diag_warning'  : 'lightline#lsp#warning',
      \  'lsp_diag_info'     : 'lightline#lsp#information',
      \  'lsp_diag_error'    : 'lightline#lsp#hint',
      \  'lsp_diag_ok'       : 'lightline#lsp#ok',
      \}

" server
" same above.
let g:lightline.component_expand = {
      \  'lsp_status_error'     : 'lightline#lsp#status_error',
      \  'lsp_status_warning'   : 'lightline#lsp#status_warning',
      \  'lsp_status_ok'        : 'lightline#lsp#status_ok',
      \}

" count indicator
let g:lightline.component_function = {
      \   'lsp_count':    'lightline#lsp#count',
      \}
```

### 2. Set color to the components

```viml
" diagnostics
" already previous setting exists, you would be using expand() function to  dictionary expand.
let g:lightline.component_type = {
      \  'lsp_diag_checking' : 'left',
      \  'lsp_diag_warnings' : 'warning',
      \  'lsp_diag_errors'   : 'error',
      \  'lsp_diag_ok'       : 'left',
      \}

" server
" same above.
let g:lightline.component_type = {
      \  'lsp_status_error'   : 'error',
      \  'lsp_status_warning' : 'warning',
      \  'lsp_status_ok'      : 'ok',
      \}
```

### 3. Add the components to the lightline, for example to the right side

```viml
" diagnostics and server
" already previous setting exists, you would be using expand() function to  dictionary expand.
let g:lightline.active = { 'right': [
      \  ['lsp_status_error', 'lsp_status_warning', 'lsp_status_ok'],
      \  ['lsp_count'],
      \  ['lsp_diag_checking', 'lsp_diag_errors', 'lsp_diag_warnings', 'lsp_diag_ok'],
      \]}
```

## Configuration

### `g:lightline#lsp#indicator_checking`

The indicator to use when vim-lsp is in progress. Default is `Linting...`.

### `g:lightline#lsp#indicator_warnings`

The indicator to use when there are warnings. Default is `W:`.

### `g:lightline#lsp#indicator_errors`

The indicator to use when there are errors. Default is `E:`.

### `g:lightline#lsp#indicator_ok`

The indicator to use when there are no warnings or errors. Default is `OK`.

### `g:lightline#lsp#server_interval`

This interval as servers cycle status indicatation(sec).

### Using icons as indicators

If you would like to replace the default indicators with symbols like lightline-ale, then you'll need to ensure you have some "iconic fonts" installed, such as [Font Awesome](https://fontawesome.com). A common alternative is to replace your primary font with one of the [Patched Nerd Fonts](https://github.com/ryanoasis/nerd-fonts), which saves you from having to install multiple fonts.

The following icons from the Font Awesome font are used in the lightline-ale:

- Checking: [f110](https://fontawesome.com/icons/spinner)
- Warnings: [f071](https://fontawesome.com/icons/exclamation-triangle)
- Errors: [f05e](https://fontawesome.com/icons/ban)
- OK: [f00c](https://fontawesome.com/icons/check)

To specify icons in the configuration, use their unicode codes as `"\uXXXX"` (make sure to wrap them in double quotes). Alternatively copy the icons from a font website, or type <kbd>\<C-v\>u\<4-digit-unicode\></kbd> or <kbd>\<C-v\>U\<8-digit-unicode\></kbd> to insert the literal characters.

See the code points here:

- [Font Awesome](https://fontawesome.com/icons)
- [Nerd Fonts](https://github.com/ryanoasis/nerd-fonts#glyph-sets)

Here's the configuration snippet used in the lightline-lsp(same as lightline-ale):

```viml
let g:lightline#lsp#indicator_checking = "\uf110"
let g:lightline#lsp#indicator_warning = "\uf071"
let g:lightline#lsp#indicator_error = "\uf05e"
let g:lightline#lsp#indicator_information = "\uf05a"
let g:lightline#lsp#indicator_hint = "\uf0e5"
let g:lightline#lsp#indicator_ok = "\uf00c"
```

## Related Plugins

- [halkn/lightline-lsp](https://github.com/halkn/lightline-lsp) - lsp counts
- [micchy326/lightline-lsp-progress](https://github.com/micchy326/lightline-lsp-progress) - lsp progress status

## License

Released under the [MIT License](LICENSE).

Based lightline-ale released under the [MIT License](LICENSE-lightline-ale).

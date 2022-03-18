" vim-lspの各種オプション設定
let g:lsp_signs_enabled = 1
let g:lsp_diagnostics_enabled = 1
let g:lsp_diagnostics_echo_cursor = 1
let g:lsp_virtual_text_enabled = 1
let g:lsp_signs_error = {'text': '✗'}
let g:lsp_signs_warning = {'text': '‼'}
let g:lsp_signs_information = {'text': 'i'}
let g:lsp_signs_hint = {'text': '?'}

if (executable('pyls'))
    " pylsの起動定義
    augroup LspPython
        autocmd!
        autocmd User lsp_setup call lsp#register_server({
            \ 'name': 'pyls',
            \ 'cmd': { server_info -> ['pyls'] },
            \ 'whitelist': ['python'],
            \})
    augroup END
endif

" 定義情報のホバー表示
nnoremap K :<C-u>LspHover<CR>
" テキスト整形
nnoremap <LocalLeader>s :<C-u>LspDocumentFormat<CR>


augroup LspAutoFormatting
    autocmd!
    autocmd BufWritePre *.py LspDocumentFormatSync
augroup END

" pylsの設定。LinterのON/OFFなどが可能
let s:pyls_config = {'pyls': {'plugins': {
    \   'pycodestyle': {'enabled': v:true},
    \   'pydocstyle': {'enabled': v:false},
    \   'pylint': {'enabled': v:false},
    \   'flake8': {'enabled': v:true},
    \   'jedi_definition': {
    \     'follow_imports': v:true,
    \     'follow_builtin_imports': v:true,
    \   },
    \ }}}
" pylsの起動定義
augroup LspPython
    autocmd!
    autocmd User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': { server_info -> ['pyls'] },
        \ 'whitelist': ['python'],
        \ 'workspace_config': s:pyls_config
        \})
augroup END

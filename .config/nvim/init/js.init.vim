let g:used_javascript_libs = 'react'
let b:javascript_lib_use_react = 1

augroup javascript_folding
    au!
    au FileType javascript setlocal foldmethod=syntax
augroup END

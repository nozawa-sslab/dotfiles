" Disable default mappings
let g:nnn#set_default_mappings = 0

" Set custom mappings
nnoremap <silent> <leader>nn :NnnPicker<CR>

" Start n³ in the current file's directory
nnoremap <leader>n :NnnPicker %:p:h<CR>

local keyset = vim.keymap.set
local noremap_default = { noremap = true }

--- use space as mapleader
keyset('n', '<space>', '<nop>', noremap_default)
vim.g.mapleader = ' '

--- escape and :w
keyset('i', 'jj', '<esc>', noremap_default)
keyset('n', 'ff', ':w<cr>', noremap_default)

--- cd to the directory of current buffer
keyset('n', '<leader>cd', ':cd %:p:h<cr>:pwd<cr>', noremap_default)

--- use ctrl-[hjkl] to select the active pane
keyset('n', '<c-k>', ':wincmd k<cr>', noremap_default)
keyset('n', '<c-j>', ':wincmd j<cr>', noremap_default)
keyset('n', '<c-h>', ':wincmd h<cr>', noremap_default)
keyset('n', '<c-l>', ':wincmd l<cr>', noremap_default)

keyset('n', '<C-p>', ':bp<cr>', noremap_default)
keyset('n', '<C-n>', ':bn<cr>', noremap_default)

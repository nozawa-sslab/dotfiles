local keyset = vim.keymap.set
local noremap_default = { noremap = true }

-- use space as mapleader
keyset('n', '<space>', '<nop>', noremap_default)
vim.g.mapleader = ' '

-- escape and :w
keyset('i', 'jj', '<esc>', noremap_default)
keyset('n', 'ff', ':w<cr>', noremap_default)

-- cd to the directory of current buffer
keyset('n', '<leader>cd', ':cd %:p:h<cr>:pwd<cr>', noremap_default)

-- use ctrl-[hjkl] to select the active pane
keyset('n', '<c-k>', ':wincmd k<cr>', noremap_default)
keyset('n', '<c-j>', ':wincmd j<cr>', noremap_default)
keyset('n', '<c-h>', ':wincmd h<cr>', noremap_default)
keyset('n', '<c-l>', ':wincmd l<cr>', noremap_default)

keyset('n', '<C-p>', ':bp<cr>', noremap_default)
keyset('n', '<C-n>', ':bn<cr>', noremap_default)

-- toggleterm (more "lazy" set inside config)
keyset("n", "<c-t>", [[<Cmd>exe v:count1 . "ToggleTerm"<CR>]], noremap_default)
keyset("i", "<c-t>", [[<Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>]], noremap_default)
keyset("n", "<leader>g", "<cmd>lua open_gitui()<CR>", {noremap = true, silent = true})

-- fzf-lua
keyset('n', '<leader>ff', ':FzfLua files<cr>', noremap_default)
keyset('n', '<leader>rg', ':FzfLua grep_project<cr>', noremap_default)
keyset('n', '<leader>fzb', ':FzfLua buffers<cr>', noremap_default)
keyset('n', '<leader>fl', ':FzfLua lines<cr>', noremap_default)
keyset('n', '<leader>;', ':FzfLua commands<cr>', noremap_default)

-- lsps
-- keyset("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
-- keyset("n", "K",  "<cmd>Lspsaga hover_doc<CR>")
-- keyset('n', "gd", '<cmd>Lspsaga finder<CR>')
-- keyset("n", "ga", "<cmd>Lspsaga code_action<CR>")
-- keyset("n", "<leader>rn", "<cmd>Lspsaga rename<CR>")
-- keyset("n", "ge", "<cmd>Lspsaga show_line_diagnostics<CR>")
-- keyset("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>")
-- keyset("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
-- keyset("n", "<leader>a", "<cmd> Lspsaga outline<CR>")

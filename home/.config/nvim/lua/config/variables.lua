local options = {
    --- editing
    encoding = 'utf-8',
    fileencoding = 'utf-8',
    fileformats = 'unix,dos,mac',
    backspace = 'indent,eol,start',
    expandtab = true,
    shiftwidth = 2,
    softtabstop = 2,
    tabstop = 2,
    smartindent = true,
    autoindent = true,
    clipboard = 'unnamedplus',

    --- UI
    wildmenu = true,
---    wildchar = (''):byte(), -- <Ctrl-t> for cmd-mode completion
    rnu = true,
    nu = true,
    cursorline = true,
    laststatus = 2,
    showmatch = true,
    mouse = 'a',
    foldenable = false,

    --- search
    ignorecase = true,
    hlsearch = true,
    smartcase = true,

    --- persistent undo
    undodir = vim.fn.expand('$HOME/.vim/undo'),
    undofile = true,

    --- swap
    swapfile = false
}

local global_options = {
    noerrorbells = true,
}

local map_pairs = {
    {options, vim.opt},
    {global_options, vim.g}
}

vim.cmd("hi Search ctermbg=34")

for index, pair in ipairs(map_pairs) do
    local vim_map = pair[2]
    for k, v in pairs(pair[1]) do
      vim_map[k] = v
    end
end

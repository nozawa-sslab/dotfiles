return {
    'jiangmiao/auto-pairs',
    'tpope/vim-commentary',
    'preservim/tagbar',
    'airblade/vim-gitgutter',
    'tpope/vim-fugitive',
    'tpope/vim-obsession',
    {
        "junegunn/fzf",
        dependencies = { "junegunn/fzf.vim" },
        build = ":call fzf#install()",
        config = function()
            vim.g.fzf_action = { enter = 'tab split'}
            vim.g.fzf_preview_window = {'right:50%', 'ctrl-/'}
        end
    },
}

return {
    'jiangmiao/auto-pairs',
    'tpope/vim-commentary',
    'preservim/tagbar',
    'airblade/vim-gitgutter',
    'tpope/vim-fugitive',
    'tpope/vim-obsession',
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            -- calling `setup` is optional for customization
            require("fzf-lua").setup({ 'telescope' })
        end
    }
}

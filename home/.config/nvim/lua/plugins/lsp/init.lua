return {
    {
        'nvimdev/lspsaga.nvim',
        dependencies = {
          'nvim-treesitter/nvim-treesitter',
          'nvim-tree/nvim-web-devicons'
        },
        enabled = true,
        config = function()
            vim.api.nvim_create_autocmd("CursorHold", {
                command = "Lspsaga show_cursor_diagnostics ++unfocus",
            })
            vim.opt.updatetime = 300
            vim.diagnostic.config({
                virtual_text = false
            })
            require('lspsaga').setup({
                symbol_in_winbar = {
                    enable = false
                },
            })
        end,
    }
}

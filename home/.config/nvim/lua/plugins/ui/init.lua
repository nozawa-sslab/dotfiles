-- local lualine_theme = "lualine.themes.iceberg_dark"
-- Change the background of lualine_c section for normal mode
-- custom_gruvbox.normal.c.bg = '#112233'

return {
    {
        "cocopon/iceberg.vim",
---        enabled = false,
        config = function()
            vim.cmd("colorscheme iceberg")
        end
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        ---enabled = false,
        config = function()
            require('lualine').setup {
               options = { theme = 'material' }
            }
        end
    },
    {
        'romgrk/barbar.nvim',
        dependencies = {
          'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
          'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
        },
        init = function() vim.g.barbar_auto_setup = false end,
        opts = {
          -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
          -- animation = true,
          -- insert_at_start = true,
          -- …etc.
        },
        version = '^1.0.0', -- optional: only update when a new 1.x version is released
    },
}

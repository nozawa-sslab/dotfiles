-- local lualine_theme = "lualine.themes.iceberg_dark"
-- Change the background of lualine_c section for normal mode
-- custom_gruvbox.normal.c.bg = '#112233'

return {
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    ---enabled = false,
    config = function()
      require('lualine').setup {
       options = { theme = 'material' },
       sections = {
         lualine_y = { "progress", "location" },
         lualine_z = { "os.date('%H:%M')" },
       }
      }
    end
  },
  {
    'romgrk/barbar.nvim',
    enabled = false,
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
  {
    'akinsho/bufferline.nvim',
    enabled = true,
    version = "*",
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('bufferline').setup {
        options = {
          buffer_close_icon = ''
        }
      }
    end
  },
  {
    'folke/noice.nvim',
    event = "VeryLazy",
    dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    "MunifTanjim/nui.nvim",
    },
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
          },
        },
        messages = {
          enabled = false,
        },
        popupmenu = {
          enabled = false,
        }
      })
    end
  }
}

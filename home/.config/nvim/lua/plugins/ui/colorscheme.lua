return {
  {
    "cocopon/iceberg.vim",
    enabled = false,
    config = function()
        vim.cmd("colorscheme iceberg")
    end
  },
  {
    'bluz71/vim-nightfly-colors',
    enabled = false,
    config = function()
      -- Lua initialization file
      local custom_highlight = vim.api.nvim_create_augroup("CustomHighlight", {})
      vim.g.nightflyItalics = false
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "nightfly",
        callback = function()
         -- vim.api.nvim_set_hl(0, "Function", { fg = "#82aaff", bold = true })
        end,
        group = custom_highlight,
      })
      vim.cmd("colorscheme nightfly")
    end
  },
  {
    'bluz71/vim-moonfly-colors',
    lazy = false,
    priority = 1000,
--    enabled = false,
    config = function()
      -- Lua initialization file
      local custom_highlight = vim.api.nvim_create_augroup("CustomHighlight", {})
      vim.g.moonflyItalics = false
      vim.api.nvim_create_autocmd("ColorScheme", {
        pattern = "moonfly",
        callback = function()
         -- vim.api.nvim_set_hl(0, "Function", { fg = "#82aaff", bold = true })
        end,
        group = custom_highlight,
      })
      vim.api.nvim_create_autocmd("ColorScheme", {
        callback = function()
          vim.api.nvim_set_hl(0, "NormalFloat", {fg = "#c6c6c6", bg = "#1e2132"})
        end
      })
      vim.cmd("colorscheme moonfly")
    end
  },
}

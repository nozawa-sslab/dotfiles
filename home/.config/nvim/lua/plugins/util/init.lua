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
  },
  'tmux-plugins/vim-tmux-focus-events',
  {
    "christoomey/vim-tmux-navigator",
    cmd = {
      "TmuxNavigateLeft",
      "TmuxNavigateDown",
      "TmuxNavigateUp",
      "TmuxNavigateRight",
      "TmuxNavigatePrevious",
    },
    keys = {
      { "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>" },
      { "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>" },
      { "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>" },
      { "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>" },
      { "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>" },
    },
 },
 {
   'lewis/gitsigns.nvim',
   config = function()
     require('gitsigns').setup()
   end
 },
 {
   "nvim-tree/nvim-tree.lua",
   version = "*",
   lazy = false,
   dependencies = {
     "nvim-tree/nvim-web-devicons",
   },
   config = function()
     require("nvim-tree").setup {}
   end,
 }
}

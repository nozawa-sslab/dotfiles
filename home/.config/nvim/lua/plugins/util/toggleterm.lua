function open_gitui()
  local Terminal  = require('toggleterm.terminal').Terminal
  local gitui = Terminal:new({ cmd = "gitui", hidden = true, direction = "float" })
  gitui:toggle()
end

vim.api.nvim_create_user_command("Gitui", "lua open_gitui()<CR>", {})
return {
  'akinsho/toggleterm.nvim',
--  enabled = false,
  version = '*',
  config = function()
    require("toggleterm").setup()
    vim.api.nvim_create_autocmd({ "TermEnter" }, {
      pattern = "term://*toggleterm#*",
      callback = function()
        vim.keymap.set("t", "<c-t>", [[<Cmd>exe v:count1 . "ToggleTerm"<CR>]], { silent = true })
      end
    })
  end
}

local filetypes = {
  py   = { tabstop = 4, softtabstop = 4, shiftwidth = 4},
  c    = { tabstop = 2, softtabstop = 2, shiftwidth = 2},
  cc   = { tabstop = 2, softtabstop = 2, shiftwidth = 2},
  cpp  = { tabstop = 2, softtabstop = 2, shiftwidth = 2},
  h    = { tabstop = 2, softtabstop = 2, shiftwidth = 2},
  hh   = { tabstop = 2, softtabstop = 2, shiftwidth = 2},
  hpp  = { tabstop = 2, softtabstop = 2, shiftwidth = 2},
  json = { tabstop = 2, softtabstop = 2, shiftwidth = 2},
  sh   = { tabstop = 2, softtabstop = 2, shiftwidth = 2},
  zsh  = { tabstop = 2, softtabstop = 2, shiftwidth = 2},
  lua  = { tabstop = 2, softtabstop = 2, shiftwidth = 2}
}

local augroup_name = "fileTypeIndent"
vim.api.nvim_create_augroup(augroup_name, {})
for ext, option in pairs(filetypes) do
  vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    group = augroup_name,
    pattern = "*." .. ext,
    callback = function()
      for k, v in pairs(option) do
        vim.opt_local[k] = v
      end
    end
  })
end

-- fix nvim - alacritty windows padding issue
function Sad(line_nr, from, to, fname)
  vim.cmd(string.format("silent !sed -i '%ss/%s/%s/' %s", line_nr, from, to, fname)) 
end

function IncreasePadding() 
  Sad('03', 0, 10, '~/.config/alacritty/alacritty.yml')
  Sad('04', 0, 10, '~/.config/alacritty/alacritty.yml')
end

function DecreasePadding()
  Sad('03', 10, 0, '~/.config/alacritty/alacritty.yml')
  Sad('04', 10, 0, '~/.config/alacritty/alacritty.yml')
end

-- vim.cmd[[
--   augroup ChangeAlacrittyPadding
--    au! 
--    au VimEnter * lua DecreasePadding()
--    au VimLeavePre * lua IncreasePadding()
--   augroup END 
-- ]]

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    DecreasePadding()
  end,
})

vim.api.nvim_create_autocmd({ "VimLeavePre" }, {
  callback = function()
    IncreasePadding()
    vim.cmd('sleep 10m') -- https://github.com/neovim/neovim/issues/21856#issuecomment-1514723887
  end,
})

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
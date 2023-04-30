local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('settings')
require('keymaps')
require('plugins')

-- stuff i don't remember what is for
vim.g['&t_8f'] = "\\<Esc>[38;2;%lu;%lu;%lum"
vim.g['&t_8b'] = "\\<Esc>[48;2;%lu;%lu;%lum"


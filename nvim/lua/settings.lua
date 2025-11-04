vim.g.maplocalleader = " "
vim.g.mapleader = " "

-- tab stuff
vim.opt.tabstop=4
vim.opt.expandtab=true
vim.opt.softtabstop=4
vim.opt.shiftwidth=4
vim.opt.smarttab=true

-- line and numbers
vim.opt.cursorline=true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showcmd =true
vim.opt.wrap =true

-- search stuff
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- clipboard stuff
vim.opt.clipboard=unnamed
vim.cmd('set clipboard+=unnamedplus')

-- boh
vim.opt.hidden = true
vim.opt.termguicolors = true
vim.opt.wildmenu = true

-- Set updatetime for CursorHold
-- 300ms of no cursor movement to trigger CursorHold
vim.opt.updatetime = 100

-- have a fixed column for the diagnostics to appear in
-- this removes the jitter when warnings/errors flow in
vim.wo.signcolumn = "yes"

-- rust debugger
-- vim.cmd('packadd termdebug')
-- vim.cmd('let g:termdebugger="rust-gdb"')

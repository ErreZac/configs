-- Lazy setup

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

-- Settings

-- map leader key
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

-- EndSettings

-- Keymaps

-- esc removes last highlighted search
vim.api.nvim_set_keymap('n', '<esc>', ':noh<return><esc>', {noremap = true})

vim.api.nvim_set_keymap('n', '<Tab>', ':bnext<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<S-Tab>', ':bprevious<CR>', {noremap = true})

vim.api.nvim_set_keymap('n', '<leader>+', ':vspli<CR>', {noremap = true})
vim.api.nvim_set_keymap('n', '<leader>-', ':spli<CR>', {noremap = true})

-- guru mode for a greater good
vim.api.nvim_set_keymap('i', '<Up>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('i', '<Down>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('i', '<Left>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('i', '<Right>', '<NOP>', {noremap = true})

vim.api.nvim_set_keymap('n', '<Up>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Down>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Left>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('n', '<Right>', '<NOP>', {noremap = true})

vim.api.nvim_set_keymap('v', '<Up>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('v', '<Down>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('v', '<Left>', '<NOP>', {noremap = true})
vim.api.nvim_set_keymap('v', '<Right>', '<NOP>', {noremap = true})

local opts = {buffer = buffer}
vim.keymap.set('t', '<Esc>', [[<C-\><C-n>]], opts)
vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)

-- EndKeymaps

-- Miscellaneous

-- Show diagnostic popup on cursor hover
local diag_float_grp = vim.api.nvim_create_augroup("DiagnosticFloat", { clear = true })
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
   vim.diagnostic.open_float(nil, { focusable = false })
  end,
  group = diag_float_grp,
})

-- EndMiscellaneous

-- Plugins

require('lazy').setup({

    -- Mini
    {
        'echasnovski/mini.nvim',
        version = false,
        config = function()
            -- text editing
            require("mini.ai").setup()
            -- require("mini.align").setup()
            require("mini.comment").setup()
            require("mini.completion").setup()
            require("mini.move").setup()
            require("mini.operators").setup()
            require("mini.pairs").setup()
            require("mini.snippets").setup()
            require("mini.splitjoin").setup()
            require("mini.surround").setup()

            -- general workflow
            require("mini.basics").setup({
                options = { basic = true, extra_ui = true, win_borders = 'sinle', },
                mappings = { basic = true, option_toggle_prefix = [[]], windows = false, move_with_alt = false, },
                autocommands = { basic = true, relnum_in_visual_mode = true, },
                silent = false,
            })
            require("mini.bracketed").setup()
            require("mini.bufremove").setup()
            -- require("mini.clue").setup()
            -- require("mini.deps").setup()
            -- require("mini.diff").setup()
            -- require("mini.extra").setup()
            -- require("mini.files").setup()
            -- require("mini.git").setup()
            require("mini.jump").setup()
            -- require("mini.jump2d").setup()
            -- require("mini.misc").setup() -- something mitght be useful
            require("mini.pick").setup()
            -- require("mini.sessions").setup()
            -- require("mini.visits").setup()

            -- appearence
            require("mini.animate").setup()
            require("mini.cursorword").setup()
            require("mini.hipatterns").setup()
            require("mini.icons").setup()
            require("mini.map").setup()
            require("mini.starter").setup()
            require("mini.statusline").setup()
            require("mini.tabline").setup()
            require("mini.trailspace").setup()
        end
    },

    -- Smart splits for kitty
    {
        'mrjones2014/smart-splits.nvim',
        build = './kitty/install-kittens.bash' ,
        config = function()
            require('smart-splits').setup({
                move_cursor_same_row = false,
                cursor_follows_swapped_bufs = false,
                resize_mode = {
                    quit_key = '<ESC>',
                    resize_keys = { 'h', 'j', 'k', 'l' },
                    hooks = {
                        on_enter = nil,
                        on_leave = nil,
                    },
                },
                multiplexer_integration = nil,
                disable_multiplexer_nav_when_zoomed = true,
                kitty_password = nil,
                log_level = 'info',
            })
            vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
            vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
            vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
            vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
            vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
            vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
            vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
            vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
            vim.keymap.set('n', '<leader><leader>h', require('smart-splits').swap_buf_left)
            vim.keymap.set('n', '<leader><leader>j', require('smart-splits').swap_buf_down)
            vim.keymap.set('n', '<leader><leader>k', require('smart-splits').swap_buf_up)
            vim.keymap.set('n', '<leader><leader>l', require('smart-splits').swap_buf_right)
        end
    },

    -- Vimtex
    {
        'lervag/vimtex',
        config = function()
            vim.g.vimtex_view_method = "mupdf"
            vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_indent_enabled = 0
            vim.g.vimtex_syntax_enabled = 0
        end,
    },

    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")

            configs.setup({
                ensure_installed = {
                    "python", "lua", "c", "bash", "latex", "cpp", "rust", "json", "toml"
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end
    },

    -- LSP config
    {
        "neovim/nvim-lspconfig",
        config=function()
            require("lspconfig").pyright.setup{}
            require("lspconfig").clangd.setup{}
            -- require("lspconfig").lua_ls.setup{}
            require("lspconfig").rust_analyzer.setup{}
            require("lspconfig").texlab.setup{}
        end
    },

    -- colorscheme
    {
        'Mofiqul/vscode.nvim' ,
        config = function()
            vim.cmd('colorscheme vscode')
        end,
    },

})

-- EndPlugins

-- PluginKeymaps

-- mini bufremove
vim.keymap.set('n', '<leader>bd', function() require("mini.bufremove").delete() end, {noremap = true})

-- mini pick
vim.keymap.set('n', '<leader>ff', ':Pick files<CR>', {noremap = true})
vim.keymap.set('n', '<leader>fg', ':Pick grep_live<CR>', {noremap = true})

-- mini map
vim.keymap.set('n', '<leader>ms', function() require("mini.map").toggle() end, {noremap = true})
vim.keymap.set('n', '<leader>mt', function() require("mini.map").toggle_focus() end, {noremap = true})

-- mini trailspace
vim.keymap.set('n', '<leader>t', function() require("mini.trailspace").trim() end, {noremap = true})

-- EndPluginKeymaps


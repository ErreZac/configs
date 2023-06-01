require('lazy').setup({
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function() require("nvim-surround").setup({ }) end,
    },

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

    'vim-scripts/ReplaceWithRegister',
    {
        'mbbill/undotree',
        config = function()
            vim.api.nvim_set_keymap('n', '<leader>u', ':UndotreeToggle<CR>', {noremap = true})
        end
    },

    {
        'lervag/vimtex',
        config = function()
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_indent_enabled = 0
            vim.g.vimtex_syntax_enabled = 0
        end,
    },

    {
        'luisiacc/gruvbox-baby',
        config = function()
            vim.g.gruvbox_baby_background_color="dark"
            vim.g.gruvbox_baby_telescope_theme = 1
            vim.g.gruvbox_baby_transparent_mode = 1
            vim.g.gruvbox_baby_use_original_palette = 1
            -- vim.cmd[[colorscheme gruvbox-baby]]
        end,
    },

    { 
        'rose-pine/neovim', 
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end, 
    },

    'nvim-treesitter/nvim-treesitter-textobjects'     ,

    { 
        'nvim-treesitter/nvim-treesitter',
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {"lua", "c", "bash", "latex", "cpp", "rust"}, 
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = '<c-space>',
                        node_incremental = '<c-space>',
                        -- TODO: I'm not sure for this one.
                        scope_incremental = '<c-s>',
                        node_decremental = '<c-backspace>',
                    },
                },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
                        keymaps = {
                            -- You can use the capture groups defined in textobjects.scm
                            ['af'] = '@function.outer',
                            ['if'] = '@function.inner',
                            ['ac'] = '@class.outer',
                            ['ic'] = '@class.inner',
                        },
                    },
                    move = {
                        enable = true,
                        set_jumps = true, -- whether to set jumps in the jumplist
                        goto_next_start = {
                            [']m'] = '@function.outer',
                            [']]'] = '@class.outer',
                        },
                        goto_next_end = {
                            [']M'] = '@function.outer',
                            [']['] = '@class.outer',
                        },
                        goto_previous_start = {
                            ['[m'] = '@function.outer',
                            ['[['] = '@class.outer',
                        },
                        goto_previous_end = {
                            ['[M'] = '@function.outer',
                            ['[]'] = '@class.outer',
                        },
                    },
                    swap = {
                        enable = true,
                        swap_next = {
                            ['<leader>a'] = '@parameter.inner',
                        },
                        swap_previous = {
                            ['<leader>A'] = '@parameter.inner',
                        },
                    },
                },
            }
            vim.opt.foldmethod = "indent"
            vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
        end,
    },

    'kyazdani42/nvim-web-devicons',

    { 
        'nvim-tree/nvim-tree.lua',
        config = function()
            require("nvim-tree").setup({
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                    ignore_list = {},
                },
            })
            vim.api.nvim_set_keymap('n', '<C-t>', ':NvimTreeToggle<CR>', {noremap = true})
        end,
    },

    'nvim-lua/plenary.nvim',

    {
        'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'make' 
    },

    {
        'nvim-telescope/telescope.nvim', 
        config = function()
            require('telescope').setup {
                extensions = {
                    fzf = {
                        fuzzy = true,                    -- false will only do exact matching
                        override_generic_sorter = true,  -- override the generic sorter
                        override_file_sorter = true,     -- override the file sorter
                        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
                    }
                }
            }
            require('telescope').load_extension('fzf')
            vim.api.nvim_set_keymap('n', '<leader>fF', '<cmd>Telescope find_files<cr>', {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>fb', '<cmd>Telescope buffers<cr>', {noremap = true})
            vim.api.nvim_set_keymap('n', '<leader>fh', '<cmd>Telescope help_tags<cr>', {noremap = true})
            vim.api.nvim_set_keymap("n", "<leader>ff", ":Telescope file_browser<cr>", { noremap = true })
        end
    },
    
    { 
        "nvim-telescope/telescope-file-browser.nvim", 
        config=function()
            require("telescope").setup {
                extensions = {
                    file_browser = {
                        theme = "ivy",
                        hijack_netrw = true,
                        mappings = {
                            ["i"] = {
                                -- your custom insert mode mappings
                            },
                            ["n"] = {
                                -- your custom normal mode mappings
                            },
                        },
                    },
                },
            }
            require("telescope").load_extension "file_browser"
        end
    },

    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup()
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        config = function()
            require("mason-lspconfig").setup {
                ensure_installed = { "pyright", "texlab", "lua_ls", "rust_analyzer" },
            }
        end
    },
    {
        "neovim/nvim-lspconfig",
        config=function()
            require('lspconfig')['clangd'].setup { }

            require("lspconfig").pyright.setup{}

            require('lspconfig')['rust_analyzer'].setup {
                on_attach = on_attach,
                settings = {
                    ["rust-analyzer"] = {
                        assist = {
                            importMergeBehavior = "last",
                            importPrefix = "by_self",
                        },
                        diagnostics = {
                            disabled = { "unresolved-import" }
                        },
                        cargo = {
                            loadOutDirsFromCheck = true
                        },
                        procMacro = {
                            enable = true
                        },
                        checkOnSave = {
                            command = "clippy"
                        },
                    }
                }
            }

            require('lspconfig')['texlab'].setup {
                capabilities = capabilities,
                settings = {
                    latex = {
                        build = {
                            onSave = true;
                        }
                    }
                }
            }
            -- Global mappings.
            -- See `:help vim.diagnostic.*` for documentation on any of the below functions
            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

            -- Use LspAttach autocommand to only map the following keys
            -- after the language server attaches to the current buffer
            vim.api.nvim_create_autocmd('LspAttach', {
                group = vim.api.nvim_create_augroup('UserLspConfig', {}),
                callback = function(ev)
                    -- Enable completion triggered by <c-x><c-o>
                    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

                    -- Buffer local mappings.
                    -- See `:help vim.lsp.*` for documentation on any of the below functions
                    local opts = { buffer = ev.buf }
                    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
                    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
                    vim.keymap.set('n', '<space>wl', function()
                        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
                    end, opts)
                    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
                    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
                    vim.keymap.set({ 'n', 'v' }, '<space>ca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<space>f', function()
                        vim.lsp.buf.format { async = true }
                    end, opts)
                end,
            })

        end
    },
    'williamboman/nvim-lsp-installer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',

    {
        'hrsh7th/nvim-cmp',
        config = function()
            local cmp = require'cmp'
            cmp.setup({
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
                    end,
                },
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
                }),
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' }, -- For luasnip users.
                    { name = 'buffer' },
                    { name = 'path' },
                })
            })

            -- Set configuration for specific filetype.
            cmp.setup.filetype('gitcommit', {
                sources = cmp.config.sources({
                    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
                }, 
                    {
                        { name = 'buffer' },
                    })
            })

            -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline('/', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = {
                    { name = 'buffer' }
                }
            })

            -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
            cmp.setup.cmdline(':', {
                mapping = cmp.mapping.preset.cmdline(),
                sources = cmp.config.sources({
                    { name = 'path' }
                }, {
                        { name = 'cmdline' }
                    })
            })

            -- Setup lspconfig.
        end
    },

    {
        'simrat39/rust-tools.nvim', 
        config = function()
            require("rust-tools").setup({
                tools = {
                    runnables = {
                        use_telescope = true,
                    },
                    inlay_hints = {
                        auto = true,
                        show_parameter_hints = false,
                        parameter_hints_prefix = "",
                        other_hints_prefix = "",
                    },
                },
            })
        end,
    },

    {
        'L3MON4D3/LuaSnip',
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end
    },

    'saadparwaiz1/cmp_luasnip',
    "rafamadriz/friendly-snippets",

    { 
        "iurimateus/luasnip-latex-snippets.nvim",
        config = function()
            require'luasnip-latex-snippets'.setup({use_treesitter=true})
        end,
        ft = "tex",
    },

    {
        'norcalli/nvim-colorizer.lua', 
        config = function()
            require'colorizer'.setup()
        end
    },

    'ggandor/lightspeed.nvim',
    'tpope/vim-repeat',

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        config = function() 
            vim.opt.list = true
            vim.opt.listchars:append "eol:↴"
            require('indent_blankline').setup {
                char = '┊',
                show_trailing_blankline_indent = true,
                show_current_context = true,
                show_current_context_start = true,
                show_end_of_line = true,
            }
        end
    },

    {'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup {
                options = {
                    theme = auto,
                    component_separators = '',
                    section_separators = { left = '', right = '' },
                },
            }
        end
    },

    { 'toppair/peek.nvim', 
        build = 'deno task --quiet build:fast' ,
        config = function()
            vim.api.nvim_create_user_command('PeekOpen', require('peek').open, {})
            vim.api.nvim_create_user_command('PeekClose', require('peek').close, {})
        end
    },

    'famiu/bufdelete.nvim',

    { "kelly-lin/ranger.nvim",
        config = function()
            require("ranger-nvim").setup({ replace_netrw = true })
            vim.api.nvim_set_keymap("n", "<leader>ef", "", {
                noremap = true,
                callback = function()
                    require("ranger-nvim").open(true)
                end,
            })
        end,
    },

    { 'Wansmer/treesj',
        keys = { '<space>m', '<space>j', '<space>s' },
        dependencies = { 'nvim-treesitter/nvim-treesitter' },
        config = function()
            require('treesj').setup({
                max_join_length = 5000,
            })
        end,
    },

    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({
                auto_open = false,
                auto_close = false,
            }) 
            vim.api.nvim_set_keymap('n', '<leader>dd', ':TroubleToggle<CR>', {noremap = true})
        end
    },

    {'f-person/git-blame.nvim',
        config = function()
            vim.cmd[[let g:gitblame_enabled = 0]]
        end
    },

    {
        {
            'akinsho/toggleterm.nvim', 
            version = "*", 
            config = function()
                require("toggleterm").setup{
                    open_mapping = [[<leader>tt]],
                    shade_terminals = false,
                }
                function _G.set_terminal_keymaps()
                    local opts = {buffer = 0}
                    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
                    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
                    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
                    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
                    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
                    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
                end

                -- if you only want these mappings for toggle term use term://*toggleterm#* instead
                vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

                local Terminal  = require('toggleterm.terminal').Terminal
                local lazygit = Terminal:new({
                    cmd = "lazygit",
                    dir = "git_dir",
                    direction = "float",
                    -- function to run on opening the terminal
                    on_open = function(term)
                        vim.cmd("startinsert!")
                        vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
                    end,
                    -- function to run on closing the terminal
                    on_close = function(term)
                        vim.cmd("startinsert!")
                    end,
                })

                function _lazygit_toggle()
                    lazygit:toggle()
                end

                vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})
            end
        }
    },

    {
        'stevearc/oil.nvim',
        opts = {},
        config = function()
            require("oil").setup()
            vim.keymap.set("n", "<leader>-", require("oil").open, { desc = "Open parent directory" })
        end
    },

})

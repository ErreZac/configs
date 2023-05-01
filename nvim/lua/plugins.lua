require('lazy').setup({
    'tpope/vim-surround',
    'christoomey/vim-tmux-navigator',
    'vim-scripts/ReplaceWithRegister',
    'mbbill/undotree',

    {'lervag/vimtex',
        config = function()
            vim.g.vimtex_view_method = "zathura"
            vim.g.vimtex_view_general_options = "--unique file:@pdf\\#src:@line@tex"
            vim.g.vimtex_compiler_method = "latexmk"
            vim.g.vimtex_indent_enabled = 0
            vim.g.vimtex_syntax_enabled = 0
        end
    },

    { 'folke/zen-mode.nvim',
        config = function()
            require("zen-mode").setup {
                window = {
                    width = .65 -- width will be 85% of the editor width
                }
            }
        end,
    },

    {'luisiacc/gruvbox-baby',
        config = function()
            vim.g.gruvbox_baby_background_color="dark"
            vim.g.gruvbox_baby_telescope_theme = 1
            vim.g.gruvbox_baby_transparent_mode = 1
            vim.g.gruvbox_baby_use_original_palette = 1
            -- vim.cmd[[colorscheme gruvbox-baby]]
        end,
    },

    { 'rose-pine/neovim', 
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end, 
    },

    'nvim-treesitter/nvim-treesitter-textobjects'     ,

    { 'nvim-treesitter/nvim-treesitter',
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

    { 'nvim-tree/nvim-tree.lua',
        config = function()
            require("nvim-tree").setup({
                update_focused_file = {
                    enable = true,
                    update_cwd = true,
                    ignore_list = {},
                },
            })
        end,
    },

    'nvim-lua/plenary.nvim',

    {'nvim-telescope/telescope-fzf-native.nvim', 
        build = 'make' 
    },

    {'nvim-telescope/telescope.nvim', 
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
        end
    },
    
    { "nvim-telescope/telescope-file-browser.nvim", 
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

    'neovim/nvim-lspconfig',
    'williamboman/nvim-lsp-installer',
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',

    {'hrsh7th/nvim-cmp',
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
            local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
            require('lspconfig')['clangd'].setup {
                capabilities = capabilities
            }

            require("lspconfig").pyright.setup{}
            -- require'lspconfig'.pylyzer.setup{}

            require'lspconfig'.grammarly.setup{
                filetypes = { "markdown", "tex" },
                clientId = "client_HCS8BeaK7zvoWinvRRNG9n"
            }

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
        end
    },

    {'simrat39/rust-tools.nvim', 
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

    {'L3MON4D3/LuaSnip'},
    'saadparwaiz1/cmp_luasnip',

    { "iurimateus/luasnip-latex-snippets.nvim",
        config = function()
            require'luasnip-latex-snippets'.setup({use_treesitter=true})
        end,
        ft = "tex",
    },

    {'norcalli/nvim-colorizer.lua', 
        config = function()
            require'colorizer'.setup()
        end
    },

    'ggandor/lightspeed.nvim',
    'tpope/vim-repeat',

    {'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    {'lukas-reineke/indent-blankline.nvim',
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
    }
})

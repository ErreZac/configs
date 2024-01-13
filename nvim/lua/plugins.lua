require('lazy').setup({
    {
        "kylechui/nvim-surround",
        version = "*",
        event = "VeryLazy",
        config = function() require("nvim-surround").setup({}) end,
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
        end
    },

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
        'rose-pine/neovim', 
        as = 'rose-pine',
        config = function()
            require('rose-pine').setup({
            --- @usage 'auto'|'main'|'moon'|'dawn'
            -- variant = 'dawn',
            variant = 'moon',
            bold_vert_split = false,
            })
            vim.cmd('colorscheme rose-pine')
        end, 
    },

    'nvim-treesitter/nvim-treesitter-textobjects'     ,

    { 
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        config = function()
            require('nvim-treesitter.configs').setup {
                ensure_installed = {"python", "lua", "c", "bash", "latex", "cpp", "rust"}, 
                highlight = { enable = true },
                indent = { enable = true },
                incremental_selection = {
                    enable = true,
                    -- keymaps = {
                    --     init_selection = '<c-space>',
                    --     node_incremental = '<c-space>',
                    --     -- TODO: I'm not sure for this one.
                    --     scope_incremental = '<c-s>',
                    --     node_decremental = '<c-backspace>',
                    -- },
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
            vim.cmd [[TSUpdate]]
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
                ensure_installed = { "clangd", "pyright", "texlab", "lua_ls", "rust_analyzer" },
            }
        end
    },

    {
        "neovim/nvim-lspconfig",
        config=function()
            require('lspconfig')['clangd'].setup { }

            require("lspconfig").pyright.setup{}

            -- require('lspconfig')['rust_analyzer'].setup {
            --     on_attach = on_attach,
            --     settings = {
            --         ["rust-analyzer"] = {
            --             assist = {
            --                 importMergeBehavior = "last",
            --                 importPrefix = "by_self",
            --             },
            --             diagnostics = {
            --                 disabled = { "unresolved-import" }
            --             },
            --             cargo = {
            --                 loadOutDirsFromCheck = true
            --             },
            --             procMacro = {
            --                 enable = true
            --             },
            --             checkOnSave = {
            --                 command = "clippy"
            --             },
            --         }
            --     }
            -- }

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

            vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
            vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
            vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
            vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

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
                    -- vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
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
        end
    },

    { 'saadparwaiz1/cmp_luasnip' },

    -- {
    --     'simrat39/rust-tools.nvim', 
    --     config = function()
    --         require("rust-tools").setup({
    --             tools = {
    --                 runnables = {
    --                     use_telescope = true,
    --                 },
    --                 inlay_hints = {
    --                     auto = true,
    --                     show_parameter_hints = false,
    --                     parameter_hints_prefix = "",
    --                     other_hints_prefix = "",
    --                 },
    --             },
    --         })
    --     end,
    -- },
    --
    {
        'mrcjkb/rustaceanvim',
        version = '^3', -- Recommended
        ft = { 'rust' },
    },
    
    {
        'L3MON4D3/LuaSnip',
        after = 'nvim-cmp',
        dependencies = {
            "rafamadriz/friendly-snippets",
            "molleweide/LuaSnip-snippets.nvim",
            "evesdropper/luasnip-latex-snippets.nvim",
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },

    {
        'norcalli/nvim-colorizer.lua', 
        config = function()
            require'colorizer'.setup()
        end
    },

    'ggandor/lightspeed.nvim',
    'tpope/vim-repeat',

    'itchyny/vim-cursorword',
    'anufrievroman/vim-angry-reviewer',
    'junegunn/vim-after-object',

    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    },

    {
        'lukas-reineke/indent-blankline.nvim',
        main = "ibl",
        config = function() 
            require("ibl").setup()
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

    {"AckslD/nvim-neoclip.lua",
        requires = {
            {'nvim-telescope/telescope.nvim'},
            {'kkharji/sqlite.lua', module = 'sqlite'},
        },
        config = function()
            require('neoclip').setup()
        end,
    },

    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function() vim.fn["mkdp#util#install"]() end,
    },

    {
        'simonmclean/triptych.nvim',
        event = 'VeryLazy',
        dependencies = {
            'nvim-lua/plenary.nvim', -- required
            'nvim-tree/nvim-web-devicons', -- optional
        },
        config = function() 
            require 'triptych'.setup() 
            vim.keymap.set('n', '<leader>r', ':Triptych<CR>', { silent = true })
        end,

    },

    {
        'akinsho/toggleterm.nvim', 
        version = "*", 
        config = function()
            require'toggleterm'.setup {
                shade_terminals = false
            }
            vim.cmd[[nnoremap <leader><return> :ToggleTerm<CR>]]
            vim.cmd[[inoremap <leader><return> :ToggleTerm<CR>]]
        end
    },

    {
        'levouh/tint.nvim',
        config = function()
            require("tint").setup() --{
            -- tint = -45,  -- Darken colors, use a positive value to brighten
            -- saturation = 0.6,  -- Saturation to preserve
            -- transforms = require("tint").transforms.SATURATE_TINT,  -- Showing default behavior, but value here can be predefined set of transforms
            -- tint_background_colors = true,  -- Tint background portions of highlight groups
            -- highlight_ignore_patterns = { "WinSeparator", "Status.*" },  -- Highlight group patterns to ignore, see `string.find`
            -- window_ignore_function = function(winid)
            --     local bufid = vim.api.nvim_win_get_buf(winid)
            --     local buftype = vim.api.nvim_buf_get_option(bufid, "buftype")
            --     local floating = vim.api.nvim_win_get_config(winid).relative ~= ""
            --
            --     -- Do not tint `terminal` or floating windows, tint everything else
            --     return buftype == "terminal" or floating
            -- end
            -- })
        end
    },

    {
        'nyngwang/NeoRoot.lua',
        config = function()
            require('neo-root').setup {
                CUR_MODE = 2 -- 1 for file/buffer mode, 2 for proj-mode
            }
            local NOREF_NOERR_TRUNC = { noremap = true, silent = true, nowait = true }
            vim.cmd'au BufEnter * NeoRoot'
            vim.keymap.set('n', '<Leader>p', function() vim.cmd('NeoRootSwitchMode') end, NOREF_NOERR_TRUNC)
            vim.keymap.set('n', '<Leader>pre', function() vim.cmd('NeoRootChange') end, NOREF_NOERR_TRUNC)
        end
    },
    {
        "HakonHarnes/img-clip.nvim",
        event = "BufEnter",
        -- opts = {
            -- add options here
            -- or leave it empty to use the default settings
        -- },
        -- keys = {
            -- suggested keymap
            -- { "<leader>p", "<cmd>PasteImage<cr>", desc = "Paste clipboard image" },
        -- },
    }

})

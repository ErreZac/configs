call plug#begin()
Plug 'preservim/NERDTree'
Plug 'itchyny/lightline.vim'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'ap/vim-css-color'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'https://github.com/ap/vim-css-color'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-speeddating'
Plug 'christoomey/vim-tmux-navigator'
Plug 'ericbn/vim-solarized'
Plug 'mbbill/undotree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rose-pine/vim'
Plug 'lervag/vimtex'
" Plug 'bounceme/poppy.vim'
Plug 'b4winckler/vim-angry'
Plug 'itchyny/vim-cursorword'
Plug 'machakann/vim-highlightedyank'
call plug#end()

" settings

set number
set relativenumber
set showcmd
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set smarttab
set autoindent
set cindent
set ignorecase
set smartcase
set incsearch
set hlsearch
set clipboard=unnamed
set clipboard+=unnamedplus
let g:lightline = {'colorscheme': 'rosepine', }
set hidden
set wildmenu
syntax enable
set background=dark
set termguicolors
colorscheme rosepine

" keymaps

map localleader = " "
map leader = " "

inoremap <Up> <NOP>
inoremap <Down> <NOP>
inoremap <Left> <NOP>
inoremap <Right> <NOP>
nnoremap <Up> <NOP>
nnoremap <Down> <NOP>
nnoremap <Left> <NOP>
nnoremap <Right> <NOP>
vnoremap <Up> <NOP>
vnoremap <Down> <NOP>
vnoremap <Left> <NOP>
vnoremap <Right> <NOP>
inoremap jj <ESC>
cnoremap jj <ESC>
nnoremap gV `[v`]
nnoremap <esc> :noh<return><esc>
nnoremap <Tab> :bnext<CR>
nnoremap <S-Tab> :bprevious<CR>
nnoremap <leader>bd :bdelete<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-u> :UndotreeToggle<CR>
nnoremap <C-s> :setlocal spell! spelllang=en_us<CR>

" plugins

let g:vimtex_view_method = 'zathura'

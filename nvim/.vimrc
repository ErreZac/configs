call plug#begin()
Plug 'ryanoasis/vim-devicons'
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
Plug 'b4winckler/vim-angry'
Plug 'itchyny/vim-cursorword'
Plug 'machakann/vim-highlightedyank'
Plug 'anufrievroman/vim-angry-reviewer' 
Plug 'coderifous/textobj-word-column.vim'
Plug 'junegunn/vim-after-object'
Plug 'zivyangll/git-blame.vim'
call plug#end()

" settings

set encoding=UTF-8
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

let maplocalleader = ","
let mapleader = " "

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
let g:AngryReviewerEnglish = 'american'
autocmd VimEnter * call after_object#enable('=', ':', '-', '#', ' ')

" bindings
"
nnoremap <leader>ar :AngryReviewer<cr>
nnoremap <Leader>gb :<C-u>call gitblame#echo()<CR>

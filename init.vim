" ----------------------------------------------------------------------------
" General settings
" ----------------------------------------------------------------------------

"filetype plugin indent on
"set nocompatible
"set number
"set relativenumber
"set showmatch
"set hlsearch
"set cc=79
"set autoindent
"set expandtab
"set tabstop=4
"set shiftwidth=4
"set softtabstop=4

" ----------------------------------------------------------------------------
" Colors
" ----------------------------------------------------------------------------

"syntax on
" colorscheme nord " Can't be found .... 

" ----------------------------------------------------------------------------
" Mode mappings
" ----------------------------------------------------------------------------

" normal mode map -- `:nnoremap`
" insert mode map -- `:inoremap`

"let g:mapleader = ','

"nnoremap <leader>s :set invspell<CR>
"nnoremap <leader>day :read ~/.config/nvim/_misc/everyday.txt<CR>
"inoremap <leader>d <C-R>=strftime("%Y-%m-%dT%H:%M")<CR>

" ----------------------------------------------------------------------------
" Plugins
" ----------------------------------------------------------------------------
lua require('plugins')

"call plug#begin('~/.config/nvim/plugged')

"Plug 'Raimondi/delimitMate'
"Plug 'arcticicestudio/nord-vim'
"Plug 'godlygeek/tabular'
"Plug 'preservim/vim-markdown'
"Plug 'vimwiki/vimwiki'
"Plug 'https://github.com/scrooloose/nerdtree'
"Plug 'github/copilot.vim'

"call plug#end()

" ----------------------------------------------------------------------------
" Misc
" ----------------------------------------------------------------------------

"let g:vimwiki_list = [{'path': '~/doc/wiki/', 'path_html': '~/doc/wiki/html/'}]
"let g:vimwiki_url_maxsave=0


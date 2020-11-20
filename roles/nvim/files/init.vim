let g:coc_global_extensions = [
\ 'coc-yaml',
\ 'coc-tsserver',
\ 'coc-solargraph',
\ 'coc-json',
\ 'coc-java',
\ 'coc-html',
\ 'coc-go',
\ 'coc-css'
\ ]

call plug#begin('~/.vim/plugged')

  Plug 'preservim/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'ryanoasis/vim-devicons'
  Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'arcticicestudio/nord-vim'
  Plug 'vim-airline/vim-airline'
  Plug 'edkolev/tmuxline.vim'
  Plug 'neoclide/coc.nvim', { 'branch': 'release', 'do': { -> coc#util#install() } }
  Plug 'tpope/vim-endwise'
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'jparise/vim-graphql'
  Plug 'Raimondi/delimitMate'
  Plug 'alvan/vim-closetag'
  Plug 'slim-template/vim-slim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-surround'
  Plug 'uiiaoo/java-syntax.vim'

call plug#end()

" >>> Language settings <<< "
autocmd Filetype vim setlocal expandtab tabstop=2 shiftwidth=2
autocmd Filetype json setlocal expandtab tabstop=2 shiftwidth=2
autocmd Filetype scss setlocal expandtab tabstop=2 shiftwidth=2
autocmd Filetype css setlocal expandtab tabstop=2 shiftwidth=2
autocmd Filetype typescript setlocal expandtab tabstop=2 shiftwidth=2
autocmd Filetype typescriptreact setlocal expandtab tabstop=2 shiftwidth=2
autocmd Filetype javascript setlocal expandtab tabstop=2 shiftwidth=2
autocmd Filetype javascriptreact setlocal expandtab tabstop=2 shiftwidth=2
autocmd Filetype yaml setlocal expandtab tabstop=2 shiftwidth=2
autocmd Filetype java setlocal expandtab tabstop=4 shiftwidth=4
autocmd Filetype go setlocal expandtab tabstop=4 shiftwidth=4

" >>> Neovim config <<< "
set guicursor=
set mouse=a
set relativenumber
set noshowmode
set splitright
set splitbelow
set nowrap
syntax enable
filetype plugin indent on

try
  colorscheme nord
catch /^Vim\%((\a\+)\)\=:E185/
  "Nord is not installed use builtin theme"
  colorscheme elflord
endtry

nnoremap <silent> <C-j> :bprevious<CR>
nnoremap <silent> <C-k> :bnext<CR>
nnoremap <silent> <C-d> :bw<CR>
nnoremap <silent> <C-S-h> :let @+=expand('%:p')<CR> 
vmap <C-S-c> "+y
vmap <C-S-x> "+x 
autocmd! Filetype qf nnoremap <buffer> <leader><Enter> <C-w><Enter><C-w>T

" >>> VimCloseTag config <<< "
let g:closetag_filenames = '*.html,*.jsx,*.tsx,*.vue,*.svelte'
let g:closetag_xhtml_filenames = '*.jsx,*.tsx'

" >>> Airline config <<< "
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#branch#enabled=1
let g:airline#extensions#tmuxline#enabled = 1
let airline#extensions#tmuxline#snapshot_file = "~/.config/tmux-status.conf"
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9

" >>> CoC config <<< "
inoremap <silent><expr> <C-S-p> coc#refresh()
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

" >>> NERDTree config <<< "
let NERDTreeShowHidden=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
map <C-n> :NERDTreeToggle<CR>
map <C-m> :NERDTreeFind<CR>

" >>> FZF config <<<
nnoremap <silent> <C-f> :GFiles<CR>
nnoremap <silent> <C-i> :Rg<CR>
let g:fzf_layout = { 'down': '~40%' }


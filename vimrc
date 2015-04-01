" don't sacrifice anything for vi compatibility
set nocompatible
set splitbelow
set splitright
" vundle begin
filetype off

" 256 colors
set t_Co=256
colorscheme byland

" use comma as <leader> key instead of backslash
let mapleader=","

func Eatchar(pat)
    let c = nr2char(getchar(0))
    return (c =~ a:pat) ? '' : c
endfunc
autocmd BufNewFile,BufRead *.java iab println System.out.println("");<Left><Left><Left><C-R>=Eatchar('\s')<CR>


" vundle
" set rtp+=~/.vim/bundle/vundle/
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Let Vundle manage itself
Plugin 'gmarik/Vundle.vim'
" Plugin 'Raimondi/delimitMate'
Plugin 'kien/ctrlp.vim'
Plugin 'scrooloose/nerdtree'
" Plugin 'scrooloose/syntastic'
Plugin 'derekwyatt/vim-scala'
Plugin 'tpope/vim-commentary'
Plugin 'bling/vim-airline'
Plugin 'bling/vim-bufferline'
" Plugin 'airblade/vim-gitgutter'

call vundle#end()            " required
filetype plugin indent on

" encoding
set encoding=utf-8

" Enable relative line numbers
set relativenumber

" Show buffers
nmap Å :buffers!<cr>:buffer<Space>

" Go to last buffer
nnoremap å :b#<cr>
nnoremap <space> :bnext<cr>
nnoremap <bs> :bprev<cr>

" airline settings
let g:airline_theme='wombat'

let g:airline#extensions#whitespace#symbol = '!'
let g:airline#extensions#whitespace#trailing_format = '%s'
let g:airline#extensions#whitespace#mixed_indent_format = '~ %s'

let g:airline_left_sep=""
let g:airline_right_sep=""
let g:airline_mode_map = {
            \ '__' : '-',
            \ 'n'  : 'N',
            \ 'i'  : 'I',
            \ 'R'  : 'R',
            \ 'c'  : 'C',
            \ 'v'  : 'V',
            \ 'V'  : 'V-LINE',
            \ '^V' : 'V',
            \ 's'  : 'S',
            \ 'S'  : 'S',
            \ '^S' : 'S',
            \ }
let g:airline_section_z = '%l:%c %p%%'

" enable bufferline in airline
let g:airline#extensions#bufferline#enabled = 1
let g:bufferline_echo = 0

" gitgutter options
let g:gitgutter_map_keys = 0
nmap gk <plug>GitGutterPrevHunk
nmap gj <plug>GitGutterNextHunk
nmap gs <plug>GitGutterStageHunk
nmap gr <plug>GitGutterRevertHunk

" x + 'å' jumps to buffer x
let c = 1
while c <= 9
  execute "nnoremap " . c . "å :" . c . "b\<cr>"
  let c += 1
endwhile

" remove buffer
nmap <leader>r :bwipeout<cr>

" allow us to change unsaved buffers
set hidden

syntax on
set number
set ruler
set laststatus=2
set scrolloff=2

" Whitespace stuff
set nowrap
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set list listchars=tab:\ \ ,trail:·

" Show invisibles.
set listchars=nbsp:·,tab:▸\ ,trail:·
set list!

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Tab completion
set wildmode=list:longest,list:full

" prettier completion in cmdline
set wildmenu

" backspace fix
set backspace=indent,eol,start

" Latex
autocmd Filetype tex setl updatetime=1
" Rainbow parenthesis improved
let g:rainbow_active = 1
" Run default test constant.
let g:RUN_DEFAULT_TEST = 0
" Run current test in focus constant.
let g:RUN_FOCUS_TEST = 1
" Run last runned test constant.
let g:RUN_LAST_TEST = 2

" ctrlp
let g:ctrlp_match_window_reversed = 0
let g:ctrlp_prompt_mappings = {'PrtExit()':['§']}

" closetag
let g:closetag_html_style=1

" Gets rid of startup message
set shortmess+=I

" map capital w to write
command! W w

" map write and quit typo
command Wq wq

" new tab alias
cabbrev tnew tabedit

" align columns
map <leader>a :!column -t<cr>

" map <leader>c to tcomment
map <leader>c :Commentary<cr>

" toggle nerdtree
nmap <leader>d :NERDTreeToggle<cr>

" toggle nerdtree with the cursor positioned at the current file
nmap <leader>D :NERDTreeFind<cr>

" jump to the first ctag match
map <leader>j <c-]><cr>

" list all ctag matches for the word under the cursor
map <leader>J :CtrlPTag<CR><C-\>w

" show ctrlptag
map <leader>t :CtrlPTag<CR>

" map <leader>f to ctrlp
map <leader>f :CtrlP<cr>

" show diff using git for current file
map <leader>g :!git diff %<cr>

" open rails test file
map <leader>s :call OpenTest()<cr>

" run current test
" map <leader>r :call RunCurrentTest(RUN_DEFAULT_TEST)<cr>

" run last runned test
map <leader>l :call RunCurrentTest(RUN_LAST_TEST)<cr>

" run current test in focus
map <leader>R :call RunCurrentTest(RUN_FOCUS_TEST)<cr>

" map c in visual mode to select the current line
map <leader>v :call VisualSelectCurrentLine()<cr>

" map <leader>w to close current split
map <leader>w :q<cr>

" map <leader>q to close current tab
map <leader>q :tabclose<cr>

" suspend vim
map <leader>z <c-z>

" More convenient esc bindings for mac
map § <Esc>
cmap § <Esc>
imap § <Esc>
smap § <Esc>

" Clear current hilighted search on esc
nnoremap § :noh<return><esc>

" Map capital u to redo changes
nnoremap U <C-r>

" Interpret as Ruby
au BufRead,BufNewFile {Capfile,Gemfile,Rakefile,Thorfile,config.ru} set ft=ruby

" wrap markdown and latex
au BufRead,BufNewFile {*.md,*.tex} setlocal textwidth=80

" Global ignore
set wildignore+=*.o,*.obj,.git,*.rbc,*/doc/*,*/node_modules/*,*/tmp/*,*.*~,*.class

" Non blinking cursor.
set guicursor+=a:blinkon0

" set cursorline!

" Disable netrw history
let g:netrw_dirhistmax = 0
let g:netrw_dirhist_cnt = 0

" directories for swp files
set directory=/tmp
set backupdir=/tmp

nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" hilight column 80
" set colorcolumn=80
" hi ColorColumn ctermbg=blue ctermfg=white guibg=#592929

" white background
" hi Normal ctermbg=white guibg=white

" white status bar
hi StatusLineNC guifg=white ctermfg=white guibg=black ctermbg=black gui=NONE

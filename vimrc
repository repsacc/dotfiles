" don't sacrifice anything for vi compatibility
set nocompatible

set splitbelow
set splitright
" vundle begin
filetype off

" vundle
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
  
Bundle 'gmarik/vundle'
Bundle 'christoomey/vim-tmux-navigator'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'Raimondi/delimitMate'
Bundle 'docunext/closetag.vim'
Bundle 'ervandew/supertab'
Bundle 'garbas/vim-snipmate'
Bundle 'jnwhiteh/vim-golang'
Bundle 'kien/ctrlp.vim'
Bundle 'mptre/snipmate-snippets'
Bundle 'nelstrom/vim-mac-classic-theme'
Bundle 'scrooloose/nerdtree'
Bundle 'tomtom/tcomment_vim'
Bundle 'tomtom/tlib_vim'
Bundle 'tpope/vim-eunuch'
Bundle 'tpope/vim-rails'
Bundle 'tpope/vim-surround'

filetype plugin indent on

" encoding
set encoding=utf-8

syntax on
set number
set ruler
set laststatus=2
set scrolloff=2

" Whitespace stuff
set nowrap
set tabstop=2
set shiftwidth=2
set softtabstop=2
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
"
  " " Outliner: {{{1
  " hi BT1 guifg=#808080 ctermfg=244 gui=italic
  " hi OL1 guifg=#000000 ctermfg=0 gui=bold
  " hi OL2 guifg=#0000A2 ctermfg=19 gui=bold
  " hi OL3 guifg=#007B22 ctermfg=28 gui=bold
  " hi OL4 guifg=#6E7935
  " hi link cssAttr cssC}}}}}}}}}}}}}}}}"

" backspace fix
set backspace=indent,eol,start

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

" use comma as <leader> key instead of backslash
let mapleader=","

" map capital w to write
command! W w

" map write and quit typo
command Wq wq

" new tab alias
cabbrev tnew tabedit

" align columns
map <leader>a :!column -t<cr>

" map <leader>c to tcomment
map <leader>c :TComment<cr>

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
map <leader>r :call RunCurrentTest(RUN_DEFAULT_TEST)<cr>

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
" colorscheme
" colorscheme mac_classic

" hilight column 80
set colorcolumn=80
hi ColorColumn ctermbg=255 guibg=255

" white background
" hi Normal ctermbg=white guibg=white

" white status bar
hi StatusLineNC guifg=white ctermfg=white guibg=black ctermbg=black gui=NONE

" Create the directory of the current file
function CreateDirectory()
  silent exec "!mkdir -p %:h"
  redraw!
endfunction

function VisualSelectCurrentLine()
  exec "normal! 0vg_"
endfunction

function OpenTest()
  let test_file = GetTestFile(0)
  let position = IsTestFile() ? "topleft" : "botright"

  exec position . " vsplit " . test_file
  redraw!
endfunction

function GetTestFile(test_file_only)
  let test_file = expand('%')
  let test_file_suffix = GetTestFileSuffix()

  if IsTestFile() && !a:test_file_only
    let test_file = substitute(test_file, '^' . GetTestFileDirectory() . '\/', '', '')
    let test_file = substitute(test_file, '_' . test_file_suffix . '\(.' . GetTestFileType() . '\)$', '\1', '')
    let prefixes = ['', 'app/', 'app/assets/']

    for prefix in prefixes
      let test_file_tmp = prefix . test_file
      silent exec "!ls " . test_file_tmp . " &> /dev/null"

      if v:shell_error == 0
        break
      endif
    endfor

    let test_file = test_file_tmp
  elseif !IsTestFile()
    let test_file = substitute(test_file, '^app\/', '', '')
    let test_file = substitute(test_file, '^assets\/', '', '')
    let test_file = substitute(test_file, '.' . GetTestFileType() . '$', '_' . test_file_suffix . '\0', '')
    let test_file_directory = GetTestFileDirectory()

    " if strlen(test_file_directory) == 0 && strlen(test_file_suffix) > 0
    "   let test_file_directory = test_file_suffix . '/'
    " endif

    let test_file = test_file_directory . test_file
  endif

  return test_file
endfunction

function GetTestFileSuffix()
  let directories = ['test', 'spec']
  let suffix = directories[0]

  for dir in directories
    silent exec "!ls " . dir . " &> /dev/null"

    if v:shell_error == 0
      let suffix = dir
      break
    endif
  endfor

  return suffix
endfunction

function GetTestFileDirectory()
  let directories = ['test', 'spec']
  let directory = ''

  for dir in directories
    silent exec '!ls ' . dir . ' &> /dev/null'

    if v:shell_error == 0
      let directory = dir . '/'
      break
    endif
  endfor

  return directory
endfunction

function GetTestInFocus()
  let test_in_focus = system("sed -n 1," . GetTestFileLine() . "p " . GetTestFile(1) . " | grep 'it [^:word:]' | sed 's/it\ [^:word:]\\(.*\\)[^:word:]\ do/\\1/' | tail -1 | xargs echo -n")
  let test_in_focus = '/' . test_in_focus . '/'
  let test_in_focus = substitute(test_in_focus, '\s', '\\\\s', 'g')

  return test_in_focus
endfunction

function GetTestFileLine()
  return line(".")
endfunction

function GetTestFileType()
  return expand('%:e')
endfunction

function GetTestRunner()
  if exists('g:test_runner')
    return g:test_runner
  elseif exists('$TEST_RUNNER')
    return $TEST_RUNNER
  endif
endfunction

function IsTestFile()
  return match(expand('%'), '_' . GetTestFileSuffix() . '.' . GetTestFileType() . '$') > -1
endfunction

" test runner
function RunCurrentTest(run_mode)
  let cmd = GetTestRunner()

  if a:run_mode == g:RUN_LAST_TEST
    let test_file = g:last_test_file
  else
    let test_file = GetTestFile(1)
  end

  let cmd .= " " . test_file
  let g:last_test_file = test_file

  if a:run_mode == g:RUN_FOCUS_TEST
    let cmd .= " -n " . GetTestInFocus()
  end

  " save current buffer
  write
  " run test
  exec "!" . cmd
  " clear output
  silent exec "!clear"
endfunction

" Convert a single line import in Go into multi lines.
"
"   # before
"   import \"fmt\"
"
"   # after
"   import (
"       \"fmt\"
"   )
function GoMultipleImport()
  " Move to start of line.
  exec "normal 0"
  " Find the first string literal.
  exec "normal f\""
  " Insert open parentheses and new line.
  exec "normal i(\n"
  " Insert new line and close parentheses.
  exec "normal o)"
endfunction

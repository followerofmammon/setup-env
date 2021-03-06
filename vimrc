set colorcolumn=109
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns
set tabstop=4     " a hard TAB displays as 4 columns
set expandtab     " insert spaces when hitting TABs
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line
"Continuation line:
set cindent
set cinoptions=(0,u0,U0
syntax enable


"Switch-tab behavior
set switchbuf+=usetab,newtab

set runtimepath^=~/.vim/bundle/ctrlp.vim,~/.vim/bundle/vim-bling,~/.vim/bundle/grep,~/.vim/bundle/vim-surround,~/.vim/bundle/rainbow_parentheses.vim,~/.vim/bundle/bufexplorer.vim,~/.vim/bundle/jedi-vim,~/.vim/bundle/vim-fugitive,~/.vim/bundle/supertab,~/.vim/bundle/pyflakes-vim,~/.vim/bundle/nerdtree
set omnifunc=jedi#completions

let g:ctrlp_working_path_mode = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|\.hg|\.svn|.connections|build)$',
  \ 'file': '\v\.(exe|dll|pyc|stratolog|logs.racktest|o|so|a)$',
  \ 'link': 'some_bad_symbolic_links',
  \ }
let g:ctrlp_max_files=300000
let g:ctrlp_use_caching = 1
let g:ctrlp_cache_dir = "/tmp"
let g:ctrlp_switch_buffer = 't'


"incremental search
set incsearch
"highlight search
set hlsearch
"Press enter to remove search highlight
"Spell check
"set spell spelllang=en_us
"highlight clear SpellBad
"highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
"highlight clear SpellCap
"highlight SpellCap term=underline cterm=underline
"highlight clear SpellRare
"highlight SpellRare term=underline cterm=underline
"highlight clear SpellLocal
"highlight SpellLocal term=underline cterm=underline
"Case insensitive search by default
set ignorecase
set smartcase
"Show line numbers
set number
""Exit insert more without delay
set esckeys
set noswapfile

"Mark the tildes as black, it's unnecessary as there are line numbers
hi NonText guifg=black ctermfg=black

"Always display the status bar
set laststatus=2

"DiffOrig command that shows the difference from the file on disk
command DiffOrig let g:diffline = line('.') | vert new | set bt=nofile | r # | 0d_ | diffthis | :exe "norm! ".g:diffline."G" | wincmd p | diffthis | wincmd p
nnoremap <Leader>do :DiffOrig<cr>
nnoremap <leader>dc :q<cr>:diffoff<cr>:exe "norm! ".g:diffline."G"<cr>

"Colors
if has('gui_running')
  colorscheme koehler
  set guifont=FreeMono\ 15
else
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
  colorscheme default
  hi Search cterm=NONE ctermfg=grey ctermbg=16
  set t_Co=256
  hi Visual cterm=NONE  ctermbg=39 ctermfg=Black
endif

hi CursorLine cterm=NONE,underline
set cursorline

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Key mappings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Tabs
noremap <C-h> gT
noremap <C-l> gt
"Scroll without moving cursor
noremap <C-j> <C-e>
noremap <C-k> <C-y>
"Jump to next/previous python function
autocmd FileType python noremap <S-j> :/^\(\s\s\s\s\)*\(class\\|def\)\s<Enter>:noh<Enter>:<Enter>w
autocmd FileType python map <S-k> :?^\(\s\s\s\s\)*\(class\\|def\)\s<Enter>:noh<Enter>:<Enter>w
"Indentation
vnoremap < <gv " better indentation
vnoremap > >gv " better indentation
nnoremap <C-c> :set cursorline!<CR>
"hjkl movement in insert mode
imap <C-h> <Left>
imap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>
"Scroll the autocompletion list
inoremap <expr> j pumvisible() ? '<C-n>' : 'j'
inoremap <expr> k pumvisible() ? '<C-p>' : 'k'
inoremap <expr> <C-d> pumvisible() ? 'j' : <C-d>
inoremap <expr> <C-u> pumvisible() ? 'j' : <C-u>
"Expanding windows when window is split
map - <C-W>-
map = <C-W>+
map _ <C-W><
map + <C-W>>
noremap Q <Nop>
"Use Tab instead of %
nnoremap <tab> %
vnoremap <tab> %
"Flake8
autocmd FileType python map <buffer> <Leader>f :call Flake8()<CR>
" Ctrl-t to open a new tab
nnoremap <C-t> :tabedit<CR>

"Use ctrl-f to put the search-replace pattern in the command line, with the
"word under the cursor as the replaced string
nnoremap <C-f> :%s/\<<C-r><C-w>\>//g<Left><Left>

"In the quickfix window, <CR> is used to jump to the error under the
"cursor, so undefine the mapping there.
autocmd BufReadPost quickfix nnoremap <buffer> <CR> <CR>

"Close the completion list below
noremap <Leader>c :ccl<Enter>

"Nerdtree
map <C-e> :NERDTreeToggle<cr>
map <Leader>e :NERDTreeFind<cr>

"Write buffer with sudo (if read only)
cmap w!! w !sudo tee % >/dev/null

"Remove search highlight
nnoremap <silent> <ENTER> :noh<cr><esc>

"Navigate to next/previous function
autocmd FileType cpp noremap <S-j> ]mzz
autocmd FileType cpp noremap <S-k> [mzz

"File explorer tree style
let g:netrw_liststyle = 3

let g:jedi#show_call_signatures = "1"
let g:jedi#use_tabs_not_buffers = 1

"Rainbow-parentheses
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

"Highlight trailing white spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()
" Show trailing whitepace and spaces before a tab:
autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\t\|\t\+ /

" Determines whether to use spaces or tabs on the current buffer.
function TabsOrSpaces()
    if getfsize(bufname("%")) > 256000
        " File is very large, just use the default.
        return
    endif

    let numTabs=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^\\t"'))
    let numSpaces=len(filter(getbufline(bufname("%"), 1, 250), 'v:val =~ "^ "'))

    if numTabs > numSpaces
        "setlocal noexpandtab
    endif
endfunction
autocmd BufReadPost * call TabsOrSpaces()
set completeopt=longest,menuone

" Scroll down in supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

hi SpellBad ctermbg=000
"hi WarningMsg ctermbg=009 ctermbg=001


"<S-Insert> in GVIM
if has("gui_running")
    map  <silent>  <S-Insert>  "+p
    imap <silent>  <S-Insert>  <Esc>"+pa
endif

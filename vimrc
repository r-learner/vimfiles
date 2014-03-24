let mapleader = " "

" Clear autocmds
autocmd!

" Use Vim settings, rather than Vi settings
" This must be first because it changes other options as a side effect
set nocompatible


" Enable file type detection and load plugin indent files
filetype plugin on
filetype plugin indent on

" Load plugins with Pathogen
"runtime core/pathogen/autoload/pathogen.vim
"execute pathogen#infect('colors/{}', 'langs/{}', 'tools/{}')
execute pathogen#infect()

" Load vimrc from current directory and disable unsafe commands in them
set exrc
set secure

" Use UTF-8 without BOM
set encoding=utf-8 nobomb

" Clear PAGER if Vim's Man function is needed
let $PAGER=''

" Directory list style
let g:netrw_liststyle=3

" Invisible characters
"set listchars=tab:▸\ ,nbsp:_
"set listchars=tab:\ \ ,trail:·,eol:¬,nbsp:_,extends:❯,precedes:❮
set listchars=tab:▸\ ,trail:·,eol:¬,nbsp:_,extends:❯,precedes:❮

" Settings for the gui version
set guifont=Monaco:h13

" ERB tags for surround
let g:surround_45 = "<% \r %>"
let g:surround_61 = "<%= \r %>"

" Don't show invisible characters (default)
set nolist

" Use only 1 space after "." when joining lines instead of 2
set nojoinspaces

" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j     
endif

" Don't reset cursor to start of line when moving around
set nostartofline

"" Autocomplete ids and classes in CSS
autocmd FileType css,scss set iskeyword=@,48-57,_,-,?,!,192-255

set runtimepath+=~/.vim.local

set background=dark
colorscheme base16-default

"" Always show the file name
set modeline
set hlsearch                    " highlight the search
set ls=2
set cursorline                  " highlight current line
set ttyfast                     " improves redrawing for newer computers
set wildmenu                    " show completion on the modeline
set linespace=0
set splitright                  " open vertical splits on the right
set splitbelow                  " open the horizontal split below
set wrap                        " wrap long lines
set nobackup                    " no backup files
set nowritebackup               " only in case you don't want a backup file while editing
set noswapfile                  " no swap files
set backupdir=~/tmp

" Time out on key codes but not mappings
set notimeout
set ttimeout
set ttimeoutlen=100

" Auto-reload buffers when files are changed on disk
set autoread

" Lines with equal indent form a fold.
set foldmethod=indent
set nofoldenable    " disable folding

set undofile                    " Save undo's after file closes
set undodir=~/.vim/undo         " where to save undo histories
set undolevels=1000             " How many undos
set undoreload=10000            " number of lines to save for undo

set number                      " line numbers
set vb                          " disable alert sound
syntax enable
syntax sync minlines=256
set showcmd                     " display incomplete commands
set history=100                 " a ton of history

" Default shell and shell syntax
set shell=bash
let g:is_bash=1

"" Whitespace
set tabstop=2 shiftwidth=2      " a tab is two spaces
set expandtab                   " use spaces, not tabs
set backspace=indent,eol,start  " backspace through everything in insert mode

"" Searching
set incsearch                   " incremental searching
set ignorecase                  " searches are case insensitive...
set smartcase                   " ... unless they contain at least one capital letter
set scrolloff=5                 " keep a 5 line padding when moving the cursor

set autoindent                  " indent on enter
set smartindent                 " do smart indenting when starting a new line
set shiftround                  " indent to the closest shiftwidth
"set switchbuf=useopen,usetab    " move focus to where the buffer is

" The "Press ENTER or type command to continue" prompt is jarring and usually unnecessary.
" You can shorten command-line text and other info tokens with, e.g.:
set shortmess=atI

" Set <c-n> and <c-p> to act like Up/Down so will filter command history
cnoremap <c-p> <up>
cnoremap <c-n> <down>

" <c-a> jumps to beginning of line to match <c-e>
cnoremap <c-a> <home>

" C-c send enter in insert mode
imap <C-c> <Esc>

cnoreabbrev W w
cnoreabbrev Q q

" Expand %% to current directory
" http://vimcasts.org/e/14
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" =============================================================================
" Filetypes and Custom Autocmds
" =============================================================================

augroup vimrcEx
  " Clear all autocmds for the current group
  autocmd!

  " Jump to last cursor position unless it's invalid or in an event handler or
  " a git commit
  au BufReadPost *
    \ if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  " Some file types use real tabs
  au FileType {make,gitconfig} set noexpandtab sw=4

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json setf javascript

  " Make Python follow PEP8
  au FileType python set sts=4 ts=4 sw=4 tw=79

  " Make sure all markdown files have the correct filetype
  au BufRead,BufNewFile *.{md,markdown,mdown,mkd,mkdn,txt} setf markdown

  " MultiMarkdown requires 4-space tabs
  au FileType markdown set sts=4 ts=4 sw=4

  " Leave the return key alone when in command line windows, since it's used
  " to run commands there
  au! CmdwinEnter * :unmap <cr>
  au! CmdwinLeave * :call MapCR()
augroup END

""
"" Status Line
""

if has("statusline") && !&cp
  set laststatus=2 " windows always have status line
  set statusline=%f\ %y\%m\%r " filename [type][modified][readonly]
  set stl+=%{fugitive#statusline()} " git via fugitive.vim
  " buffer number / buffer count
  set stl+=\[b%n/%{len(filter(range(1,bufnr('$')),'buflisted(v:val)'))}\]
  set stl+=\ %l/%L[%p%%]\,%v " line/total[%],column
endif

" Use emacs-style tab completion when selecting files, etc
set wildmode=longest,list

" Disable output and VCS files
set wildignore+=*.o,*.out,*.obj,.git,*.rbc,*.rbo,*.class,.svn,*.gem

" Disable archive files
set wildignore+=*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz

" Ignore bundler and sass cache
set wildignore+=*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*/.sass-cache/*

" Ignore rails temporary asset caches
set wildignore+=*/tmp/cache/assets/*/sprockets/*,*/tmp/cache/assets/*/sass/*

" Ignore node modules
set wildignore+=node_modules/*

" Disable temp and backup files
set wildignore+=*.swp,*~,._*

let g:ctrlp_working_path_mode = 0
let g:ctrlp_clear_cache_on_exit = 0
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\.git\|bin$\|\.hg\|\.svn\|build\|log\|resources\|coverage\|doc\|tmp\|public/assets\|vendor\|Android',
  \ 'file': '\.jpg$\|\.exe$\|\.so$\|\.dll$'
  \ }

" Will allow you to use :w!! to write to a file using sudo if you
" forgot to sudo vim file (it will prompt for sudo password when writing)
cmap w!! %!sudo tee > /dev/null %

" Visually select the text that was last edited/pasted
nmap gV `[v`]

nmap Y y$

" close the buffer but not it's window
nnoremap <C-c> :bp\|bd #<cr>

" reselect visual block after indent/outdent
vnoremap < <gv
vnoremap > >gv

map <leader>a :Ack! 

" buffer navigation
nnoremap <leader>n :tabnext<cr>
nnoremap <leader>p :tabprevious<cr>
nnoremap <leader>t :tabnew<cr>
nnoremap <leader>c :tabclose<cr>

" Move between splits
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

inoremap kj <Esc>

nnoremap <leader><leader> :b#<cr>

map <C-b> :CtrlPBuffer<cr>
nmap <leader>V :e ~/.vimrc<cr>

" open diffs in a new tab
nmap __ :tabedit %<CR>:Gdiff<CR>

nnoremap <leader>f :e <C-R>=expand('%:h').'/'<CR>

" Use a nicer error sign
let g:syntastic_error_symbol = '→'
let g:syntastic_warning_symbol = '→'

" Fix the difficult-to-read default setting for diff text highlighting.  The
" bang (!) is required since we are overwriting the DiffText setting. The highlighting
" for "Todo" also looks nice (yellow) if you don't like the "MatchParen" colors.
highlight! link DiffText MatchParen

" clear those nasty fugitive buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

" set haml filetype on weird extensions
autocmd BufRead,BufNewFile *.hamljs set filetype=haml

" quickfix window height is automatically adjusted to fit its contents
au FileType qf call AdjustWindowHeight(3, 15)
function! AdjustWindowHeight(minheight, maxheight)
  exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
endfunction

command! TagFiles :call EchoTags()
function! EchoTags()
  echo join(split(&tags, ","), "\n")
endfunction

" tmux will only forward escape sequences to the terminal if surrounded by a DCS sequence
" http://sourceforge.net/mailarchive/forum.php?thread_name=AANLkTinkbdoZ8eNR1X2UobLTeww1jFrvfJxTMfKSq-L%2B%40mail.gmail.com&forum_name=tmux-users
 
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
  let &t_SI = "\<Esc>]50;CursorShape=1\x7"
  let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Run tests using vimux
let g:VimuxHeight = "45"
let g:VimuxOrientation = "h"
let g:vroom_use_vimux = 1
let g:vroom_use_spring = 0
let g:vroom_use_binstubs = 0
let g:vroom_map_keys = 0
let g:vroom_cucumber_path = "cucumber"
nmap <leader>r :VroomRunNearestTest<cr>
nmap <leader>R :VroomRunTestFile<cr>

" Disable mappings from vim-ruby-refactoring
let g:ruby_refactoring_map_keys=0

" use pandoc to clean up html code (with `gq`)
function! FormatprgLocal(filter)
  if !empty(v:char)
    return 1
  else
    let l:command = v:lnum.','.(v:lnum+v:count-1).'!'.a:filter
    echo l:command
    execute l:command
  endif
endfunction
 
if has("autocmd")
  let pandoc_pipeline  = "pandoc --from=html --to=markdown"
  let pandoc_pipeline .= " | pandoc --from=markdown --to=html"
  autocmd FileType html setlocal formatexpr=FormatprgLocal(pandoc_pipeline)
endif

" airline unicode symbols
let g:airline_left_sep = '»'
let g:airline_right_sep = '«'

highlight DiffAdd cterm=none ctermfg=fg ctermbg=112 gui=none guifg=bg guibg=#87d700
highlight DiffDelete cterm=none ctermfg=fg ctermbg=160 gui=none guifg=fg guibg=#d70000
highlight DiffChange cterm=none ctermfg=fg ctermbg=100 gui=none guifg=fg guibg=#878700
highlight DiffText cterm=none ctermfg=010 ctermbg=112 gui=none guifg=#00f00 guibg=#87d700

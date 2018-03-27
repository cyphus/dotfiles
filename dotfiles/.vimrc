" All plugins managed using git submodules and added using pathogen,
" which is a submodule itself.
runtime bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()

set nocp " turn off vi compatibility
set number " show what line I'm on
set relativenumber " show relative line numbers
set mouse=a " support the mouse even in the terminal

" enable resizing splits with mouse from inside a tmux session
if &term =~ '^screen'
    set ttymouse=xterm2
endif

syntax on " Set syntax on
" Don't flag curly braces inside parenthesis (i.e. C++11 lambda) as error
let c_no_curly_error=1

" Indent automatically depending on filetype
set sts=4 ts=4 sw=4 expandtab
filetype plugin indent on
set autoindent
set backspace=2 " Fixes some backspace problems on NixOS

" Remove comment leader when joining comment lines
set formatoptions+=j
" Only auto wrap lines if line exceeds textwidth during current insert
set formatoptions+=b
" Allow auto formatting of comments with gq/gw
set formatoptions+=q

set tw=79 " Wrap lines longer than 79 characters
set cc=+1 " highlight vertical column at textwidth + 1

set hidden " Allow for switching buffers without saving

set dir=~/tmp " Save swap files under ~/tmp

set lazyredraw " Don't update display while executing macros

" Smart case search
set ic
set smartcase
set incsearch " incremental search

" Tab-complete the longest prefix common to all matches, then tab again will
" provide a list, and further tabs will cycle through completion options.
set wildmode=longest,list,full
set wildmenu " show menu for list and full expansions

set hls " Higlhight search

set lbr " Wrap text visually (does not insert '\n') (lbr|nolbr)

colorscheme molokai
" attempt to make molokai colors in terminal version match those in GUI version
let g:rehash256 = 1

if has("gui_running")
    " I'm not a fan of the toolbar I never use stealing screen real estate
    set guioptions=ac
    if has("gui_gtk2")
        set guifont=Terminus\ 9
    elseif has("gui_win32")
        set guifont=Envy\ Code\ R:h10:w6
    endif
endif

" custom commands

" command to change all indentation-related values simultaneously
fun! SetTabWidth( width ) "{{{
    execute "setlocal sts=".a:width." ts=".a:width." sw=".a:width
endfunction "}}}

command! -nargs=* SetTabWidth call SetTabWidth( '<args>' )

" map leader key to space bar
let mapleader=" "

" build a project. Only useful if makeprg is set
nmap <leader>r :make<CR>

" Toggle highlight search
nmap <silent> <leader>h :set invhls<CR>

" Remove trailing whitespace
nmap <silent> <leader>w :%s/\s\+$<CR>

" Toggle paste mode
nmap <silent> <leader>p :set invpaste<CR>

" You complete me plugin settings

let g:ycm_extra_conf_globlist = [ '~/projects/*', '!~/*' ]
let g:ycm_add_preview_to_completeopt = 1

" Map UltiSnips to Ctrl+k
let g:UltiSnipsExpandTrigger="<c-k>"
let g:UltiSnipsJumpForwardTrigger="<c-k>"
let g:UltiSnipsJumpBackwardTrigger="<s-c-j>"

" CtrlP plugin settings

" Ignore files that are also ignored by git:
let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']

" search in Files, Buffers and MRU files at the same time.
let g:ctrlp_cmd = 'CtrlPMixed'

" turn off working path detection and just use vim's cwd
let g:ctrlp_working_path_mode = 0

" Airline plugin settings

" show statusline even when there are no splits
set laststatus=2
" use powerline patched font symbols
let g:airline_powerline_fonts = 1
" Set the timeout for waiting for another key to be pressed in milliseconds.
" This prevents a noticeable delay after hitting ESC to leave insert mode.
set ttimeoutlen=7
" Let vim-airline set the tabline when there are no tabs
let g:airline#extensions#tabline#enabled = 1

" waf syntax
au BufNewFile,BufRead wscript set filetype=python

" ALE (asynchronous lint engine) settings
let g:ale_sign_error = 'E'
let g:ale_sign_warning = 'w'

" ALE goto next warning/error (with wrap around to start of file if necessary)
nmap <silent> <leader>e <Plug>(ale_next_wrap)

" vim-jsx-pretty settings

let g:vim_jsx_pretty_colorful_config = 1 " requires vim-javascript

" easy-align settings

" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)
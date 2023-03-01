"------------------------------------------------------------
" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

"------------------------------------------------------------
" From Caleb's .vimrc
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin()

" Smooth scroll
Plug 'psliwka/vim-smoothie'

" Gruvbox
"Plug 'morhetz/gruvbox'

" .editorconfig file support
"Plug 'editorconfig/editorconfig-vim'

" Initialize plugin system
call plug#end()

"------------------------------------------------------------
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
if has('filetype')
  filetype indent plugin on
endif

" Enable syntax highlighting
if has('syntax')
  syntax on
endif

" Better command-line completion
set wildmenu

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

""" make search case-insensitive by default
nnoremap / /\c
vnoremap / /\c

"""highlight search matches while searching
set incsearch

"------------------------------------------------------------
" If you are paranoid about security vulnerabilities, uncomment the below line
" to avoid modelines, which have historically been a source of security
" vulnerabilities
" set nomodeline


"------------------------------------------------------------
" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Always display the status line, even if only one window is displayed
set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F11>


"------------------------------------------------------------
"""Tabs and Indenting
set scrolloff=8
set softtabstop=4
"set copyindent
set tabstop=4
set expandtab
set shiftwidth=4

"""File Format
set ff=unix

inoremap # X<BS>#

"""Powerline Settings
set nocompatible
set laststatus=2
set encoding=utf-8

"""Code Folding
set foldmethod=manual
set foldnestmax=10
set nofoldenable
set foldlevel=1

"""Color scheme
color ron

"""Color the 80th col
set t_Co=256

"""80 Columns
highlight ColorColumn ctermbg=DarkGray
set cc=80

let g:indentLine_color_term = 239
let g:syntastic_enable_highlighting = 0

""" automatically remove trailing whitespace
autocmd BufWritePre * :%s/\s\+$//e

"""Hybrid Lines
set number relativenumber
set nu rnu

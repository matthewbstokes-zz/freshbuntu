set nocompatible
set nocompatible
set number
set ruler
set backspace=indent,eol,start
set autoindent
set backup
set backupdir=~/.vim/backups
set history=100
set showcmd
set showmode
set incsearch
syntax on
set hlsearch
filetype plugin indent on
set wrap
set background=dark
set wrapscan
set mouse=a

set tabstop=2
set shiftwidth=2
set expandtab

set nospell

let &printexpr="(v:cmdarg=='' ? ".
    \"system('lpr' . (&printdevice == '' ? '' : ' -P' . &printdevice)".
    \". ' ' . v:fname_in) . delete(v:fname_in) + v:shell_error".
    \" : system('mv '.v:fname_in.' '.v:cmdarg) + v:shell_error)"

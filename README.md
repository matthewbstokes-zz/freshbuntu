freshBuntu
==========

What to do when you have a fresh install of Ubuntu. Note this will become a script in the near future.

Chrome
==========
`sudo apt-get install google-chrome-stable`


GitHub Key Pair
==========
https://help.github.com/articles/generating-ssh-keys

SSH Client and Server
==========
`sudo apt-get install openssh-client`

`sudo apt-get install openssh-server`

Disable SSH password login
-----------
Change the line (51) `#PasswordAuthentication yes` to `PasswordAuthentication no`

Git
==========
`sudo apt-get install git`

`git config --global user.name "Your Name"`

`git config --global user.email you@example.com`

FileZilla
==========
`sudo apt-get install filezilla`

DropBox
==========
https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_1.6.0_amd64.deb

Remove Sudo Password Prompt
==========
`sudo visudo`

Change the line (25) `%sudo ALL=(ALL) ALL` to `%sudo ALL=(ALL) NOPASSWD: ALL`

BashRC Prompt
===========
http://bashrcgenerator.com/

`export PS1="\[\e[00;31m\]\A\[\e[0m\]\[\e[00;37m\] [\w] : @\[\e[0m\]"`

Linux Terminal
===========
Background Tab - ~50% Transparent background

Color Tab: 

![alt text](https://raw.githubusercontent.com//mstokes5/freshBuntu/master/images/color.png "Terminal Color Tab")

Terminal: 

![alt text](https://raw.githubusercontent.com//mstokes5/freshBuntu/master/images/term.png "Terminal Color Tab")

Gimp
===========
`sudo apt-get install gimp`

Bash Aliases
===========
`vim ~/.bash_aliases`

```alias get='sudo apt-get install```

VLC
============
`sudo apt-get install vlc`

Folder Bookmarks and ShortCuts
============

Bookmarks at the begining:
![alt text](https://raw.githubusercontent.com//mstokes5/freshBuntu/master/images/book_start.png "Before")

Added bookmarks, and setup links for Music, Pictures, etc. to DropBox folders:
![alt text](https://raw.githubusercontent.com//mstokes5/freshBuntu/master/images/book_after.png "After")

Pip
============
`sudo apt-get install python-pip`

Virtualenv and Wrapper
============
http://roundhere.net/journal/virtualenv-ubuntu-12-10/

Postgres
============
https://www.digitalocean.com/community/articles/how-to-install-and-use-postgresql-on-ubuntu-12-04

And also: `sudo apt-get install libpq-dev`

MakerWare
============
http://www.makerbot.com/support/makerware/documentation/linux-install/

Python Dev
============
`sudo apt-get install python-dev`

Pgadmin3
============
`sudo apt-get install pgadmin3`

Private Internet Access
=============
https://www.privateinternetaccess.com/pages/client-support/#ubuntu_openvpn_installer

Heroku
=============
https://toolbelt.heroku.com/debian

`wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh`

Heroku Vim
-------------
`heroku plugins:install https://github.com/naaman/heroku-vim`

Google Voice
==============
https://www.google.com/tools/dlpage/hangoutplugin/thankyou.html?platform=linux_ubuntu_x86_64

Vimrc
==============
```sh
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

```

Disable Ubuntu Guest Session
===================
`gksu gedit /etc/lightdm/lightdm.conf`

Append the following `allow-guest=false`


freshBuntu
==========

What to do when you have a fresh install of Ubuntu 12.04

Instructions
=============
download or clone the repo and run the script `./freshBuntu_install.sh`

Packages Included
=============
Feel free to add/modify this script and add any of your own packages as you see fit. Currently the following packages will be installed:

* Google Chrome
* SSH Client
* SSH Server
* Git
* Filezilla
* DropBox
* Gimp
* VLC
* Pip
* Virtualenv (set to ~/.virtualenvs)
* Virtualenvwrapper
* Postgres
* Makerware
* Pgadmin3
* PrivateInternetAccess
* Heroku
* Python-dev
* Wireshark
* VirtualBox
* Tree

Configurations
==============
* Disabled SSH password login for added security. Requires id_rsa.pub of remote pcs to be in authenticated_keys
* More userful bashrc prompt
* Git prompts to config with your name and email
* Bash aliases for get, and back
* .vimrc file as provided
* Disabled guest session

Upon Completion
=============
Upon the scripts completion your id_rsa.pub key should be copied to your xclip board. You should go into github and paste this into your ssh keys section.

freshBuntu
==========

What to do when you have a fresh install of Ubuntu 12.04.

Instructions
=============
You may be prompted multiple times to enter your root password during the install. It is recommended that before you run the install script you remote the sudo password prompt via `sudo visudo` and changing line (25):

`%sudo ALL=(ALL) ALL`

to

`%sudo ALL=(ALL) NOPASSWD: ALL`

Next, download or clone the repo and run the script: `./freshBuntu_install.sh`. 
Packages Included
=============
Feel free to fork and add your own packages to this script. Currently the following will be installed:

* DropBox
* Filezilla
* Gimp
* Git
* Google Chrome
* Heroku
* Makerware
* Pgadmin3
* Pip
* Postgres
* PrivateInternetAccess
* Python-dev
* SSH Client
* SSH Server
* Tree
* VirtualBox
* Virtualenv (set to ~/.virtualenvs)
* Virtualenvwrapper
* VLC
* Wireshark


Configurations
==============
Additional to installing packages the following configuration settings will be modified:

* Disabled SSH password login for added security. Requires id_rsa.pub of remote pcs to be in authenticated_keys
* More userful bashrc prompt
* Bash aliases for get, and back
* .vimrc file as provided
* Git prompts to config with your name and email

During Install
==============
During install you will have the following prompts:

Git
--------------
* git user.name
* git user.email

Private Internet Access
---------------
This is for the VPN. If you dont have an account just click enter, else enter your id

SSH Pub Key
---------------
You may choose to modify where to save the `id_rsa` and whether or not to add a passphrase. You can also just click enter through these screens to use the default location and no passphrase.

```sh
Enter file in which to save the key (/home/you/.ssh/id_rsa):
Enter passphrase (empty for no passphrase): [Type a passphrase]
# Enter same passphrase again: [Type passphrase again]

```


Upon Completion
=============
* Your id_rsa.pub key should be copied to your xclipboard. You should go into github and paste this into your ssh keys section.
* Create a new database in postgres using `su - postgres`. More can be seen via the following link https://www.digitalocean.com/community/articles/how-to-install-and-use-postgresql-on-ubuntu-12-04
* Consider disabling guest login as an extra means of security via appending `allow-guest=false` to `gksu gedit /etc/lightdm/lightdm.conf`
* Create a new virtualenv using `mkvirtualenv myawesomeproject`

Future Additions
==============
* Selenium
* Tor
* OpenCV
* Reaver
* Airomon

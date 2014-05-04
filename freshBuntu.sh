#!/bin/sh

# update
sudo apt-get update
sudo apt-get upgrade

###############################################################################
# install
###############################################################################
sudo apt-get install google-chrome-stable # google chrome
sudo apt-get install openssh-client # ssh client
sudo apt-get install openssh-server # ssh server
sudo apt-get install git # git
sudo apt-get install filezilla # filezilla
sudo apt-get install gimp # gimp
sudo apt-get install vlc # vlc
sudo apt-get install python-pip # pip
sudo apt-get install python-dev # python dev
sudo apt-get install wireshark # wireshark
sudo apt-get install tree # tree
sudo apt-get install xclip # xclip
sudo apt-get install libpq-dev # req for postgres
sudo apt-get install postgresql postgresql-contrib # postgres
sudo apt-get install pgadmin3 # pgadmin
sudo apt-get install network-manager-openvpn # for pia

sudo pip install virtualenv # virtual env
sudo pip install virtualenvwrapper # wrapper

wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh # heroku

###############################################################################
# config
###############################################################################

# disable ssh password login
sudo sed -i 's/\bPasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/\bRSAAuthentication yes/RSAAuthentication no/' /etc/ssh/sshd_config
sudo sed -i 's/\bPubkeyAuthentication no/PubkeyAuthentication yes/' /etc/ssh/sshd_config
sudo sed -i 's/\b#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config

# virtual env
mkdir $HOME/.virtualenvs
export WORKON_HOME=$HOME/.virtualenvs
echo ". /usr/local/bin/virtualenvwrapper.sh" >> $HOME/.bashrc

 #http://bashrcgenerator.com/
echo 'export PS1="\[\e[00;31m\]\A\[\e[0m\]\[\e[00;37m\] [\w] : @\[\e[0m\]"' >> $HOME/.bashrc

# bash_aliases
touch $HOME/.bash_aliases
echo "alias get='sudo apt-get install'" >> $HOME/.bash_aliases

# guest session
sudo echo 'allow-guest=false' >> /etc/lightdm/lightdm.conf

# vimrc
mv .vimrc $HOME/.vimrc

# git
echo "Enter your github user.name\n"
read git_name
git config --global user.name $git_name
echo "Enter your github user.email\n"
read git_email
git config --global user.email $git_email

# privateinternetaccess
cd /tmp/ && wget https://www.privateinternetaccess.com/installer/install_ubuntu.sh && chmod 777 ./install_ubuntu.sh && sudo ./install_ubuntu.sh


# ssh key-gen
touch $HOME/.ssh
cd $HOME/.ssh && ssh-keygen -t rsa
ssh-add $HOME/.ssh/id_rsa
xclip -sel clip < $HOME/.ssh/id_rsa.pub # copy to clipboard

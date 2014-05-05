#!/bin/sh

# update
sudo apt-get update
sudo apt-get upgrade

###############################################################################
# install
###############################################################################
sudo apt-get -y install openssh-client # ssh client
sudo apt-get -y install openssh-server # ssh server
sudo apt-get -y install git # git
sudo apt-get -y install filezilla # filezilla
sudo apt-get -y install gimp # gimp
sudo apt-get -y install vlc # vlc
sudo apt-get -y install python-pip # pip
sudo apt-get -y install python-dev # python dev
sudo apt-get -y install wireshark # wireshark
sudo apt-get -y install tree # tree
sudo apt-get -y install xclip # xclip
sudo apt-get -y install libpq-dev # req for postgres
sudo apt-get -y install postgresql postgresql-contrib # postgres
sudo apt-get -y install pgadmin3 # pgadmin
sudo apt-get -y install network-manager-openvpn # for PIA
sudo apt-get -y install libxss1 # for chrome
sudo apt-get -y install vim # te

sudo pip install virtualenv # virtual env
sudo pip install virtualenvwrapper # wrapper

wget https://toolbelt.heroku.com/install-ubuntu.sh | sh # heroku

###############################################################################
# makerware
###############################################################################
sudo apt-add-repository 'deb http://downloads.makerbot.com/makerware/ubuntu precise main'
cd /tmp/ && wget http://downloads.makerbot.com/makerware/ubuntu/dev@makerbot.com.gpg.key
sudo apt-key add /tmp/dev@makerbot.com.gpg.key 
sudo apt-get update
sudo apt-get -y install makerware


###############################################################################
# Architecture Specific .debs
###############################################################################
architecture=`uname -m`
case "$architecture" in 

#64
x86_64) echo "64-Bit Architecture"
        cd /tmp/ && wget https://linux.dropbox.com/packages/ubuntu/dropbox_1.6.2_amd64.deb
        cd /tmp/ && sudo dpkg --install dropbox_1.6.2_amd64.deb

        # chrome
        cd /tmp/ && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
        cd /tmp/ && duso dpkg --install google-chrome-stable_current_amd64.deb
        ;;

#32 / default
*)      echo "32-Bit Architecture"

        # dropbox
        cd /tmp/ && wget https://linux.dropbox.com/packages/ubuntu/dropbox_1.6.2_i386.deb
        cd /tmp/ && sudo dpkg --install dropbox_1.6.2_i386.deb

        # chrome
        cd /tmp/ && wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb 
        cd /tmp/ && sudo dpkg --install google-chrome-stable_current_i386.deb
        ;;

esac

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
v_wrap=". /usr/local/bin/virtualenvwrapper.sh"

if grep -Fxq "$v_wrap" $HOME/.bashrc
then
  echo "virtualenv has already been created"
else
  export WORKON_HOME=$HOME/.virtualenvs
  echo $v_wrap >> $HOME/.bashrc
fi

 #http://bashrcgenerator.com/
$rc_prompt='export PS1="\[\e[00;31m\]\t\[\e[0m\]\[\e[00;37m\] [\w] :\[\e[0m\]"'
if grep -Fxq "$rc_prompt" $HOME/.bashrc
then
  echo ".bashrc prompt already generated"
else
  echo $rc_prompt >> $HOME/.bashrc
fi

# bash_aliases
touch $HOME/.bash_aliases
$get="alias get='sudo apt-get install'"
if grep -Fxq "$get" $HOME/.bash_aliases
then
  echo "bash_aliases already created"
else
  echo $get >> $HOME/.bash_aliases
  echo "alias back='cd...'" >> $HOME/.bash_aliases
fi

# vimrc
touch $HOME/.vimrc
dir_path=$(dirname $0)
sudo cp $dir_path/.vimrc $HOME/.vimrc

# git
echo "Enter your github user.name"
read git_name
git config --global user.name $git_name
echo "Enter your github user.email"
read git_email
git config --global user.email $git_email

# privateinternetaccess
cd /tmp/ && wget https://www.privateinternetaccess.com/installer/install_ubuntu.sh && chmod 777 ./install_ubuntu.sh && sudo ./install_ubuntu.sh

# ssh key-gen for git
# paste in github host keys
mkdir $HOME/.ssh
cd $HOME/.ssh && ssh-keygen -t rsa
ssh-add $HOME/.ssh/id_rsa
xclip -sel clip < $HOME/.ssh/id_rsa.pub # copy to clipboard

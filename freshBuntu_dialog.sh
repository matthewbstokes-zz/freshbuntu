#!/bin/bash
debInst() {
  dpkg-query -Wf'${db:Status-abbrev}' "${1}" 2>/dev/null | grep -q '^i'
}

# requires dialog to choose packages
if !debInst dialog; then
  sudo apt-get -y install dialog
fi

architecture=`uname -m`
checklist_file=/tmp/freshbuntu_checklist.txt

# dialog call
dialog --checklist "Choose Packages/Config to Install" 0 80 0 \
  Bash-rc 'config' on \
  Bash-aliases 'config' on \
  Dropbox '.deb' on \
  Filezilla 'sudu-apt-get' on \
  Gimp 'sudu-apt-get' on \
  Git 'sudu-apt-get' on \
  Google-Chrome '.deb' on \
  Heroku '.sh' on \
  Makerware 'custom' on \
  Pgadmin3 'sudu-apt-get' on \
  Pip 'sudo-apt-get' on \
  Postgres 'sudo-apt-get' on \
  Private-Internet-Access 'sudo-apt-get' on \
  Python-dev 'sudo-apt-get' on \
  SSH-Client 'sudo-apt-get' on \
  SSH-Server 'sudo-apt-get' on \
  Tree 'sudo-apt-get' on \
  Vim 'sudo-apt-get' on \
  Virtualenv 'pip' on \
  Virtualenvwrapper 'pip' on \
  VLC 'sudo-apt-get' on \
  Wireshark 'sudo-apt-get' on \
  2> $checklist_file

file_string=`cat $checklist_file`
programs=(${file_string// / })

# pre-case programs check/organization/ordering

# installation
for i in "${programs[@]}"
do
  program=`echo $i | cut -d "\"" -f 2`

  # check if already installed
  if debInst $program; then
    continue
  fi

  case $program in

    Bash-rc)
      $rc_prompt='export PS1="\[\e[00;31m\]\t\[\e[0m\]\[\e[00;37m\] [\w] :\[\e[0m\]"'
      if grep -Fxq "$rc_prompt" $HOME/.bashrc
      then
        echo ".bashrc prompt already generated"
      else
        echo $rc_prompt >> $HOME/.bashrc
      fi
      ;;

    Bash-aliases)
      touch $HOME/.bash_aliases
      $get="alias get='sudo apt-get install'"
      if grep -Fxq "$get" $HOME/.bash_aliases
      then
        echo "bash_aliases already created"
      else
        echo $get >> $HOME/.bash_aliases
        echo "alias back='cd...'" >> $HOME/.bash_aliases
      fi
      ;;

    Dropbox)
      case "$architecture" in 
      x86_64) echo "64-Bit Architecture"
        cd /tmp/ && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
        cd /tmp/ && duso dpkg --install google-chrome-stable_current_amd64.deb
        ;;
      *)      echo "32-Bit Architecture"
        cd /tmp/ && wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb 
        cd /tmp/ && sudo dpkg --install google-chrome-stable_current_i386.deb
        ;;
      esac
      ;;

    Filezilla)
      sudo apt-get -y install filezilla
      ;;

    Gimp)
      sudo apt-get -y install gimp
      ;;

    Git)
      sudo apt-get -y install git
      echo "Enter your github user.name"
      read git_name
      git config --global user.name $git_name
      echo "Enter your github user.email"
      read git_email
      git config --global user.email $git_email

      sudo apt-get -y install xclip
      mkdir $HOME/.ssh
      cd $HOME/.ssh && ssh-keygen -t rsa
      ssh-add $HOME/.ssh/id_rsa
      xclip -sel clip < $HOME/.ssh/id_rsa.pub # copy to clipboard
      ;;

    Google-Chrome)
      sudo apt-get -y install libxss1
      case "$architecture" in 
        x86_64) echo "64-Bit Architecture"
          cd /tmp/ && wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb 
          cd /tmp/ && duso dpkg --install google-chrome-stable_current_amd64.deb
          ;;
        *)      echo "32-Bit Architecture"
          cd /tmp/ && wget https://dl.google.com/linux/direct/google-chrome-stable_current_i386.deb 
          cd /tmp/ && sudo dpkg --install google-chrome-stable_current_i386.deb
          ;;
      esac
      ;;
    
    Heroku)
      wget https://toolbelt.heroku.com/install-ubuntu.sh | sh # heroku
      ;;

    Makerware)
      sudo apt-add-repository 'deb http://downloads.makerbot.com/makerware/ubuntu precise main'
      cd /tmp/ && wget http://downloads.makerbot.com/makerware/ubuntu/dev@makerbot.com.gpg.key
      sudo apt-key add /tmp/dev@makerbot.com.gpg.key 
      sudo apt-get update
      sudo apt-get -y install makerware
      ;;

    Pgadmin3)
      sudo apt-get -y install pgadmin3
      ;;

    Pip)
      sudo apt-get -y install python-pip
      ;;

    Postgres)
      sudo apt-get -y install libpq-dev
      sudo apt-get -y install postgresql postgresql-contrib
      ;;

    Private-Internet-Access)
      sudo apt-get -y install network-manager-openvpn
      cd /tmp/ && wget https://www.privateinternetaccess.com/installer/install_ubuntu.sh && chmod 777 ./install_ubuntu.sh && sudo ./install_ubuntu.sh
      ;;

    Python-dev)
      sudo apt-get -y install python-dev
      ;;

    SSH-Client)
      sudo apt-get -y install openssh-client
      ;;

    SSH-Server)
      sudo apt-get -y install openssh-server
      sudo sed -i 's/\bPasswordAuthentication no/PasswordAuthentication yes/' /etc/ssh/sshd_config
      sudo sed -i 's/\bRSAAuthentication yes/RSAAuthentication no/' /etc/ssh/sshd_config
      sudo sed -i 's/\bPubkeyAuthentication no/PubkeyAuthentication yes/' /etc/ssh/sshd_config
      sudo sed -i 's/\b#AuthorizedKeysFile/AuthorizedKeysFile/' /etc/ssh/sshd_config
      ;;

    Tree)
      sudo apt-get -y install tree
      ;;

    Vim)
      sudo apt-get -y install vim
      touch $HOME/.vimrc
      dir_path=$(dirname $0)
      sudo cp $dir_path/.vimrc $HOME/.vimrc
      ;;

    Virtualenv)
      sudo pip install virtualenv
      ;;

    Virtualenvwrapper)
      sudo pip install virtualenvwrapper
      mkdir $HOME/.virtualenvs
      v_wrap=". /usr/local/bin/virtualenvwrapper.sh"

      if grep -Fxq "$v_wrap" $HOME/.bashrc
      then
        echo "virtualenv has already been created"
      else
        export WORKON_HOME=$HOME/.virtualenvs
        echo $v_wrap >> $HOME/.bashrc
      fi
      ;;

    VLC)
      sudo apt-get -y install vlc
      ;;

    Wireshark)
      sudo apt-get -y install wireshark
      ;;

  esac      
done

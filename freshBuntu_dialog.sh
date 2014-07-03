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
  OpenCV 'custom' on \
  Pgadmin3 'sudu-apt-get' on \
  Pip 'sudo-apt-get' on \
  Postgres 'sudo-apt-get' on \
  Private-Internet-Access 'sudo-apt-get' on \
  Python-dev 'sudo-apt-get' on \
  Reaver 'sudo-apt-get' on \
  Selenium 'pip' on \
  SSH-Client 'sudo-apt-get' on \
  SSH-Server 'sudo-apt-get' on \
  Tree 'sudo-apt-get' on \
  Vim 'sudo-apt-get' on \
  Virtualenv 'pip' on \
  Virtualenvwrapper 'pip' on \
  VLC 'sudo-apt-get' on \
  Wireshark 'sudo-apt-get' on \
  X-Virtual-Framebuffer 'sudo-apt-get' on \
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
      cd /tmp/ && wget https://toolbelt.heroku.com/install-ubuntu.sh | sh
      ;;

    LaTex)
      cd /tmp/ && wget https://github.com/scottkosty/install-tl-ubuntu/raw/master/install-tl-ubuntu && chmod +x ./install-tl-ubuntu
      sudo ./install-tl-ubuntu
      ;;

    Makerware)
      sudo apt-add-repository 'deb http://downloads.makerbot.com/makerware/ubuntu precise main'
      cd /tmp/ && wget http://downloads.makerbot.com/makerware/ubuntu/dev@makerbot.com.gpg.key
      sudo apt-key add /tmp/dev@makerbot.com.gpg.key 
      sudo apt-get update
      sudo apt-get -y install makerware
      ;;

    OpenCV)
      version="$(wget -q -O - http://sourceforge.net/projects/opencvlibrary/files/opencv-unix | egrep -m1 -o '\"[0-9](\.[0-9])+' | cut -c2-)"
      mkdir ~/Documents/OpenCV
      cd ~/Documents/OpenCV
      sudo apt-get -qq remove ffmpeg x264 libx264-dev
      sudo apt-get -qq install libopencv-dev build-essential checkinstall cmake pkg-config yasm libjpeg-dev libjasper-dev libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libv4l-dev python-dev python-numpy libtbb-dev libqt4-dev libgtk2.0-dev libfaac-dev libmp3lame-dev libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev x264 v4l-utils ffmpeg
      wget -O OpenCV-$version.zip http://sourceforge.net/projects/opencvlibrary/files/opencv-unix/$version/opencv-"$version".zip/download
      unzip OpenCV-$version.zip
      cd opencv-$version
      mkdir build
      cd build
      cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D INSTALL_PYTHON_EXAMPLES=ON -D BUILD_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON ..
      make -j2
      sudo checkinstall
      sudo sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
      sudo ldconfig
      chmod +x opencv.sh
      sh opencv.sh
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

    Reaver)
      sudo add-apt-repository -y ppa:pi-rho/security
      sudo apt-get update
      sudo apt-get install -y aircrack-ng reaver
      ;;

    Selenium)
      sudo pip install -U selenium
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

    Tor)
      sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 886DDD89
      sudo add-apt-repository "deb http://deb.torproject.org/torproject.org $(lsb_release -s -c) main"
      sudo apt-get update && sudo apt-get -y install tor-geoipdb
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

    X-Virtual-Framebuffer)
      sudo apt-get install xvfb python-pip
      sudo pip install pyvirtualdisplay
      ;;

  esac      
done

#!/bin/bash
#misc functions
function valUSRnEMAIL()
{
    if [[ $2 == *"@"* ]] && [[ $2 == *"."* ]]; then
        echo "email Seems valid"
    else
        fail "validate email"
    fi
    
    return 0
}

function fail()
{
    echo "The script failed while trying to: $1"
    exit
}
#setup remote repository functions
function setupgithub()
{
    echo "host github.com">>~/.ssh/config
    echo " HostName github.com">>~/.ssh/config
    echo " IdentityFile ~/.ssh/id_rsa_github">>~/.ssh/config
    echo " User git">>~/.ssh/config   
    ssh-keygen -f ~/.ssh/id_rsa_github -t rsa -b 4096 -C "$email" -N "" > /dev/null
    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa_github > /dev/null
    echo "paste the following public key into your githup ssh keys:"
    echo "#########################################################"
    cat ~/.ssh/id_rsa_github.pub
    echo "#########################################################"
}

function setuppythondev()
{

    sudo apt-get install -y vim-nox > /dev/null
    sudo apt-get install -y make build-essential libssl-dev zlib1g-dev libbz2-dev \
	libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev libncursesw5-dev \
	xz-utils tk-dev > /dev/null
    git clone https://github.com/pyenv/pyenv.git ~/.pyenv
    . $HOME/.profile
    . $HOME/.bash_profile
    git clone https://github.com/pyenv/pyenv-virtualenv.git $(pyenv root)/plugins/pyenv-virtualenv
}

function setupvimplugins()
{
    cd ~
    git init
    git remote add origin master git@github.com:dazz22/homedir.git
    git submodule update --init
}
#####################BEGIN SCRIPT###########################
#validate username and email
if [ "${#1}" -gt 0 ] && [ "${#2}" -gt 0 ] ; then
    fullname="$1"
    email="$2"
else
    echo "User details were not entered as command arguments"
    read -p "Enter fullname: " fullname
    read -p "Enter email address: " email
fi
valUSRnEMAIL "$fullname" "$email"

#Setup git
sudo apt-get install git -y > /dev/null
cd ~
git config --global user.email "$email"
git config --global user.name "$fullname"
git clone https://github.com/dazz22/homedir.git > /dev/null

#Setup connection to remote repository
echo "creating github ssh keys"
setupgithub

#Setup python env
#setup dot files
echo "setting up machine for python devleopment"
mv ~/homedir/.v* ~/
mv ~/homedir/.b* ~/
mv ~/homedir/.g* ~/
mv ~/homedir/.i* ~/
setupvimplugins
setuppythondev

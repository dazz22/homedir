# homedir
This is when I install a new version of ubuntu so that my vim and utilities are set up consistently on each workstation.

sudo apt-get install git -y
cd ~

git config --global user.email "email@domain.com"
git config --global user.name "Your Name"
git clone https://github.com/dazz22/homedir.git
rm .vimrc
mv ~/homedir/.v* ~/
mv ~/homedir/.b* ~/
mv ~/homedir/.g* ~/
mv ~/homedir/.i* ~/

ssh-keygen -t rsa -b 4096 -C "email@domain.com"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa_github
sudo apt-get install xclip
xclip -sel clip <~/.ssh/id_rsa_github.pub

Paste the public key into ssh keys in github

git remote add homedir ssh://git@github.com/username/homedir.git
sudo apt-install vim-nox
vi .ssh/config

host github.com
 HostName github.com
 IdentityFile ~/.ssh/id_rsa_github
 User git


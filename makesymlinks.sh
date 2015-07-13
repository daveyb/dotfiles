#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/GitHub/dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="vim vimrc bashrc"    # list of files/folders to symlink in homedir

##########

# create dotfiles_old in homedir
echo -n "Creating $olddir for backup of any existing dotfiles in ~ ..."
mkdir -p $olddir
echo "done"

# change to the dotfiles directory
echo -n "Changing to the $dir directory ..."
cd $dir
echo "done"

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks from the homedir to any files in the ~/dotfiles directory specified in $files
for file in $files; do
    echo "Moving any existing dotfiles from ~ to $olddir"
    mv ~/.$file ~/dotfiles_old/
    echo "Creating symlink to $file in home directory."
    ln -s $dir/$file ~/.$file
done

# pull down the latest version of pathogeni
if [ ! -d ~/.vim/autoload ]; then
  echo -n "Creating ~/.vim/autoload directory ..."
  mkdir ~/.vim/autoload
  echo "done"
fi
cd ~/.vim/autoload
echo -n "Downloading the latest version of pathogen ..."
curl -LSso $dir/vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
echo "done"

# pull down the latest version of NERDTree
if [ ! -d ~/.vim/bundle ]; then
  echo -n "Creating ~/.vim/bundle directory ..."
  mkdir ~/.vim/bundle
  echo "done"
fi
cd ~/.vim/bundle
echo -n "Cloning the latest version of NERDTree ..."
git clone https://github.com/scrooloose/nerdtree.git
echo "done"

#!/bin/sh
# This script is used to install the vim configuration automatically

if [ -f "$HOME/.vimrc" ]
then
	echo "Backup the old .vimrc file"
	cp $HOME/.vimrc $HOME/.vimrc.bk
fi

echo "Copying the .vimrc file"
cp .vimrc $HOME/.vimrc

if [ -d .vim ]
then
	echo "Copying all the plugins"
	cp -a .vim/ $HOME/
fi




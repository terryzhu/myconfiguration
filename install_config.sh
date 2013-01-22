#!/bin/sh
# This script is used to install the vim configuration automatically

UPDATE=
USER=`whoami`
GROUP=`groups |cut -d' ' -f1`
SYSCALL_CTAGS="$HOME/.vim/tags/syscall_tags"

if [ X"$1" == "Xupdate"  ]
then
	echo "Now updating the config, it will not overwrite the existing files"
	UPDATE=1
fi


echo "During the installation, you need to input the root password!"
echo "Press ENTER to continue ..."
read

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

echo "Genering the ctags file, maybe it will take several seconds"
sudo ctags  -I __THROW  -I __THROWNL -I __attribute_pure__ -I __nonnull -I __attribute__ -R --c-kinds=+p --fields=+iaS --extra=+q --language-force=C  -o $SYSCALL_CTAGS /usr/include/ 
sudo chown $USER $SYSCALL_CTAGS
sudo chgrp $GROUP $SYSCALL_CTAGS
echo "ctags file has been generated in $HOME/syscall_tags"



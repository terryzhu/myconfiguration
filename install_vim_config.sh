#!/bin/sh

printHelp()
{
	echo -e "############################################################################################"
	echo -e "#                                                                                          #"
	echo -e "# This script is used to install the vim configuration automatically                       #"
	echo -e "#  author:   terryzhu,zzhhuujjiiee@qq.com                                                  #"
	echo -e "#  version:  0.0.1                                                                         #"
	echo -e "#  WARNING:                                                                                #"
	echo -e "#  This is my first study of vim config, maybe it has some problems                        #"
	echo -e "# Usage:                                                                                   #"
	echo -e "#     ./install_vim_config install    to install the vim configuration or                  #"
	echo -e "#     ./install_vim_config clean      to clean up all configuration(remove \$HOME/.vim/)    #"
	echo -e "#     ./install_vim_config tiny       to install the tiny vim cfg                          #"
	echo -e "# \033[31mYour Vim version MUST >= 7,if not, maybe there will be some problems !!!\033[0m                 #"
	echo -e "#                                                                                          #"
	echo -e "############################################################################################\n"
}

inquiryVersion()
{
	echo -n "Do you make sure your Vim version >=7 (y/n)? "
	read input
	if [ "X$input" != "Xy" ]
	then
		exit 0
	fi
}

#USER=`whoami`
#GROUP=`groups |cut -d' ' -f1`
SYSCALL_CTAGS="$HOME/.vim/tags/syscall_tags"
STL_TAGS="$HOME/.vim/tags/stltags"

if [ "X$1" != "Xclean" -a "X$1" != "Xinstall" -a "X$1" != "Xtiny" ]
then
	printHelp
	exit 0
fi

#-----------------------Begin Clean ------------------------

if [ "X$1" = "Xclean"  ]
then
	echo "Now clean the config, it will remove the $HOME/.vim/ and recover to the situation before the vim config installation"

	if [ -f $HOME/.vimrc.bk ]
	then
		echo "recovering the .vimrc.bk"
		cp $HOME/.vimrc.bk $HOME/.vimrc
		rm $HOME/.vimrc.bk
	fi

	if [ -f $SYSCALL_CTAGS ]
	then
		echo "removing $SYSCALL_CTAGS"
		rm "$SYSCALL_CTAGS"
	fi

	if [ -f $STL_TAGS ]
	then
		echo "removing $STL_TAGS"
		rm "$STL_TAGS"
	fi

	if [ -d $HOME/.vim/ ]
	then
		rm -r $HOME/.vim/
	fi
	echo "clean the config successfully"
	exit 0
fi


#-----------------------Begin Install ------------------------

inquiryVersion


if [ -f "$HOME/.vimrc" -a ! -f $HOME/.vimrc.bk ]
then
	echo "Backup the old .vimrc file"
	cp $HOME/.vimrc $HOME/.vimrc.bk
fi

if [ "X$1" == "Xtiny" ]
then
	echo "Removing the old plugin"
	rm -rf $HOME/.vim
	echo "Copying the .vimrc file"
	cp TinyVimCfg/.vimrc $HOME/.vimrc
	echo "Copying all the plugins"
	cp -a TinyVimCfg/.vim/ $HOME/
	exit
fi


echo "Copying the .vimrc file"
cp .vimrc $HOME/.vimrc

if [ -d .vim ]
then
	echo "Copying all the plugins"
	cp -a .vim/ $HOME/
	if [ ! -d $HOME/.vim/tags ]
	then
		mkdir $HOME/.vim/tags
	fi
fi

if [ ! -f $SYSCALL_CTAGS  ]
then
	echo "Generating the ctags file, maybe it will take several seconds"
	#echo "During the installation, you need to input the root password!"
	#echo "Press ENTER to continue ..."
	#read input
	ctags  -I __THROW  -I __THROWNL -I __attribute_pure__ -I __nonnull -I __attribute__ -R --c-kinds=+p --fields=+iaS --extra=+q --language-force=C  -o $SYSCALL_CTAGS `cat $HOME/.vim/tags/taglists.txt`
	#sudo chown $USER $SYSCALL_CTAGS
	#sudo chgrp $GROUP $SYSCALL_CTAGS
	echo "ctags file has been generated in $SYSCALL_CTAGS"
else
	echo "$SYSCALL_CTAGS has been installed yet, do nothing"
fi
if [ ! -f $STL_TAGS ]
then
	echo "Generating the stl ctags file"
	ctags  -I __THROW  -I __THROWNL -I __attribute_pure__ -I __nonnull -I __attribute__ -R --c-kinds=+p --fields=+iaS --extra=+q --language-force=C++  -o $STL_TAGS  $HOME/.vim/stlfiles/
	echo "stl ctags file has been generated in $STL_TAGS"
else
	echo "$STL_TAGS has been installed yet, do nothing"
fi

# Install the syscall and stl utags
echo "Building the syscall and stl utags because it's big"
SYSCALL_UTAGS="$HOME/.vim/tags/syscall_udtags"
STLCALL_UTAGS="$HOME/.vim/tags/stludtags"

g++ -o $HOME/.vim/tags/gen_utags $HOME/.vim/tags/gen_utags.cpp

$HOME/.vim/tags/gen_utags "$SYSCALL_CTAGS" "$SYSCALL_UTAGS" 
$HOME/.vim/tags/gen_utags "$STL_TAGS" "$STLCALL_UTAGS"

echo "Building finished!"


echo "Installation is finished!"
echo "Please NOTICE that it will take about one minute to generate the highlight keyword file when first time ENTER Vim."
echo "Please Wait patiently :-)"
echo "Good Luck, Thank you"















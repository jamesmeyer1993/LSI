#!/bin/sh
#
# install_all.sh
# A script that automates the process of installing useful software.

# > commands:
# -h, --help
# -v, --verbose			verbose output
# -l, --list [package]		list unique installation functions
# -i, --install	[package]	invokes a specific installation function

# > packages:
#	all
#	programming_tools
#	security_tools
#	media_tools
#	vivaldi_browser
#	office_tools

# commands
C_HELP="-h --help"
C_VERBOSE="-v --verbose"
C_LIST="-l --list"
C_INSTALL="-i --install"

# flags
F_VERBOSE=0

# functions / packages
P_ALL="all"
P_PROG="programming_tools"
P_SECURITY="security_tools"
P_MEDIA="media_tools"
P_VIVALDI="vivaldi_browser"
P_OFFICE="office_tools"

print_help(){
	this_script="$(readlink -f $0)"		# find the location of this script
	sed -n 7,10p "$this_script"		# print lines 7-10
}

print_list(){
	this_script="$(readlink -f $0)"
	sed -n 12,18p "$this_script"
}

inst_all(){
	inst_programming_tools
	inst_security_tools
	inst_media_tools
	inst_vivaldi_browser
	inst_office_tools
}

# install programming tools
#	gcc, git, nano-extensions
inst_programming_tools(){
	sudo apt-get install {gcc,git}
	# addons for nano
	wget https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh -O- | sh
}

# install security tools
#	aircrack-ng
inst_security_tools(){
	sudo apt-get install {aircrack-ng}
}

# install media tools:
# 	python-pip, myplayer, mencoder, ffmpeg, youtube-dl retspan
inst_media_tools(){
	sudo apt-get install {python-pip,myplayer,mencoder,ffmpeg}
	pip install --upgrade youtube-dl
	git clone https://github.com/unawarecitizen/retspan
	chmod +x "retspan/install.sh"
	exec "retspan/install.sh"
	sudo rm -r retspan	# clean up the directory
}

# install vivaldi
#	vivaldi, vivaldi-netflix-compatibility
inst_vivaldi(){
	wget https://downloads.vivaldi.com/stable/vivaldi-stable_*_amd64.deb
	sudo apt -f install vivaldi-stable_*_amd64.deb
	wget https://downloads.vivaldi.com/snapshot/vivaldi-snapshot_*_amd64.deb
	sudo dpkg -i vivaldi-snapshot_*_amd64.deb
	rm vivaldi-*.deb	# clean up the directory
}

# install office tools
#	libreoffice
inst_office_tools(){
	sudo apt-get install libreoffice
}

# main function
echo "[$0]: args count = $#"

if [ $# -eq 0 ] ; then
	echo "[$0]: no arguments passed. Try -h, --help"
	exit
fi

# loop through command line args
count=1;
for var in "$@" ; do

	echo {"$C_HELP","$C_VERBOSE","$C_LIST","$C_INSTALL"} > "temp.txt"
	arg="$(grep $var temp.txt)"
	rm "temp.txt"
	echo "[$0]: grep result = $arg"

	# -h, --help
	if	[ $var -eq $C_HELP ] ; then
		print_help
		exit
	# -v, --verbose
	elif	[ $var -eq $C_VERBOSE ] ; then
		$F_VERBOSE=1
	# -l, --list
	elif	[ $var -eq $C_LIST ] ; then
		print_list
		exit
	# -i, -install
	elif [ $var -eq $C_INSTALL && $count < $# ] ; then

		package=$(var + 1)
		# all
		if [ $package -eq $P_ALL ] ; then
			inst_all
			exit
		# programming_tools
		elif [ $package -eq $P_PROG  ] ; then
			inst_programming_tools
			var=$(( var + 1 ))
		# security_tools
		elif [ $package -eq $P_SECURITY ] ; then
			inst_security_tools
			var=$(( var + 1 ))
		# media_tools
		elif [ $package -eq $P_MEDIA ] ; then
			inst_media_tools
			var=$(( var + 1 ))
		# vivaldi_browser
		elif [ $package -eq $P_VIVALDI ] ; then
			inst_vivaldi_browser
			var=$(( var + 1 ))
		# office_tools
		elif [ $package -eq $P_OFFICE ] ; then
			inst_office_tools
			var=$(( var + 1 ))
		# default
		else
			echo "[$#]: unknown package. Try -l,--list."
		fi

	# default
	else
		echo "[$#]: unkown command. Try -h,--help."
	fi
	count=$(( count + 1 ))
done

exit

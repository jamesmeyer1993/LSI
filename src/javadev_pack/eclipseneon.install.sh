# eclipsenenon.install.sh
#   - uses wget to download either the 32bit or 64bit version of eclipse tarball
#   - extracts the tarball
#   - runs the eclipse installer

# Variable Instantiation

user=$(whoami)          # detect the current user's username
echo "$user detected."

download64bit="http://eclipse.mirror.rafal.ca/oomph/epp/neon/R3/eclipse-inst-linux64.tar.gz"

download32bit="http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/neon/3/eclipse-jee-neon-3-linux-gtk.tar.gz"

# Functions

extract_tar() {
    mkdir /home/$user/eclipse_version
    tar -zxvf *.tar.gz -C /home/$user/eclipse_version
    rm *.tar.gz
}

exec_installer() {
    exec ~/eclipse_version/eclipse-installer/eclipse-inst
}

# Begin main

if [ $(uname -p) = "x86_64" ] ; then
    echo "64bit CPU detected."
    wget $download64bit
else
    echo "Cannot detect CPU type." 
    echo "Attempting 32bit installation."
    wget $download32bit
fi

extract_tar
exec_installer

# End

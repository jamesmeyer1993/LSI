# eclipsenenon.install.sh
#   - uses wget to install either the 32bit or 64bit version of eclipse

user=$(whoami)          # detect the current user's username
echo "$user detected."

download64bit="http://eclipse.mirror.rafal.ca/oomph/epp/neon/R3/eclipse-inst-linux64.tar.gz"

download32bit="http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/release/neon/3/eclipse-jee-neon-3-linux-gtk.tar.gz"

# beging main

if [ $(uname -p) = "x86_64" ] ; then
    echo "64bit CPU detected."
    wget $download64bit
    mkdir /home/$user/eclipse_version
    tar -zxvf *.tar.gz -C /home/$user/eclipse_version
    rm *.tar.gz
    ./home/$user/eclipse_version/eclipse-installer/eclipse-inst
else
    echo "Cannot detect CPU type." 
    echo "Attempting 32bit installation."
    wget $download32bit
    mkdir /home/$user/eclipse_version
    tar -zxvf *.tar.gz -C /home/$user/eclipse_version
    rm *.tar.gz
    ./home/$user/eclipse_version/eclipse-installer/eclipse-inst
fi

# end

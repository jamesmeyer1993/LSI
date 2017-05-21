# chrome.install.sh

proc32="null"           #need output for $(uname -p) on 32 bit cpu
proc64="x86_64"

# 64bit installation strings
url64="https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
name64="google-chrome-stable_current_amd64.deb"

# 32bit installation strings
url32="https://dl.google.com/linux/direct/google-chrome-stable_current_amd32.deb"
name32="google-chrome-stable_current_amd32.deb"

# beging main process

if [ $(uname -p) = $proc64 ]; then
    if [ -e $name64 ]; then
        sudo dpk -i $name64
    else
        wget $url64
        sudo dpkg -i $name64
    fi  
else
    echo "No 64bit cpu detected"
    echo "Attempting 32 bit installation of Google Chrome."
    wget $url32
    sudo dpkg -i $name32
fi

# to unistall Google Chrome, run: $ sudo apt-get remove google-chrome-stable

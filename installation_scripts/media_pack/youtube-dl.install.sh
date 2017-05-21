# youtube-dl.install.sh
#   1. upgrades pip
#   2. uses pip to install youtube-dl
#   3. installs ffmpeg, a dependency of youtube-dl
#   4. places the yt script in /bin 

echo "running youtube-dl.install.sh"

sudo apt-get install python-pip
sudo pip install --upgrade pip
sudo pip install --upgrade youtube-dl
sudo apt-get install ffmpeg

# install yt
sudo cp yt /bin && sudo chmod +x /bin/yt

# security.install.sh

echo "running security.install.sh"

# disable bluetooth
sudo cp kill_bluetooth /bin && sudo chmod +x /bin/kill_bluetooth

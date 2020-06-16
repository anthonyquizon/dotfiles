read ipaddress
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install ufw
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow ssh
sudo ufw allow from $ipaddress
sudo ufw enable



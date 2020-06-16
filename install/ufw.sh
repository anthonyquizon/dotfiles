read ipaddress
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install ufw
sudo ufw allow ssh
sudo ufw allow from $ipaddress
sudo ufw enable



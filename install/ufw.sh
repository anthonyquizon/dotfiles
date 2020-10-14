
sudo -p "password: " whoami 1>/dev/null

read -p "What's your ip address? " ipaddress
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow ssh
sudo ufw delete 1 
sudo ufw insert 1 allow from $ipaddress
sudo ufw status
sudo ufw enable

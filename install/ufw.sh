
sudo -p "password: " whoami 1>/dev/null

read -p "What's your ip address? " ipaddress
sudo apt-get update && sudo apt-get upgrade
sudo apt-get install ufw
sudo ufw default allow outgoing
sudo ufw default deny incoming
sudo ufw allow ssh
sudo ufw allow from $ipaddress
sudo ufw status

read -p "Is this ok? (yes/no): " confirm

if [ $confirm == "yes" ]; then
    sudo ufw enable
fi

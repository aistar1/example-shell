#!/bin/bash

# -------------------------------------------------------------------------------------------------------------
## set static network
#  ex : bash static_network_ubuntu_1804.sh  your_address 
#       bash static_network_ubuntu_1804.sh 127.0.0.1
#  https://m.jb51.net/article/152391.htm
# -------------------------------------------------------------------------------------------------------------

if [ -z "$1" ] 
then
echo "No argument supplied"
exit -1
fi

net=$1

sudo bash -c "cat > /etc/netplan/01-network-manager-all.yaml << EOF
# Let NetworkManager manage all devices on this system
network:
  version: 2
  renderer: NetworkManager
  ethernets:
     eno1: #ifconfig -a
       dhcp4: no #dhcp4 close
       addresses: [${net}/24] # IP and netmask
       gateway4: 10.0.0.1
       nameservers:
         addresses: [8.8.8.8,8.8.4.4] #DNS
EOF"

sudo netplan apply

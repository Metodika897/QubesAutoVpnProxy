#!/bin/bash
stringRemotes=$(grep 'remote ' /rw/config/vpn/openvpn-client.ovpn)
remotes=($(echo $stringRemotes | tr " " "\n"))

for i in `seq 1 3 ${#remotes[@]}`; 
do
echo "qvm-firewall sys-firewall-vpn$1 add --before 0 accept" ${remotes[$i]} "proto=tcp dstports="${remotes[$i+1]}"" 
done

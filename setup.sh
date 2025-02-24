echo "
#VPN FIREWALL
qvm-create --class AppVM --label green --template debian-12-xfce sys-firewall-vpn$1
qvm-prefs sys-firewall-vpn$1 provides_network true

#VPN Firewall initial setup
qvm-firewall sys-firewall-vpn$1 del --rule-no 0
qvm-firewall sys-firewall-vpn$1 add drop
qvm-firewall sys-firewall-vpn$1 add --before 0 drop proto=icmp
qvm-firewall sys-firewall-vpn$1 add --before 0 drop specialtarget=dns

#VPN GATEWAY TEMPLATE
qvm-clone debian-12-xfce debian-12-xfce-vpn$1
qvm-run debian-12-xfce-vpn$1 'sudo apt -y install openvpn'
qvm-run debian-12-xfce-vpn$1 'sudo systemctl disable openvpn'
qvm-shutdown --wait debian-12-xfce-vpn$1

#VPN GATEWAY
qvm-create --class AppVM --label green --template debian-12-xfce-vpn$1 sys-vpn$1
qvm-prefs sys-vpn$1 netvm sys-firewall-vpn$1
qvm-prefs sys-vpn"$1" provides_network true

qvm-run $2 \"sudo find /home/ -name runOnVm -exec qvm-copy '{}' \;\"
qvm-run sys-vpn$1 \"sudo find /home/ -name Configure -exec chmod +x '{}' \;\"
qvm-run --pass-io sys-vpn$1 \"sudo find /home/ -name Configure -exec '{}' $1 \;\"
"

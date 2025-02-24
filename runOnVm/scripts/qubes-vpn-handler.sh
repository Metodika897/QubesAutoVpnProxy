#!/bin/bash
set -e
export PATH="$PATH:/usr/sbin:/sbin"

case "$1" in

up)
# To override DHCP DNS, assign DNS addresses to 'vpn_dns' env variable before calling this script;
# Format is 'X.X.X.X  Y.Y.Y.Y [...]'
if [[ -z "$vpn_dns" ]] ; then
    # Parses DHCP foreign_option_* vars to automatically set DNS address translation:
    for optionname in ${!foreign_option_*} ; do
        option="${!optionname}"
        unset fops; fops=($option)
        if [ ${fops[1]} == "DNS" ] ; then vpn_dns="$vpn_dns ${fops[2]}" ; fi
    done
fi


nft flush chain ip qubes dnat-dns
#nft add chain qubes nat { type nat hook prerouting priority dstnat\; }
#iptables -t nat -F PR-QBS
if [[ -n "$vpn_dns" ]] ; then
    # Set DNS address translation in firewall:
    for addr in $vpn_dns; do
        nft add rule qubes dnat-dns iifname == "vif*" tcp dport 53 dnat "$addr"
        nft add rule qubes dnat-dns iifname == "vif*" udp dport 53 dnat "$addr"
    done
    su - -c 'notify-send "$(hostname): LINK IS UP." --icon=network-idle' user
else
    su - -c 'notify-send "$(hostname): LINK UP, NO DNS!" --icon=dialog-error' user
fi

;;
down)
su - -c 'notify-send "$(hostname): LINK IS DOWN !" --icon=dialog-error' user

;;
esac

file = '/rw/config/vpn/openvpn-client.ovpn'
textDownToReplace = "down /etc/openvpn/update-resolv-conf"
textDownToInsert = "down 'qubes-vpn-handler.sh down'"
textUpToReplace = "up /etc/openvpn/update-resolv-conf"
textUpToInsert = "up 'qubes-vpn-handler.sh up'"
authToReplace = "auth-user-pass"
authToInsert = "auth-user-pass pass.txt"

fileRead = open(file).read()
if 'script-security 2' in fileRead:
	fileRead = fileRead.replace(textDownToReplace, textDownToInsert)
	fileRead = fileRead.replace(textUpToReplace, textUpToInsert)
	fileRead = fileRead.replace(authToReplace, authToInsert)
	
else:
	settingsToPut = f"{authToInsert}\n\nscript-security 2\n{textUpToInsert}\n{textDownToInsert}"
	fileRead = fileRead.replace(authToReplace, settingsToPut)
fileWrite = open(file, "w")
fileWrite.write(fileRead)
fileWrite.close()
quit()

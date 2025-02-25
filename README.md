## Qubes VPN Proxy Setup Script

This script simplifies the process of setting up a secure VPN proxy within 
your Qubes OS environment. By routing your traffic through an encrypted 
tunnel, you enhance both your privacy and security. 

**Here's how this script makes things easier:**

* **Automated Qubes Creation:** It automatically creates the necessary 
qubes, including dedicated templates for organization and consistency.
* **Simplified Network Configuration:**  Network settings for the proxy 
cube are configured effortlessly, eliminating manual configuration steps.
* **OpenVPN Integration:**  The script installs and configures the OpenVPN 
client, ensuring seamless VPN connectivity.

**Before You Begin:**

* **Understanding the Risks:** Running scripts in dom0, especially those 
interacting with network traffic, carries inherent risks. Carefully review 
the script's code before execution to ensure you understand its 
functionality.
* **ProtonVPN Compatibility:** This script is specifically tested and 
designed for use with ProtonVPN's TCP VPN service. 
* **Tor Integration Considerations:** If you plan on combining this VPN 
tunnel with Tor, please review the provided link for crucial information: 
[https://www.whonix.org/wiki/Tunnels/Introduction].

**Setup Instructions:**

1. **Create an AppVM:**  Set up an appVM named "setup" and connect it to 
your internet connection.
2. **Access the Setup Cube:** Open a terminal emulator within the "setup" 
cube.
3. **Install Git:** Ensure that git is installed on the "setup" cube.
4. **Clone the Repository:** Clone this repository into the "setup" cube: 
`git clone` this repo. You can now close the "setup" terminal.
5. **Copy OVpn File:** Transfer your downloaded OpenVPN configuration file 
(.ovpn) to the `~/QubesAutoVpnProxy/runOnVm/passAndOvpn` 
directory. 
6. **Create Credentials File:** Create a text file named "pass.txt" in the 
same directory as ovpn file and enter your OpenVPN username and password on separate 
lines (OpenVPN/IKEv2).
7. **Run the Script in Dom0:**  Open a terminal in dom0 and execute the 
following commands:

   * `vm=setup` (Replace "setup" with your appVM name if different)
   * `postfix=postfix` (This will add "postfix" to the end of the qube 
names, leave empty if you don't want this).
   * `qvm-run --pass-io $vm "sudo find $HOME/ -name setup.sh -exec '{}' $postfix $vm \;" | sh | sh` 

8. **Select Sys-VPN Cube:** A prompt will appear asking you to select a 
target cube for the configuration file. Choose "sys-vpn<postfix>" (or 
sys-vpn if postfix was not used).

9. **Completion:** The script has now completed the setup process.

**Usage:**

* After setup, shut down both "sys-vpn" and "sys-firewall-vpn" cubes in 
the Qubes Manager.
* Attach "sys-firewall-vpn" to your existing network/firewall cube.
* Use "sys-vpn" as your cube network to route all traffic 
through the VPN.


**Code Inspiration:**

Parts of this script were copied from: [https://forum.qubes-os.org/t/configuring-a-proxyvm-vpn-gateway/19061].


**Contributions:**

Feel free to contribute by creating pull requests for adaptations to other 
VPN providers!

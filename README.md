In This Document We Going to Explain how to use this Simple Script to setup and secure your Cloud server.


CAUTION:

	*This Script is Designed for CentOS using with other Linux distro (other then rpm distro) can cause error in installing. 

	*Don't Press Enter while the script running and Kindly know the available port before entering Port number this will cause SSH Connectivity issue.	

STEPS:

1. Download the script in your local machine
2. Copy the script to your Cloud Server using SCP command for linux (recommended to use with CentOS) 
3. Run the Script in root.
4. Wait for a while, Script will do all the basic setup for you (Patience is Recommanded).
5. Script Install Below software
	* Upgrade System
	* Install firewall vim wget zip
6. Script Ask for Port number for SSH connectivity before type know the available port
7. At the End it prompt for username and password, Provide the username and password
8. After End of the script system start to reboot and connection will be disconnected.
9. Login using your username, password and port that you provided.
	eg. ssh -p (port number) (username)@(ip address)# Basic-Setup
This repository used for Basic Setup and to Secure Cloud VPS (CentOS).

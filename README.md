In This Document We Going to Explain how to use this Simple Script to setup and secure your Cloud server.


CAUTION:

	*This Script is Designed for CentOS using with other Linux distro (other then rpm distro) can cause error in installing. 

	*Don't Press Enter while the script running and Kindly know the available port before entering Port number this will cause SSH Connectivity issue.	

STEPS:

1. Download script in your Cloud Linux by following ways, 
	* yum install git
	* git clone https://github.com/MohamedIdris45/Basic-Setup.git


2. Run the Script in root.
3. Wait for a while, Script will do all the basic setup for you (Patience is Recommanded).
4. Script Install Below software
	* Upgrade System
	* Install firewall vim wget zip
5. Script Ask for Port number for SSH connectivity before type know the available port
6. At the End it prompt for username and password, Provide the username and password
7. After End of the script system start to reboot and connection will be disconnected.
8. Login using your username, password and port that you provided.
	eg. ssh -p (port number) (username)@(ip address)# Basic-Setup
	This repository used for Basic Setup and to Secure Cloud VPS (CentOS).

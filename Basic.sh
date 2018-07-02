#!/bin/bash

# Authour : Mohamed Idris
# Version : 1.2

#install basic software

echo "##########################################################################################################################"
echo "###########################  Only Press [ENTER] when the script ask, Patience Recommanded  ###############################" 
echo "###########################  Kindly Read the Instruction Before Installation for Huzzle free  ############################"
echo "##########################################################################################################################"

sleep 2s

read -p "Have you read the manual [y/n] : " yes

x=$(echo "y")

if [ "$yes" == "$x" ];then

	echo "###################################  SCRIPT STARTED TO RUN  #############################################"


	yum update -y
	yum install epel-release -y
	yum install firewalld vim wget bzip -y
	systemctl enable firewalld
	systemctl start firewalld

	while :
	do
		read -p "ENTER PORT NUMBER FOR SSH : " abcd

		var="$abcd"

		if [ -n "$var" ]; then


		sed -i -e 's/PermitRootLogin/#PermitRootLogin/g' /etc/ssh/sshd_config
		echo "Port $abcd" >> /etc/ssh/sshd_config
		echo "PermitRootLogin No" >> /etc/ssh/sshd_config
		
		
		firewall-cmd --permanent --add-port=$abcd/tcp
		firewall-cmd --reload
		semanage port -a -t ssh_port_t -p tcp $abcd
		
		systemctl restart sshd
		
		break

	else 
		echo "########## KINDLY ENTER PORT NUMBER  ############"

	fi

	done

	echo "Kindly Enter the Details to Create User"

		if [ $(id -u) -eq 0 ]; then
        		read -p "Enter username : " username
        		read -s -p "Enter password : " password
        		egrep "^$username" /etc/passwd >/dev/null
        		if [ $? -eq 0 ]; then
                		echo "$username exists!"
                		exit 1
        		else
                		pass=$(perl -e 'print crypt($ARGV[0], "password")' $password)
                		useradd -m -p $pass $username
                		[ $? -eq 0 ] && echo "User has been added to system!" || echo "Failed to add a user!"
        		fi
		else
        		echo "Only root may add a user to the system"
        		exit 2
		fi

	echo "##########################################################################################################################"
	echo "########################################  System will restart in 15 Seconds ##############################################"
	echo "###################  Log in using your Username and Password that you provided and the Port you allowed for ssh ###########"
	echo "#######################################  ssh username@IPaddress -p 'port' ################################################"
	echo "##########################################################################################################################"
	echo "################################### FEEDBACK CONTACT: mohamedidris45@yahoo.com ###########################################"
	echo "##########################################################################################################################"

	sleep 10s

	reboot +5

else 
	echo "Kindle Read the manual README.md before installaion"
	exit 2
fi

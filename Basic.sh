#!/bin/bash

#install basic software

echo "##########################################################################################################################"
echo "###########################  Only Press [ENTER] when the script ask, Patience Recommanded  ###############################" 
echo "###########################  Kindly Read the Instruction Before Installation for Huzzle free  ############################"
echo "##########################################################################################################################"

sleep 5s

yum update -y
yum install epel-release -y
yum install firewalld vim wget bzip -y
systemctl enable firewalld
systemctl start firewalld

echo "Type the Port number for SSH and Press [ENTER]:"

read abcd


sed -i -e 's/PermitRootLogin/#PermitRootLogin/g' /etc/ssh/sshd_config
echo "PermitRootLogin no" >> /etc/ssh/sshd_config
echo "Port $abcd" >> /etc/ssh/sshd_config

firewall-cmd --permanent --add-port=$abcd/tcp
firewall-cmd --reload
semanage port -a -t ssh_port_t -p tcp $abcd
systemctl restart sshd

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
echo "###################  Log in using your Username and Password that you provided and the Port you allowd for ssh ###########"
echo "#######################################  ssh username@IPaddress -p 'port' ################################################"
echo "##########################################################################################################################"

sleep 10s

reboot +5

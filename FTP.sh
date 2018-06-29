#!/bin/bash

echo "################################################################################"
echo "######################  INSTALLING FTP IN CENTOS  ##############################"
echo "################################################################################"

yum install vsftpd -y

systemctl start vsftpd
systemctl enable vsftpd

cp /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.orig

sed -i -e 's/anonymous_enable=YES/#anonymous_enable=YES/g' /etc/vsftpd/vsftpd.conf
sed -i -e 's/connect_from_port_20=YES/#connect_from_port_20=YES/g' /etc/vsftpd/vsftpd.conf
echo "anonymous_enable=NO" >> /etc/vsftpd/vsftpd.conf

echo "ENTER PORT NO FOR FTP: "
read xyz

defa=1

sum=`echo "$xyz + $defa" | bc`

echo "listen_port=$xyz" >> /etc/vsftpd/vsftpd.conf
echo "pasv_min_port=$xyz" >> /etc/vsftpd/vsftpd.conf
echo "pasv_max_port=$sum">> /etc/vsftpd/vsftpd.conf
echo "userlist_file=/etc/vsftpd/vsftpd.userlist" >> /etc/vsftpd/vsftpd.conf
echo "userlist_deny=NO" >> /etc/vsftpd/vsftpd.conf
echo "chroot_local_user=YES
allow_writeable_chroot=YES" >> /etc/vsftpd/vsftpd.conf

touch /etc/vsftpd/vsftpd.userlist

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

echo "$username" >> /etc/vsftpd/vsftpd.userlist

semanage fcontext -a -t public_content_rw_t /home/$username/

systemctl restart vsftpd

firewall-cmd --permanent --add-port=$xyz/tcp
firewall-cmd --permanent --add-port=$sum/tcp
firewall-cmd --permanent --add-service=ftp
firewall-cmd --reload

echo "############################################################################################"
echo "########################  FTP HAS BEEN INSTALLED SUCCESSFULLY ##############################"
echo "######## CONNECT FTP USING USERNAME AND PASSWORD YOU PRIVIDED ALONG WITH PORT NUMBER #######"
echo "############################################################################################"















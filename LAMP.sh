#!/bin/bash


#Dependency check

yum install lsb -y
apt-get install lsb -y

#OS check

x="(lsb_release -i | cut -f 2-)"

y=$(eval $x)

z=$(echo "CentOS")

if [ "$y" == "$z" ];then
	echo"##################################################################################"
	echo"###################### WE HAVE DETECTED YOUR SYSTEM AS $y ########################"
       	echo"##################################################################################" 
        echo"##########################  INSTALLING LAMP IN CENTOS ############################"
        echo"#############  KINDLY READ LAMP.md TO GET KNOWLEDGE ABOUT THIS SCRIPT ############"
        echo"##################################################################################"

        yum install vim httpd mariadb-server mariadb php php-mysql php-fpm firewalld -y

        systemctl start firewalld
        systemctl enable firewalld
        systemctl start httpd
        systemctl enable httpd
        systemctl start mariadb
        systemctl enable mariadb
        systemctl restart httpd

  	firewall-cmd --permanent --add-port=80/tcp
	firewall-cmd --permanent --add-port=443/tcp
	firewall-cmd --permanent --add-port=3306/tcp
	firewall-cmd --permanent --add-service=http
	firewall-cmd --permanent --add-service=https
	firewall-cmd --reload

	echo"#########################  NOW SECURE YOUR MYSQL #############################"

	mysql_secure_installation

	touch /var/www/html/info.php

	echo "<?php phpinfo(); ?>" >> /var/www/html/info.php

	echo"#######################################################################################"
	echo"################################## END OF SCRIPT ######################################"
	echo"######## IN YOUR WEB BROWSER CHECK WEB-SERVER AND PHP ARE WORKING FINE BY TYPING  #####"
	echo"######### http://IPADDRESS (WEBSERVER): http://IPADDRESS/info.php  ####################"
        echo"#######################################################################################"
	echo"#################### FEEDBACK CONTACT mohamedidris45@yahoo.com ########################"
	echo"#######################################################################################"
	
else
	
	echo"##################################################################################"
        echo"###################### WE HAVE DETECTED YOUR SYSTEM AS UBUNTU ####################"
        echo"##################################################################################" 
        echo"##########################  INSTALLING LAMP IN CENTOS ############################"
        echo"#############  KINDLY READ LAMP.md TO GET KNOWLEDGE ABOUT THIS SCRIPT ############"
        echo"##################################################################################"

	#Installing software

	apt-get update -y
	apt-get install apache2 -y
	apt-get install mysql-server -y
	apt-get install php libapache2-mod-php php-mcrypt php-mysql vim unzip zip wget bzip2 -y

	#service

	systemctl enable apache2
	systemctl start apache2
	systemctl enable mysql
	systemctl start mysql

	#secure_mysql

	mysql_secure_installation

	#firewall

	ufw allow in "Apache Full"

	#setting up PHP7

	touch /var/www/html/info.php

	echo "<?php
	phpinfo();
	?>" >> /var/www/html/info.php

	echo"#######################################################################################"
        echo"################################## END OF SCRIPT ######################################"
        echo"######## IN YOUR WEB BROWSER CHECK WEB-SERVER AND PHP ARE WORKING FINE BY TYPING  #####"
	echo"######### http://IPADDRESS (WEBSERVER): http://IPADDRESS/info.php  ####################"
	echo"#######################################################################################"
	echo"#################### FEEDBACK CONTACT mohamedidris45@yahoo.com ########################"
        echo"#######################################################################################"
fi
	



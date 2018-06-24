#!bin/bash

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

echo"######################### END OF SCRIPT #################################"
echo"######## IN YOUR WEB BROWSER CHECK WEB-SERVER AND PHP ARE WORKING FINE BY TYPING  #####"
echo"####### http://youripaddress (for web-server) ################"
echo"####### http://youripaddress/info.php ########################"
echo"####### FEEDBACK CONTACT: mohamedidris45@yahoo.com ###########"

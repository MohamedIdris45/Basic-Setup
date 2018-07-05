#!/bin/bash 

# AUTHOR : MOHAMEDIDRIS
# VERSION : 1.1v
# CONTACT : mohamedidris45@yahoo.com


read -p "Have you read the manual [y/n] : " yes

x=$(echo "y")

if [ "$yes" == "$x" ];then


	echo "#######################################################################"
	echo "################  INSTALLING NGINX IN CENTOS  #########################"
	echo "#######################################################################"

	yum install epel-release -y
	yum install firewalld -y
	yum install nginx -y

	systemctl start firewalld
	systemctl start nginx
	systemctl enable firewalld
	systemctl enable nginx

	firewall-cmd --permanent --add-port=80/tcp
	firewall-cmd --permanent --add-service=http
	firewall-cmd --reload

	cp -rvf /etc/nginx /root/

	mkdir /etc/nginx/sites-available
	mkdir /etc/nginx/sites-enabled
	
	while :
	do

		echo "#############  ENTER YOU WEBSITE NAME WITHOUT WWW & .COM  ##############"
		echo ""

		read -p "Enter your Website name without [www] & [.com]: " web

		tes="$web"

		if [ -n "$tes" ]; then

			sed -i -e '36,57 d' /etc/nginx/nginx.conf
			sed -i -e '36 a include /etc/nginx/sites-enabled/*.conf;'  /etc/nginx/nginx.conf

			touch /etc/nginx/sites-available/$web.conf


			mkdir -p /var/www/$web.com/html

			semanage fcontext -a -t httpd_sys_content_t "web(/.*)?"

			restorecon -R -v /var/www/

			echo "server {
    				listen  80;

    				server_name $web.com www.$web.com;

    				location / {
        				root  /var/www/$web.com/html;
        				index  index.html index.htm;
        				try_files \$uri \$uri/ =404;
    				}	

    				error_page  500 502 503 504  /50x.html;
    				location = /50x.html {
        				root  /usr/share/nginx/html;
    				}
			}" >> /etc/nginx/sites-available/$web.conf

			ln -s /etc/nginx/sites-available/$web.conf /etc/nginx/sites-enabled/

			touch /var/www/$web.com/html/index.html

			echo "<h1>WELCOME TO NGINX ,, ITS WORKING  
			###### FEEDBACK @ mohamedidris45@yahoo.com ####### </h1>" >> /var/www/$web.com/html/index.html

			systemctl restart nginx

			echo "###############################################################"
			echo "###############  KINDLY CHECK NGINX IS WORKING ################"
			echo "############### YOUR IP ADDRESS IN WEB BROWSER ################"
			echo "###############################################################"

			break

		else
			
			echo "############## ENTER YOU WEBSITE NAME WITHOUT WWW & .COM  ############"

		fi
	
	done

else

	echo "##########  KINDLY READ THE NGINX.md  ##############"
        exit 2
fi







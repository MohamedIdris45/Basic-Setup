#!/bin/bash

# AUTHOR : Mohamed Idris
# VERSION : 1.1v
# CONTACT : mohamedidris45@yahoo.com

echo ""
echo"##################################################################################"
echo""
echo""

read -p "Have you read the manual [y/n] : " yes

x=$(echo "y")

if [ "$yes" == "$x" ];then

#Dependency check


	yum install lsb -y
	apt-get install lsb -y

	#OS check

	x="(lsb_release -i | cut -f 2-)"

	y=$(eval $x)

	z=$(echo "CentOS")

	if [ "$y" == "$z" ];then

		echo"###################################################################################"
		echo"####################### WE HAVE DETECTED YOUR SYSTEM AS $y ########################"
       		echo"###################################################################################" 
        	echo"##########################  INSTALLING NGINX IN CENTOS ############################"
        	echo"#############  KINDLY READ Nginx.md TO GET KNOWLEDGE ABOUT THIS SCRIPT ############"
        	echo"###################################################################################"

		
		#INSTALLING NGINX

                yum install epel-release -y
                yum install firewalld -y
                yum install nginx -y

                #FIREWALL SETTING

                systemctl start firewalld
                systemctl start nginx
                systemctl enable firewalld
                systemctl enable nginx

                firewall-cmd --permanent --add-port=80/tcp
                firewall-cmd --permanent --add-service=http
                firewall-cmd --permanent --add-port=443/tcp
                firewall-cmd --permanent --add-service=https
                firewall-cmd --reload

                cp -rvf /etc/nginx /root/

                mkdir /etc/nginx/sites-available
                mkdir /etc/nginx/sites-enabled

		#WHILE LOOP

		while :
                do

	                echo ""
                        echo "#############  ENTER YOU WEBSITE NAME WITHOUT (WWW & .COM)  ##############"
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

				echo "<h1> NGINX IS WORKING !!! </h1>
                                <h2> KINDLY MOVE YOUR HTML DIRECTORY TO /Var/www/$web/html to host </h2>
                                <h3> CONTACT (or) FEEDBACK :  mohamedidris45@yahoo.com </h3>" >> /var/www/$web.com/html/index.html

                                systemctl restart nginx

                                echo "###############################################################"
                                echo "###############  KINDLY CHECK NGINX IS WORKING ################"
                                echo "############### YOUR IP ADDRESS IN WEB BROWSER ################"
                                echo "###############################################################"

                                break

			else
				
				echo ""

			fi
		done


			echo"#######################################################################################"
			echo"################################## END OF SCRIPT ######################################"
			echo"######## IN YOUR WEB BROWSER CHECK WEB-SERVER WORKING FINE BY TYPING ##################"
			echo"########################## http://IPADDRESS (WEBSERVER)   #############################"
        		echo"#######################################################################################"
			echo"#################### FEEDBACK CONTACT mohamedidris45@yahoo.com ########################"
			echo"#######################################################################################"
	
	else
	
		echo"###################################################################################"
        	echo"####################### WE HAVE DETECTED YOUR SYSTEM AS UBUNTU ####################"
        	echo"###################################################################################" 
        	echo"##########################  INSTALLING NGINX IN UBUNTU ############################"
        	echo"#############  KINDLY READ Nginx.md TO GET KNOWLEDGE ABOUT THIS SCRIPT ############"
        	echo"###################################################################################"

		#INSTALLING NGINX

                apt-get install nginx -y
		
		#STARTING NGINX

                systemctl start nginx
                systemctl enable nginx

		while :
                do
                        echo ""
                        echo "#############  ENTER YOU WEBSITE NAME WITHOUT (WWW & .COM)  ##############"
                        echo ""


                	read -p "Enter you Website name without [www] or [.com] : " web

                	tes="$web"


			if [ -n "$tes" ]; then

				rm -rvf /etc/nginx/sites-available/*
				rm -rvf /etc/nginx/sites-enabled/*

	         		mkdir -p /var/www/$web/html
                        	touch /var/www/$web/html/index.html

                        	echo "server {
                                	listen 80;
                                	listen [::]:80;

                                	root /var/www/$web/html;
                                	index index.html index.htm;

                                	server_name $web.com www.$web.com;

                                	location / {
                                        	try_files \$uri \$uri/ =404;
                                	}
                        	}" >> /etc/nginx/sites-available/$web


                        	ln -s /etc/nginx/sites-available/$web /etc/nginx/sites-enabled

                        	echo "<h1> NGINX IS WORKING !!! </h1>
                        	<h2> KINDLY MOVE YOUR HTML DIRECTORY TO /Var/www/$web/html to host your webpage</h2>
                        	<h3> CONTACT (or) FEEDBACK :  mohamedidris45@yahoo.com </h3>" >> /var/www/$web/html/index.html

                        	ufw allow ssh
				ufw allow 20/tcp
                        	ufw allow http
                        	ufw allow https
                        	ufw allow 443/tcp
                        	ufw allow 80/tcp
                        	ufw enable
                        	ufw reload
			
				systemctl restart nginx

				echo"#######################################################################################"
		                echo"################################## END OF SCRIPT ######################################"
               		        echo"########### IN YOUR WEB BROWSER CHECK WEB-SERVER  ARE WORKING FINE BY TYPING  #########"
                		echo"######################### http://IPADDRESS (WEBSERVER) ################################"
                		echo"#######################################################################################"
                		echo"#################### FEEDBACK CONTACT mohamedidris45@yahoo.com ########################"
                		echo"#######################################################################################"

					
				break

			else
				echo""

			fi

		done

	fi

else
	echo "#####################  Kindly READ THE MANUAL LAMP.sh  ##################################"

fi

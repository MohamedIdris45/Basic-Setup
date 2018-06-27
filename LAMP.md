This is Simple Script to Install LAMP in Ubuntu & Redhat 

CAUTION:

This Script has been Tested in Ubuntu and Redhat (rpm like CentOS,Fedora) packages using other then this will cause error in installation

STEPS:

1. In your Cloud or local System download the script using 
      * git clone https://github.com/MohamedIdris45/Basic-Setup.git
      * cd Basic-Setup
      * bash LAMP.sh (run as root)
      
2. Software Installed and allowd in firewall
      * APACHE
      * Mariadb 
      * mysql (for Ubuntu)
      * PHP
      
3. Below 3306 port has been assigned for mariadb

4. Script asks for Securing your Mariadb
    * kindly visit the below website for securing your mariadb
    https://mariadb.com/kb/en/library/mysql_secure_installation/

5. After Installation Kindly check for http and php working fine or not by using web-browser 
      * http://youripaddress (For webserver APACHE)
      * http://youripaddress/info.php (For PHP Version)
      

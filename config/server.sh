#!/bin/bash
# Local vagrant virtual server initialization.
# Mysql root pass: "pass"

########################################################

DB="$1"
DB_USR="$2"
DB_PWD="$3"

function query {
   echo "---------------- Running query: $1"
   mysql -u root -ppass -e "$1"
}

########################################################

echo "################ Updating packages ################"
sudo apt-get update
# sudo apt-get dist-upgrade

echo "################ Adding packages: PHP 5.5+, Apache 2.4+, MySQL 5.6 ################"
yes Y | sudo apt-get install software-properties-common python-software-properties
yes Y | sudo add-apt-repository ppa:ondrej/php
yes Y | sudo add-apt-repository ppa:ondrej/apache2
yes Y | sudo add-apt-repository ppa:ondrej/mysql-5.6
sudo apt-get update

echo "################ Getting Apache 2.4 ################"
yes Y | sudo apt-get install apache2
sudo a2enmod rewrite

echo "################ Getting MySQL 5.6 ################"
echo "---------------- Root password: 'pass'"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password pass'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password pass'
sudo debconf-set-selections <<< 'mysql-server-5.6 mysql-server-5.6/root_password password pass'
sudo debconf-set-selections <<< 'mysql-server-5.6 mysql-server-5.6/root_password_again password pass'
yes Y | sudo apt-get install mysql-server-5.6
sudo mysql_install_db

echo "################ Getting PHP 5.6 ################"
yes Y | sudo apt-get install php5.6 php5.6-mysql libapache2-mod-php5.6 php5.6-mcrypt php5.6-curl php5.6-gd php5.6-intl 
# If you want PHP7:
# See @ https://github.com/oerdnj/deb.sury.org/issues/372
# yes Y | sudo apt-get install libpcre3 

echo "################ Setting database ################"
query "CREATE USER '$DB_USR'@'%' IDENTIFIED BY '$DB_PWD';"
query "GRANT USAGE ON *.* TO '$DB_USR'@'%' IDENTIFIED BY '$DB_PWD' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
query "CREATE DATABASE IF NOT EXISTS \`$DB\`;"
query "GRANT ALL PRIVILEGES ON \`$DB\`.* TO '$DB_USR'@'%';"
query "GRANT ALL PRIVILEGES ON \`$DB\_%\`.* TO '$DB_USR'@'%';"

echo "################ Todo list ################"
echo "Write wp-config.php -file based on settings"

echo "################ Setting virtual host ################"
sudo su
sudo echo "<VirtualHost *:80>
        ServerName  192.168.33.10
        ServerAdmin webmaster@localhost

        DocumentRoot /var/www/wordpress
        <Directory />
                Options FollowSymLinks
                AllowOverride All
        </Directory>
        <Directory /var/www/wordpress>
                Options Indexes FollowSymLinks MultiViews
                AllowOverride All
                Order allow,deny
                allow from all
        </Directory>

        ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/
        <Directory \"/usr/lib/cgi-bin\">
                AllowOverride None
                Options +ExecCGI -MultiViews +SymLinksIfOwnerMatch
                Order allow,deny
                Allow from all
        </Directory>

        ErrorLog ${APACHE_LOG_DIR}/error.log
        CustomLog ${APACHE_LOG_DIR}/access.log combined

        # LogLevel debug, info, notice, warn, error, crit, alert, emerg
        LogLevel warn

    Alias /doc/ \"/usr/share/doc/\"
    <Directory \"/usr/share/doc/\">
        Options Indexes MultiViews FollowSymLinks
        AllowOverride None
        Order deny,allow
        Deny from all
        Allow from 127.0.0.0/255.0.0.0 ::1/128
    </Directory>
</VirtualHost>
" > /etc/apache2/sites-available/000-default.conf

sudo service apache2 restart

echo "################ DONE! ################"

exit 0
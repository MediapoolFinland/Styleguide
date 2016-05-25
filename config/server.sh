#!/bin/bash

DB="$1"
DB_USR="$2"
DB_PWD="$3"
DB_PWD_ROOT="$4"

function query {
   echo "Running command $1"
   printf '$DB_PWD_ROOT\n' | mysql -u root -p -e "$1" 
}

sudo apt-get update
sudo apt-get install -y apache2

sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password $DB_PWD_ROOT'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password $DB_PWD_ROOT'
sudo apt-get install -y mysql-server libapache2-mod-auth-mysql

sudo mysql_install_db
sudo apt-get install -y php5 php5-mysql libapache2-mod-php5 php5-mcrypt php5-curl php-pear php5-gd php5-intl

query "CREATE USER '$DB_USR'@'%' IDENTIFIED BY '$DB_PWD';"
query "GRANT USAGE ON *.* TO '$DB_USR'@'%' IDENTIFIED BY '$DB_PWD' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
query "CREATE DATABASE IF NOT EXISTS \`$DB\`;"
query "GRANT ALL PRIVILEGES ON \`$DB\`.* TO '$DB_USR'@'%';"
query "GRANT ALL PRIVILEGES ON \`$DB\_%\`.* TO '$DB_USR'@'%';"

sudo a2enmod rewrite
sudo service apache2 restart
sudo apt-get install curl
#sudo curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#chmod +x wp-cli.phar
#sudo mv wp-cli.phar /usr/local/bin/wp
cd /vagrant/
#wp core download --allow-root
#wp core config --dbname=wpdb --dbuser=wpuser --dbpass=suvilahti55 --allow-root

echo "Getting Composer"

php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php -r "if (hash_file('SHA384', 'composer-setup.php') === '92102166af5abdb03f49ce52a40591073a7b859a86e8ff13338cf7db58a19f7844fbc0bb79b2773bf30791e935dbd938') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"
php composer-setup.php
php -r "unlink('composer-setup.php');"

sudo mv composer.phar /usr/local/bin/composer

echo "Composer done, get Twig"

composer require "twig/twig:~1.0"

echo "Twig done"

yes Y | sudo apt-get install software-properties-common python-software-properties
yes Y | sudo add-apt-repository ppa:chris-lea/node.js  
yes Y | sudo apt-get install nodejs
yes Y | sudo apt-get install git
yes Y | sudo npm install bower

# git clone https://github.com/zurb/foundation-sites-template foundation
# cd foundation
# npm install
# bower install
# cd ..

yes Y | sudo npm install --global gulp-cli
sudo npm update

echo "Layout files done"

cd /vagrant/
sudo npm install gulp

sudo su
sudo echo "<VirtualHost *:80>
        ServerAdmin webmaster@localhost

        DocumentRoot /vagrant
        <Directory />
                Options FollowSymLinks
                AllowOverride All
        </Directory>
        <Directory /vagrant>
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

        # Possible values include: debug, info, notice, warn, error, crit,
        # alert, emerg.
        LogLevel warn

        CustomLog ${APACHE_LOG_DIR}/access.log combined

    Alias /doc/ \"/usr/share/doc/\"
    <Directory \"/usr/share/doc/\">
        Options Indexes MultiViews FollowSymLinks
        AllowOverride None
        Order deny,allow
        Deny from all
        Allow from 127.0.0.0/255.0.0.0 ::1/128
    </Directory>

</VirtualHost>

" > /etc/apache2/sites-available/default 
exit



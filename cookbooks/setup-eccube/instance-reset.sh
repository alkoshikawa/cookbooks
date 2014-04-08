#!/bin/bash

service mysqld stop
service php-fpm stop
service nginx stop

rm -rf /var/www/eccube
rm -rf /var/lib/mysql/*

mysql_install_db
chown -R mysql:mysql /var/lib/mysql

service mysqld start
service php-fpm start
service nginx start

cp -f /usr/local/chef-repo/cookbooks/setup-eccube/attributes/server.rb.org /usr/local/chef-repo/cookbooks/setup-eccube/attributes/server.rb


#!/usr/bin/env bash

sudo apt-get update
sudo apt-get -f install
sudo apt-get -y install python-software-properties
sudo apt-get -f install

#PHP5.4
sudo add-apt-repository -y ppa:ondrej/php5

# MariaDB
sudo apt-key adv --recv-keys --keyserver keyserver.ubuntu.com 0xcbcb082a1bb943db
sudo add-apt-repository 'deb http://mirror.stshosting.co.uk/mariadb/repo/5.5/ubuntu precise main'

sudo apt-get update
sudo apt-get install -y apache2 vim php5 phpmyadmin mariadb-server git
sudo apt-get -f install

rm -rf /var/www
ln -fs /vagrant /var/www



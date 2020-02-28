#!/bin/bash

# This script automatically installs and configures MariaDB 10.3.

# copy repo file
sudo cp /vagrant/mariadb.repo /etc/yum.repos.d/

# update
echo "-------------------------------------------------"
echo "Updating CentOS 7 Guest OS..."
echo "-------------------------------------------------"
#sudo yum -y update

# install mariadb
echo "-------------------------------------------------"
echo "Downloading and installing MariaDB 10.3..."
echo "-------------------------------------------------"
sudo yum -y install mariadb-server

# ensure it is running
sudo /etc/init.d/mysql restart

# set to auto start (not yet a native service so use old style)
sudo chkconfig mysql on

### post-install setup

# set root password
sudo /usr/bin/mysqladmin -u root password 'password'

# allow remote access (required to access from our private network host. Note that this is completely insecure if used in any other way)
mysql -u root -ppassword -e "GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'password' WITH GRANT OPTION; FLUSH PRIVILEGES;"

# restart
sudo /etc/init.d/mysql restart

# run course db build scripts
cd /vagrant/sql
sh build.sh

# add mysql login defaults to guest OS
cd /home/vagrant
echo "Setting VM mysql login defaults to /home/vagrant/.my.cnf"
cat << ENDVM > ./.my.cnf
[client]
port=3306
host=127.0.0.1
user=student
ENDVM

# complete
echo "MariaDB setup complete."

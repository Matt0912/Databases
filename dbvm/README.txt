
University of Bristol School of Computing: COMSM0016 Databases

Overview
========

This file explains the setup and use of the Database VM for COMSM0016 Databases Unit.
It covers these main sections:

Database Virtual Machine Setup Script
- Setup: Lab Computers
- Setup: Personal Computers
VM Operations
Importing and Exporting SQL & Data To/From Your Database


Database Virtual Machine Setup Script
=====================================

The setup.sh script will build the MariaDB DBMS VM and initial datasets required
for the labs and assessments on this unit.

The script and VM is intended mainly for the MVB computer labs, but can also be
used on the following personal computer systems that support Virtual Box
virtualisation software: Linux, Mac OSX, Windows 10 (ideally with Linux subsystem).

Pre-requirement: You must have at least 1.4GB of available diskspace on your system.


Setup: Lab Computers
====================

Run the following command to display available space in your UoB account,
replacing myusername with your UoB lab username:

df -h | grep myusername

Ensure that you have less than 40% usage in your account, then perform the
following steps:

- Download the DB VM zip file from the COMSM0016 Unit information page.
- Unzip the dbvm directory in your home directory or preferred location.
- In the Terminal, navigate to this location and run setup.sh, e.g.:

cd ~/dbvm
chmod +x setup.sh
./setup.sh

- Confirm that you want to run the script by typing: y
- The script will take a few minutes (longer if others are also running it).
- On successful completion, a message starting "DB Install Complete" is displayed.
- Follow the instructions and type:

mysql

- This starts the MySQL/MariaDB client, which logs you in to the MariaDB database
  server running in the new Virtual Machine in your UoB account.
- Type the following example SQL commands (make sure you include the semi-colon!):

show databases;
  (lists all dbs available to this user)

use census;
  (selects the census db as the current database)

show tables;
  (lists all tables in the current database)

select * from Occupation;
  (displays all records from the Occupation table in the current database)

- When you have finished your SQL session, to exit the MySQL client, type:

exit

IMPORTANT NOTE: The setup script deletes any VMs and all data when it runs.
Use it only once, or when your VM installation crashes.
PLEASE SEE the VM Operations section to learn how to manage your VM,
and the Importing and Exporting Data section to learn how to backup your work.


Setup: Personal Computers
=========================

Compatible with: Linux, Mac OSX and Windows 10 systems supporting Virtual Box
See note on Windows 10 below.

Prereqs: All personal computers require recent versions of the following free
software installed:
- Oracle VirtualBox (https://www.virtualbox.org/)
- HashiCorp Vagrant (https://www.vagrantup.com/)
  (NOTE: ensure that version 2.x is installed)
- OPTIONAL: mysql-client utility   (e.g. on Mac, use: brew install mysql-client)

Setup:
- Ensure you have at least 1.4GB available disk space on your system.
- Download the zip file and unzip the dbvm folder in a suitable location.
- Open a Terminal window to this location and follow the earlier instructions for
  Lab accounts.

No MySQL Client Installed:
- If you do not have a MySQL client installed on your PC (i.e. typing: mysql
  returns a 'not found' type error), you can log in to the VM directly, type:

  vagrant ssh
  mysql

- To quit mysql and the VM, type:

  exit
  exit


NOTE ON WINDOWS 10 SETUP:
Windows 10 should have the Linux subsystem installed, to enable the setup.sh
script to be run without modification.
If a Linux command prompt is not available:
1) Ensure that Vagrant and VirtualBox are installed
2) Navigate in a Command window (e.g. PowerShell) to your unzipped dbvm folder.
3) Type:

vagrant up

4) When successfully completed, follow the instructions above regarding 'No MySQL
   Client Installed', and review the section on VM Operations.


VM Operations
=============
Your CentOS Linux Virtual Machine is running on the Virtual Box virtualisation
software in your account or on your PC.

* At the end of a lab or work session, type: vagrant halt

* At the start of a further session, type: vagrant up

DO NOT use setup.sh again, unless your DB VM is unrepairable.

The following vagrant commands can be used (in your dbvm directory):

vagrant halt
  (shuts down your VM, like 'power off', but saves all data)

vagrant up
  (starts up or builds your VM)

vagrant status
  (shows the running / halted status of your VM)

vagrant ssh
  (starts an SSH session, logging you in to your VM. To quit, type: exit)

IMPORTANT: Please also see the section below on importing/exporting data to ensure
you have a local backup of your SQL definitions & data.


Importing and Exporting SQL & Data To/From Your Database
========================================================

Although the VM is fairly reliable when following the instructions in 'VM Operations'
above, you should always export your updated DBs to SQL files after each session.

NOTE 1: Your dbvm directory (only) is shared with the VM, so all files for import to or
export from the VM should be copied here. In your VM, this shared dir is: /vagrant

NOTE 2: For simplicity, we will log in to the VM for import/export. However, similar
commands can be used from within the dbvm directory on your PC if you have the MySQL
client installed (such as on the Lab PCs). In this case you should remove/ignore the
/vagrant/ filepath.


1) Log in to the VM and move to the directory shared with your PC:

vagrant ssh
cd /vagrant

2) To export SQL from MariaDB to a file:
 [example to export SQL defining schema & data for the 'hovsoc' db to a file called
 hovsoc.sql in the shared dbvm directory]:

mysqldump --add-drop-table hovsoc > /vagrant/hovsoc.sql

3) To import SQL to MariaDB from an SQL file:
 [example to import SQL for the 'data' db from a file called data.sql]:

mysql data < /vagrant/data.sql

OR use the mysql client, selecting the target db and loading from the SQL file:

cd /vagrant
mysql
use data;
\. data.sql
exit

4) To log out of the VM, type:

exit


Root DB Access
==============

The default MySQL user is 'student'. You should use this for all normal SQL
operations. It is restricted to read-only access on the census and elections*
tables to avoid accidental deletion of the sample data.

However, you can also log in as 'root' administrator if required using:
mysql -u root -ppassword

This can be used to create / delete databases and change permissions, but should
not be used for standard data operations, following best practices.


Removing the VM
===============

If you wish to remove all DB VM assets from your lab account or personal computer,
to reclaim disk space after completion of the Unit, run the following commands
at a command prompt in your dbvm directory:

vagrant destroy
vagrant box remove --all bento/centos-7

You can then delete your dbvm directory, and optionally uninstall Vagrant and
VirtualBox.


Support
=======

For all VM / DB support out of Unit lab hours, please post on the Course Forum,
linked in the left menu of the COMSM0016 course site on BlackBoard.


DBVM script v1.31 Alan Forsyth & David Bernhard

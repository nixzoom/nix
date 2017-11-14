#!/bin/bash

#Setting up Binaries
TAR="$(which tar)"
GZIP="$(which gzip)"
MYSQL="$(which mysql)"
MYSQLDUMP="$(which mysqldump)"

##Create backup directory
SRVR="$(hostname)"
mkdir -p /var/backup/$SRVR$(date +%d%m%Y)
cd /var/backup/$SRVR$(date +%d%m%Y)


#Backup--/etc/
/bin/cp /etc/ . -rf

#Create and Change to DB Directory
/bin/mkdir DB && cd DB

## Take MySQL dump
$MYSQLDUMP --single-transaction -u root cinder > cinder.sql
$MYSQLDUMP --single-transaction -u root glance > glance.sql
$MYSQLDUMP --single-transaction -u root heat  > heat.sql
$MYSQLDUMP --single-transaction -u root keystone > keystone.sql
$MYSQLDUMP --single-transaction -u root murano > murano.sql
$MYSQLDUMP --single-transaction -u root neutron > neutron.sql
$MYSQLDUMP --single-transaction -u root nova > nova.sql

#Archiving
cd /var/backup/
rm -rf *.gz
/bin/tar -zcf $SRVR$(date +%d%m%Y)-ctrl-1.tar.gz $SRVR$(date +%d%m%Y)

#RemoveBackup
rm -rf /var/backup/$SRVR$(date +%d%m%Y)



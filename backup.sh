#!/bin/bash

##Create backup directory
SRVR='AWAL-STAGING'
mkdir -p /var/backup/$SRVR$(date +%d%m%Y)
cd /var/backup/$SRVR$(date +%d%m%Y)

#Remove Current Backup file
/bin/rm *.tar.gz

## Take MySQL dump

cd /var/lib/

/bin/tar -zcf mysql.tar.gz mysql/
/bin/mv mysql.tar.gz /var/backup/$SRVR$(date +%d%m%Y)

cd /var/www/
/bin/tar -zcf html.tar.gz html/
/bin/mv html.tar.gz /var/backup/$SRVR$(date +%d%m%Y)

cd /var/backup
/bin/tar -zcf $SRVR$(date +%d%m%Y).tar.gz $SRVR$(date +%d%m%Y)

exit 0


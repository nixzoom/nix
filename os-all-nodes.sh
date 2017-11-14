#!/bin/bash
DATE=`date +%Y-%m-%d`
mkdir -p /var/backup/$DATE
cd /var/backup/$DATE


/usr/bin/ansible -m shell -a "tar czf /tmp/x.tar.gz /etc" all

for i in $(/usr/bin/ansible --list-hosts 'cmp:mongo:swift-proxy:influxdb:swift');
do
	scp $i:/tmp/x.tar.gz $(ssh $i "hostname").tar.gz
done
for i in *.gz;
do
	mkdir $(echo $i| awk -F '.' '{ print $1 }');
	mv $i $(echo $i| awk -F '.' '{ print $1 }');
	cd $(echo $i| awk -F '.' '{ print $1 }');
	tar xzf *;
	cd ..
done
rm  /var/backup/$DATE/*/*.company.tar.gz
/usr/bin/ansible -m shell -a "rm /tmp/x.tar.gz" all

for i in $(/usr/bin/ansible --list-hosts 'cl');
do
	scp $i:/var/backup/*.gz .
done

# Move all the tars to archive folder and rotate archive

cd /var/backup/
rm /var/backup/archive-1/*.tar.gz
mv /var/backup/archive/*.tar.gz /var/backup/archive-1/
mv /var/backup/*.tar.gz /var/backup/archive/

# Archive the backup package
tar -zcf $DATE.tar.gz $DATE
rm -rf /var/backup/Today/*.gz
cp -rf $DATE.tar.gz Today
# Remove the backup work directory
rm -rf /var/backup/$DATE


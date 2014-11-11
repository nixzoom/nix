#!/bin/bash
#bipin added
##Create backup directory
iptables -I INPUT -p tcp --dport 25 -i eth0 -m state --state NEW -m recent --set
iptables -I INPUT -p tcp --dport 25 -i eth0 -m state --state NEW -m recent --update --seconds 60 --hitcount 4 -j DROP


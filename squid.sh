#!/bin/bash
apt-get update && apt-get install squid3 apache2-utils -y

touch /etc/squid/passwd && touch /etc/squid/blacklist.acl
htpasswd -b -c /etc/squid/passwd $squid_user $squid_password

#Use new config file
rm -f /etc/squid/squid.conf
wget --no-check-certificate -O /etc/squid/squid.conf https://raw.githubusercontent.com/niloahz/sq/master/squid.conf
service squid restart

#Port Setting
/sbin/iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
/sbin/iptables-save

#restart service 
service squid restart
update-rc.d squid defaults

#Check squid status
service squid status

#delet sh file
rm squid.sh

#!/bin/bash
/usr/bin/apt update
/usr/bin/apt install squid3 apache2-utils -y

/usr/bin/touch /etc/squid/passwd && /usr/bin/touch /etc/squid/blacklist.acl
/usr/bin/htpasswd -b -c /etc/squid/passwd $squid_user $squid_password

#Use new config file
/bin/rm -f /etc/squid/squid.conf
/usr/bin/wget --no-check-certificate -O /etc/squid/squid.conf https://raw.githubusercontent.com/niloahz/sq/master/squid.conf
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
/bin/rm squid.sh

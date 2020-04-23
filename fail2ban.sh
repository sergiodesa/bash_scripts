

#!/bin/sh

apt-get -y install fail2ban
cd /etc/fail2ban/
wget -O "jail.local" -c "http://dl.wp-ns.com/rules/jailf2b"
cd /etc/fail2ban/filter.d/
wget -O "proxmox.conf" -c "http://dl.wp-ns.com/rules/proxmoxf2b"
systemctl restart fail2ban




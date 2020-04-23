#!/bin/bash

cd /usr/src
wget -c http://www.rfxn.com/downloads/apf-current.tar.gz
tar -zxvf apf-current.tar.gz
cd apf*
./install.sh
wget -c http://dl.wp-ns.com/rules/firewall/conf.apf
cp conf.apf /etc/apf/conf.apf
/etc/init.d/apf restart


#!/bin/bash

cd /usr/src
wget http://www.rfxn.com/downloads/bfd-current.tar.gz
tar -zxvf bfd-current.tar.gz

cd bfd-*

./install.sh

cd /usr/local/bfd/
mv rules rules.out
mkdir rules
cd rules
wget http://dl.wp-ns.com/rules/wps_wordpress

yum -y install elinks


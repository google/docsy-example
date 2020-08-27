---
title: "Promox Postgress"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 45
pre: "<b></b>"
--- 

https://pve.proxmox.com/pve-docs/pct.1.html
pveam available --section system   (mostra le immagini disponibili)
pvectl list
#pct create 501 local:vztmpl/debian-10.0-standard_10.0-1_amd64.tar.gz
#pct create 502 local:vztmpl/debian-10.0-standard_10.0-1_amd64.tar.gz

pct set 501 -hostname db-master

pct set 502 -hostname db-slave

pct set CTID -onboot 1
lxc-start -n 501
lxc-start -n 502


pct config 101

pct restore 135 template_vzdump-lxc-142.tar.lzo 



pct shutdown 501
pct destroy 501


#############   parte da qui

pct create 502 local:vztmpl/debian-10.0-standard_10.0-1_amd64.tar.gz --cores 4 --hostname db-master --memory 2048 --onboot 1 --password replica --start 1 --swap 2048  


##--rootfs local:502/vm-502-disk-0,size=8G

pct set 502 -net0 name=eth0,bridge=vmbr0,ip=192.168.0.61/24,gw=192.168.0.254

vi /etc/ssh/sshd_config
PermitRootLogin yes


vzdump {{numero}} crea backup default


apt-get update
apt install postgresql
pg_ctlcluster 11 main start
sudo apt-get install python-psycopg2
sudo apt-get install libpq-dev

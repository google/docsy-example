---
title: "Zabbix"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b>514. </b>"
--- 

# Zabbix 

## Installazione Server 

https://www.zabbix.com/documentation/3.4/manual/installation/install_from_packages

## Installazione Client 

Bisogna installare la parte client (zabbix agent) su ogni host che si vuole monitorare
 
 apt install zabbix-agent
 service zabbix-agent start

Editare nell'host da monitorare in /etc/zabbix/zabbix_agentd.conf la stringa 
Server=127.0.0.1 in Server=*indirizzo ip del host dove è installata la parte server* (es. Server=192.168.0.55)

[[test]] sdfsdf

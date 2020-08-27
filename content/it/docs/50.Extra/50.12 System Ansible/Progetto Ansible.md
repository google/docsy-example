---
title: "System Ansible"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 500
pre: "<b>512. </b>"
--- 

# Ansible

TODO 

- creare i gruppi
- avere un sottogruppo per capire se devo installare nel gruppo ( es gruppo produzione ma il cliente no ha il plugin kit) 
- recuperare informazioni su macchina    
- creare webservices per run autopackin   fatto
- leggere sql per log import
- leggere osgi per capire versione plugin
- valutare riavvio servizio / container


Obiettivi :
- installare 2pack a livello system    fatto
- installare 2pack a livello client      fatto / in lavorazione
- installare plugin fatto
- allineamento viste report /bi 
- ??

Fase 1 - AutoPackin        fatto
Fase 2 - Install Jar    fatto
Fase 3 - update db syncapplied

progresso:

- gestire gli attachment multipli     fatto
- sincronizzare gli host in idempoiere con l'inventory ansible     fatto
- svuotare la cartella deputata all'autopack     fatto
- aggiungere proxmox action (aggiungere container da template)  fatto/in lavorazione
- rollback generico  

Ansible è basato su python, siccome python 2 (di default sulle macchine) sarà deprecato molto presto si consiglia di usare python 3  (impostare in /etc/ansible/ansible.cfg la variabile python-interpreter)



Creato su idempiere finestra ansibleTask che semplifica alcune funzionalità di gestione delle macchine:

- decidere quali macchine saranno l'obiettivo

- JAR: installa un plugin selezionandolo dalla sottotab versione
- SQL: lancia un comando SQL incollandolo nello specifico campo
- 2PACK: installa uno o più 2pack in allegato alla finestra
- SHELL: da implementare

prerequisiti da installare sulla macchina obiettivo:
(creato playbook ansible)
- sistemare chiave del repository Sury
 - wget -O lklkslklwslwk
- chiave ssh per comunicazione diretta controller-host
  - (ssh-keygen)
- python3 di default 
  - set alternatives......
- pip3
 - apt install python3-pip
- psycopg2 
 - pip3 install psycopg2


https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html

Latest Releases Via Apt (Debian)

Debian users may leverage the same source as the Ubuntu PPA.

Add the following line to /etc/apt/sources.list:

 deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main

Then run these commands:

 $ sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367
 $ sudo apt-get update
 $ sudo apt-get install ansible


 /etc/ansible

 hosts
 [webservers]
  H22
  H23


 in .ssh/config 
 Host H22
        HostName 192.168.0.22
        User root
 Host H23
        HostName 192.168.0.23
        User root

Primo Test
 ansible H22 -m ping
 H22 | SUCCESS => {
    "changed": false, 
    "ping": "pong"
 }

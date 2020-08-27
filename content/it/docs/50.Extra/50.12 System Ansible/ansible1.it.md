---
title: "Ansible"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b></b>"
--- 

## Installation

```bash
$ sudo apt-get update
$ sudo apt-get install software-properties-common
$ sudo apt-add-repository --yes --update ppa:ansible/ansible
$ sudo apt-get install ansible
```

 

## Riferimenti / Documentazione

https://docs.ansible.com/





## Primi passi / Note

- directory di lavoro   /etc/ansible

- file elenco server  /etc/ansible/hosts

- abilitare servizion ssh server sul server remoto : sudo apt-get install openssh-server

- primo test ping : ansible nomepc-ip -u utente -k -m ping

- il parametro -k serve se non si è in possesso della chiave ssh (chiede password)

- file di configurazione /etc/ansible/ansible.cfg

- ansible 192.168.1.145 -u idempiere -k -m setup 

- Check esistenza file

   ansible 192.168.1.146 -u idempiere -k -m file -a "path=/home/idempiere/testa.txt"

  192.168.1.146 | SUCCESS => {
      "changed": false,  
      "gid": 1000,  
      "group": "idempiere",  
      "mode": "0664",  
      "owner": "idempiere",  
      "path": "/home/idempiere/test.txt",  
      "size": 5,  
      "state": "file",  
      "uid": 1000
  }

  Altri esempi : path= ""/etc/fstab"

- Creazione Cartella 
  

ansible 192.168.1.146 -u idempiere -k -m file -a "path=/home/idempiere/cartella state=directory mode=0700 owner=idemp
  iere"

- Eseguire un comando nel server remoto
  
   ansible 192.168.1.145 -u idempiere -k -m command  -a 'ls'
  
  ## Moduli 
  
  - ping 
  - setup
  - file
  - copy
  - command
  - 


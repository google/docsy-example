---
title: "Backup Hubic"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b></b>"
---
# Configurazione Hubic

---

Verificare che nella cartella

```
http://mir7.ovh.net/ovh-applications/hubic/hubiC-Linux
```

l'ultima versione sia la 2.1.0.43

download .deb 

```
wget  http://mir7.ovh.net/ovh-applications/hubic/hubiC-Linux/2.1.0/hubiC-Linux-2.1.0.53-linux.deb
sudo apt-get update
sudo dpkg -i hubiC-Linux-2.1.0.53-linux.deb
apt-get install -f
```

```
hubic login <email> <folder to synchronize>
```

## Configurazione directory di sincronizzazione

---

andare nella cartella desiderata  esempio  /opt/repos/build

eseguire hubic sync /opt/repos/build

E' possibile lanciare i seguenti comandi

```
hubic start   [per eseguire uno start della syncronizzazione]
hubic status  [per verificare stato e operazioni in corso]
```



```
hubic backup create --name=iDempiereVPSBackup /media/consulnet/Storage/Backup
```

```
hubic syncdir (path-directory-da-sincronizzare)
```



obsoleto :

```  
 $ dbus-daemon --session --fork --print-address
    unix:abstract=/tmp/dbus-XXXX,guid=XXXXXXX
    $ export DBUS_SESSION_BUS_ADDRESS=unix:abstract=/tmp/dbus-XXXX,guid=XXXXXXX
    $ hubic login me@foo.com ~/hubiC
```

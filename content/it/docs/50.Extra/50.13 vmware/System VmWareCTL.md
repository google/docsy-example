---
title: "vmware"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b>513. </b>"
--- 

# System VmWareCTL

---

# Controllo macchine virtuali in VmWare Player/ ESXi/ Workstation

---

## Cosa installare

---

- VmWare (o accertare la connessione al hypervisor) con gestore pacchetti o con installante ufficiale reperibile dal web
- VmWare API reperibili su [questo sito](https://www.vmware.com/support/developer/vix-api/)

```
cd /cartella/al/file/scaricato # esempio /home/gigi/Scaricati
chmod +x <nome-file>.bin       # esempio VMware-VIX-1.15.0-2985596.x86_64.bin
sudo ./ <nome-file>.bin

Seguire il wizard di installazione
```

## Cosa si ottiene

---

L'installante aggiunge ai comandi disponibili da shell il comando **vmrun**

```
vmrun --help # per vedere tutte le opzioni disponibili
```

## Esempi con VmWare Player in locale

---

```
cd /cartella/delle/vm/         # esempio /opt/vm/server-web
vmrun -T player start *.vmx    # per avviare una vm
vmrun -T player suspend *.vmx  # per sospendere una vm
```


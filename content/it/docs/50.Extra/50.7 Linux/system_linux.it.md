---
title: "Linux"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 15
pre: "<b></b>"
--- 

# System Linux Comandi

---

## Sistema

---

## Comandi di base / locali

Creare sottocartelle:  

```
mkdir -p /nomecartella/nomecartella/nomecartella
```

### Controllare lo spazio su disco

```
du -sh
df
```

Tool grafico non installato 

```
ncdu
```

## Contare il numero di file

find DIR_NAME -type f | wc -l

### Crontab

```
https://www.cyberciti.biz/faq/linux-show-what-cron-jobs-are-setup/
https://www.cyberciti.biz/faq/howto-check-cronjob-is-running-not/
```

## Avviare un Programma all'avvio ( init.d )

```
rif https://groups.google.com/forum/#!topic/idempiere/Kz0S3Fb0XBQ
https://debian-administration.org/article/28/Making_scripts_run_at_boot_time_with_Debian
```

```
dentro la cartella /etc/init.d 
creare un file id.sh
chmod a+x /etc/init.d/id.sh   (fondamentale)  
update-rc.d id.sh defaults
(nel caso ci fossero problemi --> update-rc.d -f id.sh defaults)
```

[EDIT del file id.sh]

```
cd /opt/idempiere/idempiere-server
./idempiere-server.sh
```

### scan port

```
http://computersecuritypgp.blogspot.it/2016/03/a-guide-to-port-scanning-using-nmap.html?m=1
```

### decomprimere file jar

```
jar xvf nomefile.jar
```

convertire file immagine .dd in file .iso

```
dd if=/file.dd of=file.iso
```

scrivere file immagine .dd su un device (usb)

```
dd if=/file.dd of=/dev/sdb (nome device)
```

### montare cd/dvd

```
mkdir /mnt/cdrom
mount /dev/cdrom /mnt
mount /dev/dvd /mnt
```

### ssh Key

```
https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/
```

* Step 1- Creare la chiave sul pc locale  [server farlo una sola volta]

```
ssh-keygen -t rsa
```

* Enter file in which to save the key (/home/consulnet/.ssh/id_rsa): 

```
Dare semplicemente invio o inserire il nome del voluto che si vuole dare
```

 Step 2 - Copiare la chiave nel server remoto

```
ssh-copy-id -i ~/.ssh/id_rsa.pub root@213.232.111.223 
```

```
dove aver inserito la pwd
```

### tunnel SSH

ssh  -f -L 5434:localhost:5432 root@31.31.36.19 -N

### Per conoscere la versione di kernel installata

```
uname -a
```

### Per conoscere la lista delle periferiche USB:

```
lsusb -v
```

### Informazioni sulla cpu

```
cat /proc/cpuinfo
```

### Informazioni sui processi e sull’uso di cpu

```
top
```

### Informazioni sulla memoria:

```
free -m
```

### Per conoscere le informazioni sulla release del sistema operativo:

```
Per debian
cat /etc/debian_version
Per Red Hat
rpm -qa
```

## Rete e Collegamenti remoti

### Accedere ad un altra macchina da terminale - ssh :

```
ssh root@”ip"
```

### Tar -Scompattare un file e dichiarare il percorso: 

```
tar -C /tmp/ -zxvf nomefile.tar.gz
```

### Cambiare host di indirizzamento:

```
sudo nano /etc/hosts
```

## DB MySql

### Importare database mysql da server:

```
mysql -u username -ppassword database_name < nomefile.sql
```

## Samba

```
 https://ubuntrucchi.wordpress.com/2008/03/08/configurazione-avanzata-di-samba/ 
```

```
/sbin/service smb start
modificare il file /etc/hosts
riavvio servizio rete: /etc/init.d/network restart
service network restart
```

### Qual è il nome della macchina ?

```
$ hostname
```

### Quanta memoria è libera ?

```
$ free -m | sed -n ‘3,3p’ | awk ‘{print $4 ” MB”}’
```

### Da quanto tempo il computer è acceso ?

```

```

 $ uptime | cut -d, -f1 

### Quale processo stà utilizzando più CPU?

```

```

 $ ps -eo pcpu,pid,user,args | sort -k1 -r -n | head -2

### Qual è il mio nome utente?

```

```

 $ whoami

### Copia Files

```

```

scp -r nomecartella root@ipmacchina:/
scp nomefile root@ipmacchina:/

### Ricerca Files

find -iname "nomefile"

find / -type d -name 'httpdocs'

## Ricerca Processi 

find the pid of your X server:
ps -e | grep X

kill “numero pid”

restart X
startx

### montaggio smb share su linux

sudo mount -t cifs //172.16.10.1/VMWARE /mnt/VMWARE


per farlo a mano con sistema già avviato:

sudo mkdir /mnt/VMWARE
sudo mount -t cifs //172.16.10.1/VMWARE /mnt/VMWARE -o username=root%123abcD


per metterlo in avvio automatico invece:

editare etc/fstab (facendo un backup prima)

vi fstab

esempio:

/etc/fstab

Created by anaconda on Wed Jul 18 01:12:27 2012

Accessible filesystems, by reference, are maintained under '/dev/disk'

See man pages fstab(5), findfs(8), mount(8) and/or blkid(8) for more info

/dev/mapper/vg_pe02-lv00 / ext4 defaults 1 1
UUID=56ee678a-5db4-4454-946e-0f1abf6b50bf /boot ext4 defaults 1 2
UUID=04A8-B7B0 /boot/efi vfat umask=0077,shortname=winnt 0 0
/dev/mapper/vg_pe02-lv_swap swap swap defaults 0 0

aggiungere in fondo:

//172.16.10.1/VMWARE /mnt/VMWARE -o username=root%123abcD cifs dmask=700,fmask=700,noauto,comment=systemd.automount 0 0

### rinominare un file con data / ora corrente

mv myfile.txt `date +%Y_%m_%d_%H:%M:%S`.txt
mv /BACKUP/bck2.tar /BACKUP/`date +%Y_%m_%d_%H:%M:%S`bck.tar

### send file to ftp server:

curl -T koc_dance.mp3 ftp://myftpsite.com/mp3/ --user myname:mypassword

curl -T aaa.txt ftp://ftp.openrevolution.it/www.openrevolution.it/BCK/MASET/ --user 1499536@aruba.it:njyjvkuc

### Backup script esempi:


File di Esempio Backup

```
#!/bin/bash

# Stupid backup script
	OGGI=$(date +%Y%m%d)

# data di 7 giorni fa
	VECCHIO=$(date --date='7 days ago' +%Y%m%d)
	MAX_GIORNI=10

# di cosa fare il backup
	SRC_DIRS=("/home/" "/etc/" "/srv/samba/")

# USB disk/NFS...  dove fare il backup
	BACKUP_DIR="/srv/backup"
	SNAPSHOT_DIR="$BACKUP_DIR/snapshot"
	ARCHIVES_DIR="$BACKUP_DIR/archives"
	EXCLUDE_FILE="$BACKUP_DIR/exclude"

#Creo struttura per i backup
	mkdir -p $BACKUP_DIR
    mkdir -p $SNAPSHOT_DIR $ARCHIVES_DIR
    touch $EXCLUDE_FILE

# snapshot
    for bk_dir in ${SRC_DIRS[@]}
    do
    echo "rsync di $bk_dir"
    rsync -a --exclude-from=$EXCLUDE_FILE $bk_dir $SNAPSHOT_DIR 
    done

# archivio
    for bk_dir in ${SRC_DIRS[@]}
    do
    echo "archivio di $bk_dir"
    nome=${bk_dir//"/"/""}
    tar czf $ARCHIVES_DIR/$OGGI-$nome.tgz --exclude-from=$EXCLUDE_FILE $bk_dir
    done

# rimozione vecchi file

# per nome
    rm -f $BACKUP_DIR/archives/$VECCHIO-*

# per età, soluzione migliore
    find $BACKUP_DIR/archives/* -mtime +$MAX_GIORNI -exec rm {} \; 
```

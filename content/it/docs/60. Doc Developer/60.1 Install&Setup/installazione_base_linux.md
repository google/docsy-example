# Installazione Base Linux

---

| Installazione Base Installazione Sviluppo Linux | [Download_Code](http://192.168.178.102/index.php/Download_Code) ⇒

The examples on this guide are using the following versions:

- Debian 8 64 bits
- PostgreSQL 9.4.1
- PostgreSQL contrib (for UUID support)
- Mercurial Client 2.8.2
- Oracle Java 1.8

riferimenti

- <http://wiki.idempiere.org/en/Installing_iDempiere>
- <http://wiki.idempiere.org/en/Migration_Notes#Version_iDempiere_3.0>

 **Installazione Base Linux**

## **Debian 8**

Procediamo in questo modo:

```
sudo apt install openssh-server
sudo apt-get update
```

SOLO nel caso di installazioni locali/esx con ISO netinst (perchè di base non permettono l'accesso in ssh dell'utente root) entrare nella seguente directory:

```
/etc/ssh/sshd_config       modificare la riga -->  PermitRootLogin yes
```

per riavviare e permetter l'accesso senza riavviare

```
invoke-rc.d ssh restart
apt-get install sudo
apt-get install sshpass

apt-get install curl
apt-get install ssmtp
```

## **Install Postgresql 9.5 / 9.6**

#### *Debian 8*

#### *Debian 8 Alternativa 1*

```
echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
sudo wget http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc
sudo apt-key add ACCC4CF8.asc
sudo apt-get update
sudo apt-get install postgresql-9.6
sudo apt-get install postgresql-contrib
```

#### *Debian 8 Alternativa 2*

```
echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - 
sudo apt-get update
sudo apt-get install postgresql-9.6
sudo apt-get install postgresql-contrib
```

---

## **Install Postgresql 10**

#### *Debian 9 - Postgresql 10*

```
sudo sh -c "echo deb http://apt.postgresql.org/pub/repos/apt/ stretch-pgdg main >> /etc/apt/sources.list.d/pgdg.list"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
apt -y update
apt-get install postgresql-10 postgresql-contrib libpq-dev
systemctl start postgresql
systemctl enable postgresql
```

#### *Mint - PostgreSQL 10*

1) Creare il file 'pgdg.list' alla locazione "/etc/apt/sources.list.d/" con il comando seguente:

```
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
```

2) Importare le chiavi della repository:

```
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
```

3) Eseguire gli aggiornamenti necessari per il corretto funzionamento eseguendo i comandi:

```
sudo apt-get update
sudo apt-get upgrade
```

4) Installare PostgreSQL 10 con il comando:

```
sudo apt-get install postgresql-10
```

5) Installare delle estensioni aggiuntive con il comando:

```
sudo apt-get install postgresql-contrib
```

Per quanto riguarda la versione 10 di PostgreSQL ci sono delle piccole modifiche per il settaggio della password principale

```
I comandi da digitare sono nell'ordine:
sudo su - postgres (da questo momento ci troviamo nel database di postgre)
psql
ALTER USER postgres WITH PASSWORD 'postgres';
\q (per terminare la procedura)
```

#### Install Centos 7

```
utilizzare yum al posto di apt-get
yum update -y
yum install https://download.postgresql.org/pub/repos/yum/9.5/redhat/rhel-7-x86_64/pgdg-centos95-9.5-2.noarch.rpm
yum install postgresql95-server postgresql95 -y
yum install postgresql95-server postgresql95-contrib
yum install php-pgsql -y
/usr/pgsql-9.5/bin/postgresql95-setup initdb
systemctl start postgresql-9.5.service
systemctl enable postgresql-9.5.restart
```

abilitare le porte dal firewall

```
firewall-cmd --permanent --add-port=8080/tcp
firewall-cmd --permanent --add-port=8443/tcp
firewall-cmd --reload
```

#### *Assign a password to user postgres*

In order to create the database the installer needs to know the password of user postgres, by default this user doesn't have a password in ubuntu (windows installer asks for a password).

Please take note of the password you assign here as it will be required in the setup process:

Steps are (replace your_chosen_password by your preferred):

```
sudo su - postgres
psql -U postgres -c "alter user postgres unencrypted password 'postgres'"
logout
```

Se non dovesse funzionare:

```
psql -U postgres -c "alter user postgres password 'postgres'"
```

#### Security

Dopo aver installato postgres è necessario verificare la corretta configurazione di pg_hba.conf.

Nota: **"versione_postgresql"** va modificato in base alla propria versione installata di PostgreSQL (ad esempio 10 o 9.6 ecc...).

Accedere con il seguente comando:

```
 sudo nano /etc/postgresql/"versione_postgresql"/main/pg_hba.conf
```

CENTOS:

```
sudo nano /var/lib/pgsql/"versione_postgresql"/data/pg_hba.conf
```

OpenSUSE:

```
sudo nano /var/lib/pgsql/data/pg_hba.conf
```

Configuriamo le seguenti voci in questo modo (modificare da peer a trust e da md5 a trust)):

```
local   all         all                               trust          
host    all         all         127.0.0.1/32          trust
```

Se vogliamo collegarci al database del server dalla nosta sede dobbiamo aggiungere l'IP Pubblico chiamante, aggiungendo la seguente linea (esempio nostro IP 188.228.172.189)

```
host    all         all         188.228.172.189/32     trust 
```

Salvare ed uscire

accedere successivamente a postgress.conf

```
 sudo nano /etc/postgresql/"versione_postgresql"/main/postgresql.conf
```

CENTOS:

```
 sudo nano /var/lib/pgsql/"versione_postgresql"/data/postgresql.conf
```

OpenSUSE

```
sudo nano /var/lib/pgsql/data/postgresql.conf
```

modificare la linea #listen_addresses = 'localhost' in:

```
listen_addresses = '*'     (Ricorda di togliere #)
```

Salvare ed uscire

Riavviare il servizio di postgresql:

```
invoke-rc.d postgresql restart
```

oppure

```
 cd /etc/init.d
 ./postgresql restart  
```

CENTOS:

```
systemctl restart postgresql-9.5
service network restart
```

OPENSUSE:

```
systemctl restart postgresql
```

//altrimenti se non funziona su debian 8 sudo -u postgres /etc/init.d/postgresql restart

##### Creazione dell'utente Adempiere

```
sudo su - postgres
psql -U postgres -c "CREATE ROLE adempiere SUPERUSER LOGIN PASSWORD 'adempiere'"
logout (in caso di fallimento del comando logout utilizzare 'exit')
```

**ATTENZIONE**: Sei non riusciamo accedere ad pgsql e lanciare i comandi potrebbe esserci un problema di cluster, do conseguenza dobbiamo disabilitarlo

```
https://blog.sleeplessbeastie.eu/2016/03/14/how-to-reload-postgresql-cluster/
```

##### Creazione del database idempiere

```
createdb  --template=template0 -E UNICODE -O adempiere -U adempiere idempiere
psql -d idempiere -U adempiere -c "ALTER ROLE adempiere SET search_path TO adempiere, pg_catalog"
```

## Install Mercurial

```
sudo apt-get install mercurial
```

## Salvataggio automatico Username e Password Mercurial

Impostiamo la password e username di Mercurial nel file 'hgrc', senza doverle digitare ogni qualvolta che si vuole fare il pull dal repository. Basta accedere al file hgrc nella seguente directory:

```
cd /etc/mercurial
sudo nano hgrc
```

inseriamo all'interno del file le seguenti impostazioni per il salavataggio della password:

```
[auth]
bb.prefix = https://bitbucket.org/consulnet/
bb.username = consulnet
bb.password = NOMEPASSWORD (ATTENZIONE!!! Inserire la password corretta)
[merge-tools]
internal:merge.binary = true # lies!
```

Adesso, ad ogni pull dal repository, non ci verrà più chiesto di inserire Username e Password.

## Oracle JDK 1.8 (fino versione 5.1)

Debian 8

```
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
```

Ubuntu /luinuxmint

```
// no per debian // sudo add-apt-repository ppa:webupd8team/java 
```

Lanciamo i seguenti comandi:

```
sudo apt-get update 
sudo apt-get install oracle-java8-installer
```

OPEN SUSE

```
sudo zypper install java-1_8_0-openjdk
```

---

## Oracle JDK 10 (da versione 6.1)

Debian 8

```
Download OpenJDK 10 dal sito https://jdk.java.net/10/
(wget https://download.java.net/java/GA/jdk10/10.0.2/19aef61b38124481863b1413dce1855f/13/openjdk-10.0.2_linux-x64_bin.tar.gz)
```

Decomprimi il file tar.gz

```
tar xzvf openjdk-10.0.2_linux-x64_bin.tar.gz 
```

Spostare l'archivio estratto nel punto in cui il sistema mantiene i JDK installati:

```
sudo mv jdk-10.0.2/ /usr/lib/jvm/java-10-openjdk-amd64/
```

Aggiungi la nuova alternativa Java:

```
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-10-openjdk-amd64/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-10-openjdk-amd64/bin/javac 1
```

Aggiorna le alternative java del tuo sistema e scegli JDK 10:

```
sudo update-alternatives --config java
```

Scegli quella corretta specificando il numero

---

## Oracle JDK 11 (da versione 6.2)

Debian 8

```
Download OpenJDK 11 dal sito https://jdk.java.net/11/
(wget https://download.java.net/java/GA/jdk11/13/GPL/openjdk-11.0.1_linux-x64_bin.tar.gz)
```

Decomprimi il file tar.gz

```
tar xzvf openjdk-11.0.1_linux-x64_bin.tar.gz 
```

Spostare l'archivio estratto nel punto in cui il sistema mantiene i JDK installati:

```
sudo mv jdk-11.0.1/ /usr/lib/jvm/java-11-openjdk-amd64/
```

Aggiungi la nuova alternativa Java:

```
sudo update-alternatives --install /usr/bin/java java /usr/lib/jvm/java-11-openjdk-amd64/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /usr/lib/jvm/java-11-openjdk-amd64/bin/javac 1
```

Aggiorna le alternative java del tuo sistema e scegli JDK 10:

```
sudo update-alternatives --config java
```

Scegli quella corretta specificando il numero

## Installazione iDempiere da sourceforge

Scaricare IDempiere-Server da sourceforge:

```
wget http://sourceforge.net/projects/idempiere/files.............
wget https://sourceforge.net/projects/idempiere/files/v5.1/daily-server/idempiereServer5.1Daily.gtk.linux.x86_64.zip
```

oppure l'installazione di Idempiere con la nostra Build Fragment:

```
scp -r -P 1022 root@213.136.91.67:/opt/build/idempiereServerAGGANCIO_FRAGMENT.zip  /directory_di_destinazione/
```

- (ATTENZIONE: In alcuni casi, potrebbe essere necessario inserire "wget --no-check-certificate .................." per poter scaricare il pacchetto da sourceforge)

```
sudo mkdir /opt/idempiere
sudo chmod 777 -R /opt 
apt-get install zip unzip
unzip (Nome_cartella_Scaricata).zip -d /opt/idempiere
mv /opt/idempiere/idempiere.gtk.linux.x86_64/idempiere-server /opt/idempiere
rm -R /opt/idempiere/idempiere.gtk.linux.x86_64
rm idempiereServer4.1Daily.gtk.linux.x86_64.zip 
```

La cartella 'idempiere-server' appena decompressa deve essere situata nel seguente percorso:

- [IMPORTANTE](http://192.168.178.102/index.php?title=IMPORTANTE&action=edit&redlink=1)

```
/opt/idempiere/idempiere-server
```


Non ci rimane che l'installazione. Come primo passo dobbiamo creare il database. Lanciamo il seguente comando all'interno della cartella 'idempiere-server'

```
cd /opt/idempiere/idempiere-server
./console-setup.sh
Java Home [/usr/lib/jvm/java-8-oracle]:   [invio] per confermare il path
iDempiere Home [/opt/idempiere/idempiere-server]:   [invio] per confermare il path
Key Store Password [myPassword]:   [invio] per confermare il path
(ON) Common Name [root]:   [invio] per confermare il path
(OU) Organization Unit [AdempiereUser]:   [invio] per confermare il path
(O) Organization [root]:   [invio] per confermare il path
(L) Locale/Town [MyTown]:   [invio] per confermare il path
(S) State []:   [invio] per confermare il path
(C) Country (2 Char) [US]  [invio] per confermare il path
(C) Country (2 Char) [US]  [invio] per confermare il path
Application Server Host Name [vps312309.ovh.net]:  localhost  oppure  IP della macchina
Application Server Web Port [8080]:  [invio] per confermare il path
Application Server SSL Port[8443]: p)DB Already Exists?(Y/N) [N]: [invio] per confermare il path
1. Oracle
2. PostgreSQL
```

Database Type [2] [invio] per confermare il path

Database Server Host Name [vps312309.ovh.net]: localhost


Settiamo i parametri del database (importante che il nome del database sia 'idempiere' e la password 'adempiere' per la lettura dei task) Dopo di ciò andiamo nella cartella 'utils' e lanciamo il comando

```
cd utils
./RUN_ImportIdempiere.sh
```

Installazione completata. Adesso se ritorniamo nella directory precedente e lanciamo il seguente comando, possiamo far partire il nostro iDempiere

```
./idempiere-server.sh
```

##### Installing UUID (required to apply some migration scripts)

For postgresql 9.1 and above

```
   Run the command CREATE EXTENSION "uuid-ossp" using psql
//non serve //    psql -d idempiere -U adempiere -c 'CREATE EXTENSION "uuid-ossp"'
```

##### Applying additional migration scripts

<http://wiki.idempiere.org/en/Upgrade_from_1.0c_to_2.0#Periodic_upgrade_within_same_version>

## Problema ALPN (Monitor Idempiere)

Può capitare che non si riesca ad accedere al Monitor di Idempiere per problema SSL ALPN

Tutto questo dipende dalla versione Java installata nella macchina. Dobbiamo scaricare il file ALPN adeguato alla versione Java e copiarlo all'interno della directory idempiere-server (/opt/idempiere/idempiere-server/alpn-boot.jar)

Guarda le versione: java -version

Scaricare il jar dal seguente link

```
https://mvnrepository.com/artifact/org.mortbay.jetty.alpn/alpn-boot
```

info

```
https://www.eclipse.org/jetty/documentation/9.4.x/alpn-chapter.html
```

## Start iDempiere

Eclipse uses so-called "launch configurations" to start a given piece of code using given plugins and given dependencies with given arguments etc. Some of these launch configurations are already preconfigured in the iDempiere workspace.

To start iDempiere try "Run -> Debug Configurations..." and choose what you want to start by selecting one of the launch configurations under "Eclipse Application":

install.app - lets you create an idempiere.properties file that contains the configuration for the server server.product - starts the zk webserver (needs an idempiere.properties file). swingclient.product - starts the swing client In the most developer versions the plugin list (the list of OSGi plugins that are needed to get the whole application running) is not well maintained all the time. You can go to the tab "Plug-Ins" and press the "Validate Plug-Ins" button to check that and press "Add Required Plug-Ins" to add the missing ones.

Then you can start the application.

##### Modifying the launch configuration

Sometimes I want to have different settings to work with different databases (e.g. test and production). I create a copy of the launch configuration "server.product". I rename the copy according to my needs, e.g. "myown-server.product". Then I go to the tab "Arguments" and add the following to the "VM Arguments" (the lower text field):

```
-DPropertyFile=myown-idempiere.properties
```

To create this file you can copy your idempiere.properties or you can even make a copied launch configuration of the "install.product".

You can change other things, e.g. you can add your own plugin to the "Plug-Ins" tab etc.
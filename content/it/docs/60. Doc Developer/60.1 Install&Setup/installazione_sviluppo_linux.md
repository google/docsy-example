# Installazione Sviluppo Linux

---

| Installazione Base Installazione Sviluppo Linux | [Download_Code](http://192.168.178.102/index.php/Download_Code) ⇒

The examples on this guide are using the following versions:

- Ubuntu 14.04.2 64 bits
- PostgreSQL 9.4.1 (it's also tested and working with version 8.4.22)
- PostgreSQL contrib (for UUID support)
- Mercurial Client 2.8.2
- OpenJDK 1.7.0_75 (for version 2.1 it requires it works with 1.6.0_34)
- Eclipse IDE for Java EE Developers 4.4.1 Luna (for version 2.1 it requires 3.7.2 Indigo)
- Mercurial Eclipse Plugin 2.0.0 (for Indigo it's tested with 1.9.1)
- Buckminster 4.4 (for Indigo it's tested with 3.7)

riferimenti

- <http://wiki.idempiere.org/en/Installing_iDempiere>
- <http://wiki.idempiere.org/en/Update_your_development_environment_zk7_branch#know_issue>
- <http://wiki.idempiere.org/en/Migration_Notes#Version_iDempiere_3.0>

But this guide can be used in other systems (even Windows) taking care of installing the corresponding packages and using corresponding commands. 

# **Installazione Base Linux**

## **Install Ubuntu**

Please refer to <http://www.ubuntu.com/download>

## **Install Postgresql 9.4.1**

#### *Ubuntu / LinuxMint (desktop)*

iDempiere can also run with Oracle 10G or 11G, and also with PostgreSQL 8.4 to 9.3, but for this tutorial we use postgresql 9.4.1 - see <http://www.postgresql.org/download/linux/ubuntu/> for details

```
echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - 
sudo apt-get update
sudo apt-get install postgresql-9.4
sudo apt-get install postgresql-contrib
```

#### *Debian 7*

```
echo "deb http://ftp.debian.org/debian wheezy-backports main" | sudo tee /etc/apt/sources.list.d/pgdg.list
wget --no-check-certificate https://www.postgresql.org/media/keys/ACCC4CF8.asc
apt-key add ACCC4CF8.asc
sudo apt-get update
apt-get -t wheezy-backports install postgresql-9.4
sudo apt-get install postgresql-9.4
sudo apt-get install postgresql-contrib
```

#### *Debian 8*

```
echo "deb http://apt.postgresql.org/pub/repos/apt/ jessie-pgdg main" | sudo tee /etc/apt/sources.list.d/pgdg.list
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add - 
sudo apt-get update
sudo apt-get install postgresql-9.5
sudo apt-get install postgresql-contrib
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

#### Security

Dopo aver installato postgres è necessario verificare la corretta configurazione di pg_hba.conf. Accedere con il seguente comando:

```
 sudo nano /etc/postgresql/9.4/main/pg_hba.conf
```

Configuriamo le seguenti voci in questo modo (da md5 a trust):

```
local   all         all                               trust
host    all         all         127.0.0.1/32          trust
```

Salvare ed uscire

```
 sudo nano /etc/postgresql/9.4/main/postgresql.conf
```

modificare la linea #listen_addresses = 'localhost' in:

```
listen_addresses = '*'  
```

Salvare ed uscire

Riavviare il servizio di postgresql:

```
sudo -u postgres /etc/init.d/postgresql restart
```

---

## Install Mercurial**

```
sudo apt-get install mercurial
```

---

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

---

## **Oracle JDK 1.8**

Debian 8

```
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee /etc/apt/sources.list.d/webupd8team-java.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/webupd8team-java.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
apt-get update
```

Ubuntu /luinuxmint

```
sudo add-apt-repository ppa:webupd8team/java 
```

idem per entrambi i sistemi

```
sudo apt-get update 
sudo apt-get install oracle-java8-installer
```

---

## Installazione iDempiere da sourceforge

Scaricare IDempiere-Server da sourceforge:

wget <http://sourceforge.net/projects/idempiere/files/devel-3.1/daily-server/idempiereServerDev3.1Daily.gtk.linux.x86_64.zip> (ATTENZIONE: In alcuni casi, potrebbe essere necessario inserire "wget --no-check-certificate .................." per poter scaricare il pacchetto da sourceforge)

```
sudo mkdir /opt/idempiere
sudo chmod 777 -R /opt 
apt-get install zip unzip
unzip idempiereServerDev3.1Daily.gtk.linux.x86_64.zip -d /opt/idempiere
```

La cartella 'idempiere-server' appena decompressa deve essere situata nel seguente percorso:

- [IMPORTANTE](http://192.168.178.102/index.php?title=IMPORTANTE&action=edit&redlink=1)

```
/opt/idempiere/idempiere-server
```

Non ci rimane che l'installazione. Come primo passo dobbiamo creare il database. Lanciamo il seguente comando all'interno della cartella 'idempiere-server'

```
./console-setup.sh
```

Settiamo i parametri del database (importante che il nome del database sia 'idempiere' e la password 'adempiere' per la lettura dei task) Dopo di ciò andiamo nella cartella 'utils' e lanciamo il comando

```
cd utils
./RUN_ImportIdempiere.sh
```

Installazione completata. Adesso se ritorniamo nella directory precedente e lanciamo il seguente comando, possiamo far partire il nostro iDempiere

```
./idempiere-server.sh
```

## SOLO SVILUPPO

---

## **Install TortoiseHG**

TortoiseHg è una toolkit grafica per la gestione dei repository. Non è un prerequisito fondamentale, ma se non si ha dimestichezza con i comandi da terminale per i VCS, è consigliata l'installazione ed utilizzo.

[Download di TortoiseHg](http://tortoisehg.bitbucket.org/download/index.html)

## **Install Eclipse Luna 4.4.1**

Opzionale la cartella di eclipse in /opt/eclipse

Download the corresponding version for your operating system from "Eclipse IDE for Java EE Developers"

For Ubuntu 14.04.2 64 bits I downloaded [Luna here](http://www.eclipse.org/downloads/download.php?file=/technology/epp/downloads/release/luna/SR2/eclipse-jee-luna-SR2-linux-gtk-x86_64.tar.gz)


On ubuntu the installation of eclipse is just uncompress it and is ready for usage, for the rest of the session let's suppose we uncompressed eclipse on a folder called $ECLIPSE_HOME

On Windows don't try to use the eclipse-installer. By default it places the plugins in the users home, but the ant-scripts require them to stay within the eclipse home.

The first time you run Eclipse it asks for the workspace folder, at this stage you can use the default workspace - it will be changed later.

#### Install Mercurial Eclipse Plugin 2.0.0

```
Eclipse Plugin: Eclipse Mercurial
```

You should install the EclipseMercurial Plugin. There is another good introduction about it. You can install it both from the Eclipse Marketplace (the new way; in the Help menu) or enter a new update site and choose the package "Mercurial Eclipse" (nothing else) (the longer established way).

------

OLD WAY

Seguendo le Following instructions from project: <http://www.javaforge.com/project/HGE>

- Open the eclipse just installed

- Navigate to Help > Install New Software

- Push the "Add" button

- Fill Name: Mercurial Eclipse

- Fill Location:

   

  http://cbes.javaforge.com/update

  - NOTE (by [Dirk Niemeyer](http://192.168.178.102/index.php?title=User:A42niem&action=edit&redlink=1)): I had problems with that Location and found <http://stackoverflow.com/questions/1629058/mercurial-eclipse-plugin> pointing to <http://mercurialeclipse.eclipselabs.org.codespot.com/hg.wiki/update_site/stable/>

- OK

- When the list of packages appears select

  - MercurialEclipse
    - The rest are not required

- Complete the installation pushing Next .... accepting the license and then Finish

#### Install Buckminster 4.4

Following instructions from project: <http://www.eclipse.org/buckminster/>

- Open the eclipse just installed

- Navigate to Help > Install New Software

- Push the "Add" button

- Fill Name: Buckminster

- Fill Location:

   

  http://download.eclipse.org/tools/buckminster/updates-4.4

  - NOTE: To work with iDempiere 2.1 you must use <http://download.eclipse.org/tools/buckminster/updates-3.7>

- OK

- When the list of packages appears select

  - Buckminster - Core
  - Buckminster - Maven support
  - Buckminster - PDE support
    - The rest are not required

- Complete the installation pushing Next .... accepting the license and then Finish

Now you have your prerequisites ready to receive the iDempiere sources


*This tutorial is brought to you by Carlos Ruiz from GlobalQSS. Feel free to improve directly or suggest using the Discussion tab.*

## **Setup in Eclipse**

<http://wiki.idempiere.org/en/Installation_in_Eclipse>

entrare specificando come workspace la directory /opt/repos/idempiere-italia

Poi bisogna configurare il Target Platform: andare su menu Window > Preferences > Plug-in Development > Target Platform (utilizzare il filtro per la ricerca della voce interessata….)


click sul bottone Add; selezionare Nothing: Start with an empty target definition e poi Next; inserire il nome “Adempiere Target Platform”; click su Add; selezionare Directory e poi Next; indicare il path della directory con variabile “${workspace_loc}/targetPlatform”, click su Finish, selezionare il targetPlatform creato e poi Apply; al momento della conferma, sicuramente darà un visualizzazione di errore di cartella inesistente: ignorare errore, se è possibile, verrà risolto con la materializzazione del progetto….

Materializing iDempiere project within Eclipse

Next step is to "materialize" the project. This means that all dependencies are downloaded from the internet.

Navigate to File > Import > Buckminster > Materialize from Buckminster MSPEC, CQUERY or BOM Push the "Next" button and fill the "Enter a URL ..." box (using the "Browse" button) with ".../org.adempiere.sdk-feature/adempiere.mspec" Here eclipse takes some time to review dependencies and after that you can push the "Finish" button Now is a good time to brew some coffee (better Colombian coffee) - Eclipse will download and configure the whole project and this can be time consuming.

Rebuild

After materializing you should first refresh all your projects (mark all projects and use the context menu). Then use "Project -> Clean..." and rebuild all projects. This takes a while and should clear away all error messages. Then I close the "doc" project to get rid of the last error message - it has some unresolved dependencies and is not used for compiling. If you use Java7 you have some hundred warning messages (but they are no real problems), if using Java6 there should be not many of these messages left.


When this step finishes it is recommended to close eclipse and take a backup of the $IDEMPIERE_REPOSITORY folder

Altri problemi : On Run Configuration, go to tab "Plug-ins", and click the button "Add Required Plug-ins". After that click the "Run" button. That should do the trick. - mostra testo citato -

## Installazione senza Eclipse (no ambiente di sviluppo

wget <http://sourceforge.net/projects/idempiere/files/v3.1/daily-server/idempiereServer3.1Daily.gtk.linux.x86_64.deb/download>

## **Creazione Database per Sviluppo (solo per istanze per Eclipse)**

riferimento <http://wiki.idempiere.org/en/Importing_DB_Seed_Manually>

#### Create adempiere user

```
sudo su - postgres
psql -U postgres -c "CREATE ROLE adempiere SUPERUSER LOGIN PASSWORD 'adempiere'"
logout
```

#### Create the idempiere database

```
createdb  --template=template0 -E UNICODE -O adempiere -U adempiere idempiere
psql -d idempiere -U adempiere -c "ALTER ROLE adempiere SET search_path TO adempiere, pg_catalog"
```

#### Installing UUID (required to apply some migration scripts)

For postgresql 9.1 and above

```
   Run the command CREATE EXTENSION "uuid-ossp" using psql
       psql -d idempiere -U adempiere -c 'CREATE EXTENSION "uuid-ossp"'
```

#### Import the seed

NOTE: il file Adempiere_pg.jar potrebbe non essere presente in /percorso/a/repository/org.adempiere.server-feature/data/seed . Nel caso il file sia assente lo si può scaricare da [questo link](https://sourceforge.net/projects/idempiere/files/binary.file/database/3.1/). Posizionarlo dove meglio aggrada, ed estrarlo sempre con il comando jar. I file si possono poi cancellare, nel momento in cui l'esito dei comandi è positivo Esempio:

```
jar xvf /home/<utente>/Adempiere_pg.jar
psql -d idempiere -U adempiere -f /home/<utente>/Adempiere_pg.dmp
```

Altrimenti si procede come da guida standard:

```
cd /tmp
jar xvf $IDEMPIERE_REPOSITORY/org.adempiere.server-feature/data/seed/Adempiere_pg.jar
psql -d idempiere -U adempiere -f Adempiere_pg.dmp
```

example

```
jar xvf /opt/repos/idempiere-italia/org.adempiere.server-feature/data/seed/Adempiere_pg.jar
```

#### Applying additional migration scripts

<http://wiki.idempiere.org/en/Upgrade_from_1.0c_to_2.0#Periodic_upgrade_within_same_version>

## **Start iDempiere**

Eclipse uses so-called "launch configurations" to start a given piece of code using given plugins and given dependencies with given arguments etc. Some of these launch configurations are already preconfigured in the iDempiere workspace.

To start iDempiere try "Run -> Debug Configurations..." and choose what you want to start by selecting one of the launch configurations under "Eclipse Application":

install.app - lets you create an idempiere.properties file that contains the configuration for the server server.product - starts the zk webserver (needs an idempiere.properties file). swingclient.product - starts the swing client In the most developer versions the plugin list (the list of OSGi plugins that are needed to get the whole application running) is not well maintained all the time. You can go to the tab "Plug-Ins" and press the "Validate Plug-Ins" button to check that and press "Add Required Plug-Ins" to add the missing ones.

Then you can start the application.

#### Modifying the launch configuration

Sometimes I want to have different settings to work with different databases (e.g. test and production). I create a copy of the launch configuration "server.product". I rename the copy according to my needs, e.g. "myown-server.product". Then I go to the tab "Arguments" and add the following to the "VM Arguments" (the lower text field):

```
-DPropertyFile=myown-idempiere.properties
```

To create this file you can copy your idempiere.properties or you can even make a copied launch configuration of the "install.product".

You can change other things, e.g. you can add your own plugin to the "Plug-Ins" tab etc.

## **Download repository iDempiere italia**

TUTTI I REPOSITORY VANNI POSIZIONATI IN : /opt/repos/...


repository idempiere (sorgenti) ( clone di quello ufficiale)

- attenzione dimensione superiore ad 1 GB

da tortoise fare il clone solo alla reviosione 1 ..o usare riga di comando

```
hg clone -r 1 https://bitbucket.org/consulnet/idempiere-italia
cd idempiere
hg pull -r 2000 -u
hg pull -r 4000 -u
hg pull -r 6000 -u
hg pull -r 8000 -u
hg pull -r 10000 -u
hg pull -u
```

repository plugin italia (sorgenti )

```
https://bitbucket.org/consulnet/idempiere-ita-plugin
```

cartella 2pack,plugin, reports e file ready to install (.jar /.sh .zip )

```
https://bitbucket.org/consulnet/idempiere-download
```

altri repository

Ritenute di Acconto

```
https://bitbucket.org/consulnet/plugin-withholding
```

<https://bitbucket.org/consulnet/bom-configurator>

Tema grafico

```
https://bitbucket.org/consulnet/plugin-theme
```

<https://bitbucket.org/consulnet/plugin-calendar>


OPZIONALI

Repository dei jasper reports

<https://bitbucket.org/consulnet/jreports>

---

## **Installazione di Jasper Report**

Se si vuole installare JasperReport su una macchina compatibile con ubuntu/debian, dalla cartella /opt/jasperstudio lanciare

```
wget http://sourceforge.net/projects/jasperstudio/files/JaspersoftStudio-6.1.1/TIBCOJaspersoftStudio_6.1.1.final_amd64.deb/download
```

Altrimenti procurarsi a mano un link per la propria distribuzione o controllare sui repository ufficiali e non (AUR, RPMForge, PPA...)
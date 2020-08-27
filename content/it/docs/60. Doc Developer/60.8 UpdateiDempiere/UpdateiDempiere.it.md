---
title: "Update iDempiere"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 42
pre: "<b>4.2 </b>"
---

* Fare un backup del database, (+ eventuale snapshot della VM)

* Assicurarsi che postgres sia attivo, possibilmente con nessuna connessione attiva al schema di iDempiere;

* Assicurarsi che l'application non sia attiva. Per verificare, con un terminale sulla macchina ospitante il server digitare:

   ```
   ps aux |grep idempiere-server.sh
   ```

   Se nel listato di output compare il processo di iDempiere come in immagine:


![Image](/home/idempiere/Scrivania/Migrazione wiki/COLONNA1/Aggiornamento istanza/ProcessoId.png)

Procedere a digitare il comando:

```
kill <numero-processo>
```


Dove il numero processo nell'esempio è 2386.

* Controllare che la connessione ad internet della macchina sia fluida (vedere wishing list sotto per proxy)

# Aggiornamento

---

## Aggiornamento Database

```
 Attenzione: è possibile fare un backup del database lanciando il comando RUN_DBExport.sh presente nella 
 cartella /percorso/al/server/idempiere/utils/ (solitamente /opt/idempiere/idempiere-server)
```

Per aggiornare il database, creare la cartella che conterrà gli script sh:

```
mkdir /opt/repos/updateDB
```

Gli script di aggiornamento dovrebbero essere situati nella cartella:

```
/opt/repos/idempiere-download/syncApplied/
```

Clonati dal repository idempiere-download. Se non presenti, clonare il repository usando hg:

```
 cd /opt/repos
 hg clone https://bitbucket.org/consulnet/idempiere-download
```

Copiare i file sh nella cartella updateDB, e da terminale lanciare il comandi dalla versione più antica alla più recente. Ad esempio:

```
 cd /opt/repos/idempiere-download/syncApplied
 cp -r . /opt/idempiere/idempiere-server/updateDB
 ./syncApplied2.1.sh    
 ./syncApplied2.1z.sh    
 ./syncApplied3.1.sh
```

Nell’aggiornamento del db, su terminale si potrebbero riscontrare degli errori; i log di riferimento da poter vedere si trovano sotto la cartella /tmp/

## Aggiornamento Application

Aggiornare l'application con il comando:

```
 cd /opt/idempiere/idempiere-server
 ./update.sh http://ci.idempiere.org/job/iDempiere2.1/ws/buckminster.output/org.adempiere.server_2.1.0-eclipse.feature/site.p2/
 ./update.sh http://ci.idempiere.org/job/iDempiere3.1/ws/buckminster.output/org.adempiere.server_3.1.0-eclipse.feature/site.p2/        (zk7)
 ./update.sh http://ci.idempiere.org/job/iDempiere4.1Daily/ws/buckminster.output/org.adempiere.server_4.1.0-eclipse.feature/site.p2/   (zk8)
```

## FAQ

---

D: "Mi dice che i script non hanno i permessi d'esecuzione. Cosa bisogna fare?"

R: Bisogna concedere i diritti d'esecuzione al sistema per il o i file con il comando:

```
chmod +x <file>
```

Oppure:

```
 chmod -R +x /percorso/alla/cartella/desiderata
```

Se si vuole concedere i permessi d'esecuzione a tutti i file nella cartella. Se anche il comando chmod da errori, non è stata seguita correttamente la procedura di installazione del server di iDempiere. Una workaround momentanea è quella di avviare il comando come root:

```
sudo chmod ......
```

----

## Wishing List

* Gli script sono stati ideati con in mente un server collegato ad internet senza richieste di autorizzazioni proxy. Se lanciati, gli script daranno errore HTTP 403 => Autorizzazione non concessa : Prevedere una situazione di rete proxata, e parametrizzare le credenziali di autorizzazione sia per gli script sh, sia per le classi scritte in java, che aggiornano l'application (issue a idempiere-core?)




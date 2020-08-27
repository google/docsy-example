---
title: "Plugin Attachment File System"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b>741. </b>"
---

# Plugin Attachment FileSystem

---

## Descrizione Plugin

Questa gestione permette di salvare su disco del server i file,  specificando il percorso tramite impostazioni di storage_provider e  parametri.

## Prerequisiti per l'installazione

Installare prima:

```
1) UtilPDF
```

## Istruzioni Plugin

1 ) Come prima cosa entriamo a livello di Client (es GardenWorld)

2) Impostiamo lo **Storage Provider**

impostare i seguenti campi:

```
 Name: dare un nome allo Storage Provider (es: StorageTest)
 Method :“ParamFolder” (serve per salvare gli allegati sul disco)
 Folder :immettere il percorso della cartella che avrà la funzione di “contenitore” degli  allegati (es:   /nomecartella1/nomecartella2) . In questo caso:  /opt/storage
```

3) Una volta creato lo Storage Provider, bisogna settarlo nel Client Info ( andare quindi su Client > Client Info).

[![Canc1.png](http://192.168.178.102/images/thumb/7/7a/Canc1.png/400px-Canc1.png)](http://192.168.178.102/index.php/File:Canc1.png)

nel campo Attachment Store immettere “StorageTest” (nome dello StorageProvider creato sopra)


 4) Andiamo nella maschera Attachment Para (qui viene parametrizzato il path per il salvataggio dell'allegato).

Esempio1 (con flag Sales Transaction attivo)

[![Canc2.png](http://192.168.178.102/images/thumb/5/5b/Canc2.png/400px-Canc2.png)](http://192.168.178.102/index.php/File:Canc2.png)

Esempio2 (con flag Sales Transaction disattivo)

[![Canc3.png](http://192.168.178.102/images/thumb/c/c4/Canc3.png/400px-Canc3.png)](http://192.168.178.102/index.php/File:Canc3.png)

Impostare i seguenti campi:

\- Table: tabella/maschera di riferimento dove viene applicato la  gestione degli allegati con parametrizzazione del path.Es.: C_Order →  (riguarderà la Maschera “Sales Order” e/o “Purchase Order”).Come faccio a  sapere se faccio riferimento alla maschera Sales Order o alla Purchase  Order in questo caso? Grazie al flag Sales Transaction descritto nel  punto successivo

\- Sales Transaction: flag per differenziare le transazioni di vendite  con gli acquisti; es. (C_Order) se flag attivo significa che ci si  riferisce alla maschera Sales_Order, nel path del folder name viene  visualizzato: \Consulnet\Cnet\Ordine_di_Vendita\etc.... altrimenti se il  flag non è attivo ci si riferisce alla maschera Purchase_Order -->  \Consulnet\Cnet\Ordine_di_Aquisto\etc....

\- Folder Name: parametri per la creazione del nome della cartella di salvataggio. In questo campo sono presenti dei prefissi:

[![Canc6.png](http://192.168.178.102/images/thumb/a/ad/Canc6.png/400px-Canc6.png)](http://192.168.178.102/index.php/File:Canc6.png)

Ogni tipo di parametro, deve essere separato da una ','I tre tipi di  parametri (Valore Fisso, Nome del campo, valori di sistema) possono  essere combinati in modo variegato (es: Fisso+campo+val.sistema oppure  campo+val.sistema+fisso).


 **Nota aggiuntiva**: perchè il prefisso P è importante? perchè con  esso posso distinguere il percorso differente tra transazioni di vendite  e transizioni di acquisti tramite il flag Sales Transaction (nel nostro  esempio la P è importante perchè cambiando il nome della cartella  differenzio l’Ordine_di_Vendita con l’Ordine_di_Acquisto).

Ricorda di creare due record differenti Es:

```
      P/Consulnet/Cnet/Ordine_di_Vendita/,VOrdine,FDocumentNo,SUSERNAME,.....
      P/Consulnet/Cnet/Ordine_di_Acquisto/,VOrdine,FDocumentNo,SUSERNAME,.....
```

**IMPORTANTE!!!**Chi parametrizza DEVE SAPERE se la tabella  considerata può avere o no il campo Sales Transaction (es: NON mettere  il flag attivo Sales Transaction nella tabella C_Payment perchè non è  una transazione di vendita e quindi non mi verrà considerata la  directory con il prefisso P)

5) A questo punto possiamo andare nella nostra maschera Sales-Order ed archiviare i nostri allegati

[![Canc4.png](http://192.168.178.102/images/thumb/8/8a/Canc4.png/400px-Canc4.png)](http://192.168.178.102/index.php/File:Canc4.png)

Diamo Ok e adesso il nostro file allegato verrà salvato nella seguente directory:

[![Canc5.png](http://192.168.178.102/images/thumb/3/39/Canc5.png/400px-Canc5.png)](http://192.168.178.102/index.php/File:Canc5.png)

Stessa cosa possiamo farla per la Purchase Order

## NextCloud

### Parametrizzazione

Supponiamo che l'utente "Pippo" debba salvare su NextCloud tutti gli  Ordini di Vendita (in formato PDF) del Business Partner "Jekko"  all'interno di una specifica directory, ad: es:  STORAGE_IDEMPIERE/Jekko/Offerta/. e questi ordini deve condividerli poi  all'utente "Amministrazione" del Business Partner in questione. Come  fare ciò? Vediamo i passaggi:

Innanzitutto andiamo nel BP Jekko e nella Tab "Contatto (Utente)"  andiamo ad inserire l'utente "Amministrazione". Nella parte inferiore  della Tab inseriamo le credenziali che desideriamo, così possiamo poi  comunicarle all'utente "Amministrazione" di Jekko, il quale potrà  accedere a Nextcloud e vedere tutti i file condivisi. Vediamo l'immagine  seguente:

[![NextCloud.png](http://192.168.178.102/images/thumb/e/ea/NextCloud.png/1000px-NextCloud.png)](http://192.168.178.102/index.php/File:NextCloud.png)


 Adesso possiano andare nella maschera "Attachment Para"

[![NextCloud1.png](http://192.168.178.102/images/thumb/e/ec/NextCloud1.png/1000px-NextCloud1.png)](http://192.168.178.102/index.php/File:NextCloud1.png)


 Adesso possiamo andare in un Ordine di Vendita e salvare i PDF:

[![NextCloud2.png](http://192.168.178.102/images/thumb/6/68/NextCloud2.png/1000px-NextCloud2.png)](http://192.168.178.102/index.php/File:NextCloud2.png)


 Vediamo il Risultato:

[![NextCloud3.png](http://192.168.178.102/images/1/1b/NextCloud3.png)](http://192.168.178.102/index.php/File:NextCloud3.png)

Posso creare più versioni dello stesso file, basta archiviarlo più  volte (es, file_1.pdf, file_2.pdf, file_3.pdf,.....). Nell'Archive  Viewer (Visualizzazione Archivio Allegati) posso visulizzare gli  allegati e i file archiviati che ho salvato (quelli con il flag  Default='Y'). Vedi immagine

[![NextCloud4.png](http://192.168.178.102/images/thumb/4/45/NextCloud4.png/1000px-NextCloud4.png)](http://192.168.178.102/index.php/File:NextCloud4.png)

Per la sincronizzazionee su NextCloud vedi il punto successivo.

### Installazione NextCLoud CLient su Debian 8 e Sincronizzazione

Aggiungi il repository Nextcloud in /etc/apt/sources.d/nextcloud.list

```
echo 'deb http://apt.jurisic.org/debian/ jessie main contrib non-free' >> /etc/apt/sources.list.d/nextcloud.list
```

Installa la chiave di rilascio del repository Nextcloud:

```
wget -q http://apt.jurisic.org/Release.key -O- | apt-key add -
```

Ed esegui apt-get update per scaricare l'elenco dei pacchetti.

```
apt-get update
```

Installa il server Nextcloud con:

```
apt-get install nextcloud-client
```

Crea uno script di shell per sincronizzare i tuoi dati (questo script  lo possiamo trvare anche sulla directory  /opt/repos/idempiere-download/Utility/Script/):

```
#!/bin/bash
echo "-------------------------------------"
echo " START: $(date)"
echo "-------------------------------------"
nextcloudcmd -v
echo "-------------------------------------"
echo " NextcloudCMD - Sincronizzazione Dati ..."
nextcloudcmd -u "UTENTE_NEXTCLOUD" -p "PASSWORD_NEXTCLOUD" -s /opt/storage/STORAGE_IDEMPIERE/ https://213.136.91.67:5443/remote.php/webdav/STORAGE_IDEMPIERE/
echo "-------------------------------------"
echo " END: $(date)"
echo "-------------------------------------"
exit 0
```

Dare tutti i permessi allo script .sh appena creato con

```
sudo chmod 777 -R NextCloud_Syncronize.sh
```

Crea un cronjob per sincronizzare i tuoi dati

```
crontab -e
```

Incolla la seguente riga:

```
#Sincronizzazione NextCloud, ogni 10 minuti, quando i minuti sono 00, 10, 20, 30, 40 e 50
*/10 * * * * /opt/scripts/NextCloud/NextCloud_Syncronize.sh > /opt/scripts/NextCloud/log.txt 2>&1
```

Verrà creato un file log con la data e ora di ultima esecuzione

## Funzionalità TIMBRO

---

### Modifiche all'AD

[![Attachment Stamp 1.png](http://192.168.178.102/images/e/e1/Attachment_Stamp_1.png)](http://192.168.178.102/index.php/File:Attachment_Stamp_1.png)
 Per aggiungere il pulsante del timbro sulla maschera/window  "Attachement", tramite packout, è stato modificato il record sulla  tabella ***AD_ToolBarButton***: la modifica riguarda la  customizzazione del pulsante tramite nuova classe java di gestione  attachment -- attivato il flag "Custimization" e dichiarato il "Service  Component Name" creato a livello di plug-in.
 E' stato seguito la procedura presente sul wiki ufficiale, qui di  seguito riportato, e adattato alle nostre esigenze:  [NF1.0_CustomWindowToolbarButton|<http://http://wiki.idempiere.org/en/NF1.0_CustomWindowToolbarButton>]

### Utilizzo

[![Attachment Stamp 2.png](http://192.168.178.102/images/8/86/Attachment_Stamp_2.png)](http://192.168.178.102/index.php/File:Attachment_Stamp_2.png)

## Funzionalità Archive Viewer

[![Attachment Stamp 3.png](http://192.168.178.102/images/thumb/d/d6/Attachment_Stamp_3.png/1180px-Attachment_Stamp_3.png)](http://192.168.178.102/index.php/File:Attachment_Stamp_3.png)

### Modifiche all'AD

Nuova variabile sul System Configurator: ***LIT_AD_Archive_JOIN*** ; viene utilizzato per aggiungere eventuali CASE sql per il filtro dell'Archive Viewer

### Utilizzo

1. **IMMAGINE__punto1:** l'elenco  delle tabelle/window viene popolato SOLO nel caso in cui ci fossero dei  documenti archiviati su quelle determinate tabelle/window; se risulta  vuoto, vuol dire che nessun documento è stato archiviato, su nessuna  window/tabella

2. **IMMAGINE__punto2:**

    campi  C_Project_ID, C_SalesRegion_ID, C_Campaign_ID, C_Activity_ID presenti su  differenti tabelle; vengono utilizzati come filtri in modalità CASE  sql, per ricerca più accurata dei documenti archiaviati. 

   - Vedi esempio su codice: [![Attachment Stamp 4.png](http://192.168.178.102/images/thumb/0/02/Attachment_Stamp_4.png/980px-Attachment_Stamp_4.png)](http://192.168.178.102/index.php/File:Attachment_Stamp_4.png)


 Inoltre vengono visualizzati gli attachment salvati

[![Timbro.png](http://192.168.178.102/images/e/e1/Timbro.png)](http://192.168.178.102/index.php/File:Timbro.png)

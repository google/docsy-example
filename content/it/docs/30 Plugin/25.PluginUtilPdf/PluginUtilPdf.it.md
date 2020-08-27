---
title: " Plugin: Util Pdf 123"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b> </b>"
---



## Riferimenti

- link pubblico  : non applicabile
- link idempeire italia  : <https://bitbucket.org/consulnet/idempiere-ita-plugin> - it.cnet.impl.utilPDF
- link jar  : /opt/repos/idempiere-download/plugin-italia/UtilPDF/
- versione idempiere  : idempiere 4.1
- versione zk supportata : zk8

## Descrizione Plugin

```
l'obiettivo è quello di poter integrare le stampe prodotte da iDempiere 
```

- Report interni
- Jasper Report


con le seguenti metodologie :

- aggiungendo (merge) un pdf in cima e/o in fondo
- sovrapponendo (watermark) un pdf alla/e pagina/e stampata

## Parametrizzazione Plugin

- **Per spedizioni via mail di -Report interni- (quindi che utilizzano il PrintFormat):** si parametrizza il nome del file .pdf nel campo 'Description' nella window *Print Format*, come da esempio: "**OrderForBP @c_bpartner.name@ Date: @DateOrdered@**"
- **Per spedizioni via mail di -Jasper Report- (quindi report allegati nella maschera Report & Process):** si parametrizza il nome del file .pdf nel campo 'Description' nella window *Report & Process* a livello System, come da esempio: "**PARAM:OrderForBP @c_bpartner.name@ Date: @DateOrdered@**" **N.B.** è essenziale che ci sia la parola chiave "PARAM:", che permette di comporre il nome del file....

## Documentazione Tecnica Plugin

### Modifiche all'AD / Classi Java

1. Nuova tabella

```
CREATE TABLE lit_additionaldocspdf (
   ad_client_id numeric(10,0) NOT NULL,
   ad_field_a_id numeric(10,0) DEFAULT NULL::numeric,
   ad_field_a_key character varying(100) DEFAULT NULL::character varying,
   ad_field_b_id numeric(10,0) DEFAULT NULL::numeric,
   ad_field_b_key character varying(100) DEFAULT NULL::character varying,
   ad_field_c_id numeric(10,0) DEFAULT NULL::numeric,
   ad_field_c_key character varying(100) DEFAULT NULL::character varying,
   ad_org_id numeric(10,0) NOT NULL,
   ad_tab_a_id numeric(10,0) DEFAULT NULL::numeric,
   ad_tab_b_id numeric(10,0) DEFAULT NULL::numeric,
   ad_tab_c_id numeric(10,0) DEFAULT NULL::numeric,
   ad_window_id numeric(10,0) DEFAULT NULL::numeric,
   binarydata bytea,
   created timestamp without time zone DEFAULT statement_timestamp() NOT NULL,
   createdby numeric(10,0) NOT NULL,
   description character varying(255) DEFAULT NULL::character varying,
   help character varying(2000) DEFAULT NULL::character varying,
   isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
   jasperprocess_id numeric(10,0) DEFAULT NULL::numeric,
   lit_additionaldocspdf_id numeric(10,0) NOT NULL,
   lit_additionaldocspdf_uu character varying(36) DEFAULT NULL::character varying,
   name character varying(60) NOT NULL,
   note_a character varying(255) DEFAULT NULL::character varying,
   note_b character varying(255) DEFAULT NULL::character varying,
   note_c character varying(255) DEFAULT NULL::character varying,
   pdfmethod character varying(60) DEFAULT NULL::character varying,
   positionadditional character(1) DEFAULT NULL::bpchar,
   prioritypdf numeric(10,0) DEFAULT 1,
   updated timestamp without time zone DEFAULT statement_timestamp() NOT NULL,
   updatedby numeric(10,0) NOT NULL,
   value character varying(40) NOT NULL,
   CONSTRAINT lit_additionaldocspdf_isactive_check CHECK ((isactive = ANY (ARRAY['Y'::bpchar, 'N'::bpchar])))
);
```

#### Tables / Windows esistenti

#### Nuove Tables /Windows

### Caso Merge

2° Parte del

Esigenza 1) Devo aggiungere in fondo al reporto dell'offerta il pdf contenente le condizioni generali di vendita.

Esigenza 2) Devo aggiungere in fondo al reporto dell'offerta il pdf contenente le condizioni generali di vendita.

```
            ma il BP MARCO ha una pdfA e il BP ANDREA un un pdfB
```

Archivio di documento PDF per

| AD_Window_ID | AD_Tab_ID | AD_Field_ID | Value       | AD_Tab_ID | AD_Field_ID | Value | AD_Tab_ID | AD_Field_ID | Value | Priority | AD_Process(JasperID) | Metodo | Where (Before/After) | PDF (image ?) |
| ------------ | --------- | ----------- | ----------- | --------- | ----------- | ----- | --------- | ----------- | ----- | -------- | -------------------- | ------ | -------------------- | ------------- |
| SALES ORDER  | HEADER    | BP          | 102-'MARCO' |           |             |       |           |             |       | 10       | OFFERTA003           | Merge  | After                | (BLOB)del PDF |
| SALES ORDER  | orderline | PRODUCT     | 101-TAVOLO  |           |             |       |           |             |       | 100      | OFFERTA003           | Merge  | After                | (BLOB)del PDF |

---

## Print Batch - Direct Print

ATTENZIONE (Nota Tecnica) - Installare anche il plugin Order Template per far funzionare la parte di stampa diretta (aggiunto nell'Order Template la gestione del ContextClassLoader)

---

## Installazione PrintServer

Scompattare il file zip in una propria directory a piacimento. Recuperare il file della seguente directory:

```
/opt/repos/idempiere-download/plugin-italia/DirectPrinting/
```

Installare la stampante che andremo ad utilizzare nel proprio pc (il print server può utilizzare anche una seconda stampante)

Lanciare "ZeNFilePrintServer.jar": Apri con --> Oracle Java (il printserver parte inizialmente in automatico)

Se vogliamo **lanciare il comando da shell di linux** senza aprire il Display:

```
(apt-get install xvfb)
sudo xvfb-run -a java -jar ZeNFilePrintServer.jar
```

**Lancio automatico del Print Server?** Scaricare il file "printdirect.sh" (sempre nella directory /opt/repos/idempiere-download/plugin-italia/DirectPrinting/) e copiarlo dentro /etc/init.d/ (lanciare poi update-rc.d printdirect.sh defaults). In questo modo, il DirectPrint parte all'avvio del pc

Impostare la stampante (anche la seconda se si vuole) e il percorso di dove il documento viene preso per essere salvato(stoppare il servizio prima di tutto). Ravviare poi il tutto.


[{{< figure src="/image/PluginUtilPDF-Print.png" title="s" width="815"  >}}](/image/PluginUtilPDF-Print.png)

Nel file "server.ini" possiamo impostare il formato di stampa (esempio fileExtentionFilter=pdf) ed i secondi di attesa prima che la stampa avvenga.

Se inseriamo il file all'interno del File Path selezionato, ovviamente con il formato impostato nel file "server.ini", il Print Server stamperà il file per poi cancellerlo definitivamente.

---

## Parametrizzazione iDempiere

Video 3 - Parametrizzazione: <https://drive.google.com/drive/folders/0B3alx2W3koD6U19GVHFIWEg3TGs>

Come prima cosa dobbiamo installare il plugin UtilPDF

### GESTIONE OLD (PrintServer Zenit)

All'interno del plugin UtilPDF viene gestita una parte riguardante il Direct Print.

Da directory /opt/repos/idempiere-download/plugin-italia/DirectPrinting/ installare il **2packSystem_DirectPrint.zip**

In questo 2pack viene concatenato il processo PrintBatch (utilizzato nel plugin utilPDF) con il processo di copiaFile sul server remoto di dove risede il PrintBatch di stampa automatica (creato processo Talend). Così possiamo lanciare direttamente da menu il "**Direct Print**" (salva pdf e copialo in locale)



[{{< figure src="/image/PluginUtilPDF-PrintBatch.png" title="s" width="815"  >}}](/image/PluginUtilPDF-PrintBatch.png)

viene copiato un file (es:.pdf) da /opt/storage/PrintBatch/(remoto) a /opt/storage/PrintBatch (locale)

Questo processo possiamo schedularlo

Per quanto riguarda il plugin UtilPDF abbiamo 2 Gestioni. Vediamole insieme

### 1) DIRECT PRINT

Stampa il documento direttamente dal processo di Stampa della Toolbar


[{{< figure src="/image/PluginUtilPDF-DirectPrint1.png" title="s" width="815"  >}}](/image/PluginUtilPDF-DirectPrint1.png)


Vediamo come parametrizzare, andiamo sul processo aggangiato alla Tab ed impostiamo il campo DirectPrint="Y", subito dopo dovremo agganciare il PrintFormat della stampante. IN questo Print Format è importante specificare il Nome della Stampante ed il processo Jasper di stampa.

[{{< figure src="/image/PluginUtilPDF-DirectPrint2.png" title="s" width="815"  >}}](/image/PluginUtilPDF-DirectPrint2.png)



[{{< figure src="/image/PluginUtilPDF-DirectPrint3.png" title="s" width="815"  >}}](/image/PluginUtilPDF-DirectPrint3.png)



### 2) PRINT BATCH

E' stata creata una View template (nome view:lit_batchprint_v). In questa vista sono stati impostati determinati parametri che consentono di selezionare e copiare alcuni report PDF (nel nostro caso C_Order e C_invoice) in una directory a nostro piacimento oppure ci consente di stampare direttamente sullastampante installata nel nostro server (utilizzare Cups per installare le stampanti)


[{{< figure src="/image/PluginUtilPDF-Print1.png" title="s" width="815"  >}}](/image/PluginUtilPDF-Print1.png)

Impostiamo la directory di salvataggio del nostro file

Entriamo a livello Client ed andiamo nella maschera "**Printer**"

IL nostro file pdf verrà salvato all'interno della seguente directory (se specifichiamo il path nel campo "Folder") oppure ci stamperà nella stampante direttamente (ovviamente deve avere lo stesso nome specificato al momento dell'installazione):

[{{< figure src="/image/PluginUtilPDF-Print3.png" title="s" width="815"  >}}](/image/PluginUtilPDF-Print3.png)



Sempre a livello Client, accediamo alla maschera "**Direct Print**" ed inseriamo le informazioni che ci interessano:

[{{< figure src="/image/PluginUtilPDF-Print2.png" title="s" width="815"  >}}](/image/PluginUtilPDF-Print2.png)



Campo:

```
Field1 --> come possiamo vedere dalla vista sopra, verrà presa in considerazione il report PDF della Invoice (Customer) che abbia la Desrizione=test 
(ovviamente è un esmpio questo, possiamo modificare la vista in base alle nostre esigenze)
```

**ATTENZIONE!!!** Nel Report&Process Dobbiamo impostare il campo Direct Print="Y" e Print Batch="Y" del nostro report preso in considerazione

[{{< figure src="/image/PluginUtilPDF-Print4.png" title="s" width="815"  >}}](/image/PluginUtilPDF-Print4.png)



Infine è possibile schedulare il nostro processo di "Print Batch" maunalmente (aggiungendo un Process da Menu) oppure automaticamente (tramite lo Scheduler)

### Modifiche all'AD

Creare vista per elenco stampa da eseguire in batch :

```
-- View: lit_batchprint
-- DROP VIEW lit_batchprint;
CREATE OR REPLACE VIEW lit_batchprint_v AS 
SELECT o.c_order_id as record_id,
   '259' as table_id,
   issotrx as issotrx,
   o.isprinted as isprinted,
   o.ad_user_id as ad_user_id,
   docstatus as field1
   from c_order
   where o.issotrx='Y'  and docstatus='C' and isprinted='N'
union 
SELECT i.c_invoice_id as record_id,
   '318' as table_id,
   issotrx as issotrx,
   o.isprinted as isprinted,
   o.ad_user_id as ad_user_id,
   docstatus as field1
  from c_invoice
   where o.issotrx='Y'  and docstatus='C' and isprinted='N'
ALTER TABLE lit_batchprint_v
 OWNER TO adempiere;
```

```
TABLE LIT_DIRECTPRINT + Window
table_id
issotrx
Process_id (jasper)
LIT_Printer 
Ad_user_ud
field1
```

```
TABLE LIT_PRINTER + Window
lit_printer_id
Name 
Folder
```

## **Installazione Stampante da Linux NO-Desktop (solo command-line)**

## Installare server CUPS

Per installare la stampante nel nostro "print-server debian"(no desktop) dobbiamo installare il server CUPS

```
sudo apt install cups
```

potremo quindi installare la stampante da un qualsiasi PC-desktop collegato nella stessa rete del "print-server debian"

Fondamentale installare poi:

```
sudo apt-get update
sudo apt-get install lpr
apt install task-print-server   (importante, altrimenti la stampa sul server non Funziona)
```

Dobbiamo modificare il file di configurazione CUPS

```
/etc/cups/cupsd.conf
```

impostiamo sia l'indirizzo IP (al posto di localhost) sia i permessi. Vediamo un esempio:

```
LogLevel warn
MaxLogSize 1m
SystemGroup lpadmin
DefaultEncryption Never
# Allow remote access
Port 8082
Listen /var/run/cups/cups.sock
Listen localhost:631
Browsing On
BrowseLocalProtocols dnssd
DefaultAuthType Basic
WebInterface Yes
<Location />
 # Allow remote access...
 Order allow,deny
 Allow all
</Location>
<Location /admin>
</Location>
<Location /admin/conf>
 AuthType Default
 Require user @SYSTEM
</Location>
<Policy default>
 JobPrivateAccess default
 JobPrivateValues default
 SubscriptionPrivateAccess default
 SubscriptionPrivateValues default
 <Limit Create-Job Print-Job Print-URI Validate-Job>
   Order deny,allow
 </Limit>
 <Limit Send-Document Send-URI Hold-Job Release-Job Restart-Job Purge-Jobs Set-Job-Attributes Create-Job-Subscription Renew-Subscription Cancel-Subscription Get-Notifications Reprocess-Job Cancel-Current- Job Suspend-Current-Job Resume-Job Cancel-My-Jobs Close-Job CUPS-Move-Job CUPS-Get-Document>
   Require user @OWNER @SYSTEM
   Order deny,allow
 </Limit>
 <Limit CUPS-Add-Modify-Printer CUPS-Delete-Printer CUPS-Add-Modify-Class CUPS-Delete-Class CUPS-Set-Default CUPS-Get-Devices>
   AuthType Default
   Require user @SYSTEM
   Order deny,allow
 </Limit>
 <Limit Pause-Printer Resume-Printer Enable-Printer Disable-Printer Pause-Printer-After-Current-Job Hold-New-Jobs Release-Held-New-Jobs Deactivate-Printer Activate-Printer Restart-Printer Shutdown-Printer Startup-Printer Promote-Job Schedule-Job-After Cancel-Jobs CUPS-Accept-Jobs CUPS-Reject-Jobs>
   AuthType Default
   Require user @SYSTEM
   Order deny,allow
 </Limit>
 <Limit Cancel-Job CUPS-Authenticate-Job>
   Require user @OWNER @SYSTEM
   Order deny,allow
 </Limit>
 <Limit All>
   Order deny,allow
 </Limit>
</Policy>
<Policy authenticated>
 JobPrivateAccess default
 JobPrivateValues default
 SubscriptionPrivateAccess default
 SubscriptionPrivateValues default
 <Limit Create-Job Print-Job Print-URI Validate-Job>
   AuthType Default
   Order deny,allow
 </Limit>
 <Limit Send-Document Send-URI Hold-Job Release-Job Restart-Job Purge-Jobs Set-Job-Attributes Create-Job-Subscription Renew-Subscription Cancel-Subscription Get-Notifications Reprocess-Job Cancel-Current-Job Suspend-Current-Job Resume-Job Cancel-My-Jobs Close-Job CUPS-Move-Job CUPS-Get-Document>
   AuthType Default
   Require user @OWNER @SYSTEM
   Order deny,allow
```

Adesso restartiamo il servizio:

```
sudo systemctl restart cups.service
```

oppure:

```
cd /etc/init.d   --> service cups restart
```

## Installare stampante/i da server CUPS attraverso pc desktop

Bene adesso apriamo il browser di un pc-desktop e digitiamo:

```
http://172.16.1.109:631/admin
```


[{{< figure src="/image/PluginUtilPDF-CUPS.png" title="s" width="815"  >}}](/image/PluginUtilPDF-CUPS.png)

Installiamo stampante, premiamo su "Find new printer" (stampante presente in rete) e procediamo con l'installazione, impostiamo il nome e poi il driver che vogliamo installare (**ATTENZIONE**: nel caso in cui il driver della stampante non ci fosse, scaricarlo ed installarlo sul server). Fondamentale salvarsi il nome della stampante che gli abbiamo dato (ci servirà poi)


[{{< figure src="/image/PluginUtilPDF-CUPS1.png" title="s" width="815"  >}}](/image/PluginUtilPDF-CUPS1.png)


Dopo aver concluso l'installazione, se andiamo su "Manage Printer" possiamo visualizzare le stampanti installate


[{{< figure src="/image/PluginUtilPDF-CUPS2.png" title="s" width="815"  >}}](/image/PluginUtilPDF-CUPS2.png)


**ATTENZIONE**! Non abbiamo finito, dobbiamo inizialmente settare quale sia la stampante di default altrimenti il nostro PrintDirect non funzionerà. Come fare? Ritorniamo innanzitutto nel nostro pc "print-direct debian" e digitiamo il seguente comando per impostare una stampante di default:

```
export PRINTER=nomestampante 
(esempio: export PRINTER=Samsung_CLX-3180)
```

Per verificare se la seguente stampante è stata impostata come default digitare:

```
lpstat -d
```

Bene, la stampante è stata settata. Adesso possiamo ritornare nella sezione precedente, unzippare il presente in /opt/repos/idempiere-download/plugin-italia/DirectPrinting/ZeNFilePrintServerV1.1.zip e procedere con la configurazione (ricorda di impostare nel file config.xml il nome della stampante installata qui)

**NON FUNZIONA??**

Installare l'ambiente LXDE in Debian, questo perchè potrebbero mancare delle componenti di installazione

```
apt-get install lxde
```

Verifichiamo che la stampa automatica adesso funzioni correttamente. Possiamo poi cancellare la parte lxde, ci è servita solamente per far partire la stampante la prima volta (sudo apt-get --purge autoremove lxde)

---

## **Installare stampante/i da server CUPS da remoto a locale**

Come prima cosa dobbiamo creare una NAT della stampante che vogliamo utilizzare.

Esempio: l'indirizzo locale della stampante Samsung è 172.16.3.4:9100 --> entriamo nel Firewall e facciamo la NAT in 188.228.172.189:3022. Vedi immagine:


[{{< figure src="/image/PluginUtilPDF-NATStampante.png" title="s" width="815"  >}}](/image/PluginUtilPDF-NATStampante.png)


Facciamo un test di stampa nel server remoto per vedere se funziona --> telnet 188.228.172.189 3022

Adesso possiamo impostare la stampande di default direttamente nel server CUPS: aggiungiamo una stampante, selezioniamo

```
Internet Printing Protocol (ipp)
```

e successivamente inseriamo

```
socket://188.228.172.189:3022
```

Completiamo il tutto e adesso la nostra stampante è collegata al server remoto

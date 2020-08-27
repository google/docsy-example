---
title: "Installazione e Setup"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 600
pre: "<b>60.1.1 </b>"
---

# Distro 2 

---

## **Download Repository iDempiere-Download**

Dopo aver fatto l'installazione da mercurial, dobbiamo fare il pull della cartella 'idempiere-download' da Bitbucket. Attenzione: importante che la cartella 'idempiere-download' venga collocata all'interno della directory /opt/repos/. Quindi eseguiamo il seguente comando:

 `````````
sudo mkdir /opt/repos
sudo chmod 777 -R /opt/repos
cd /opt/repos 
hg clone https://[user]:[pwd]@bitbucket.org/consulnet/idempiere-download
 `````````

### Aggiornamenti Repository

per consentirci di utilizzare il TASK LIST (Initial CLient Setup Custom)

installare l'expect

```
sudo apt-get install expect
```

in alcune vm potrebbe non esserci il telnet, se non ci fosse, instalalrlo

```
sudo apt-get install telnet
```

Creare la cartelle storage all'interno della directory opt

```
sudo mkdir /opt/storage 
```

(Questa ci serve nel plugin Attachment File System)

Ricordarsi di abilitare i permessi con il seguente comando

```
sudo chmod -R 777 * /opt/storage
```

### SyncApplied del DB

# **SETUP SERVER MANUALE**

---

## Modifica password accesso

---

IMPORTANTE Cambiare la password di :

```
SuperUser
System (utilizzare window - Reset Password)
GardenAdmin
GardenUser
WebServices
```

## Setup lingua ITA - EN

---

Login dal sistema con ruolo di System/System Administrator.
Aprire la maschera: 

```
Menu -> System Admin -> General Rules -> System Rules -> '''Language'''
Ricerca per nome = it%
```

Modificare:

```
Attivare la checkbox chiamata --> System Language 
Attivare la checkbox chiamata --> Login Locale
Inserire 'dd.MM.yyyy' nel campo 'Date Pattern' per mostrare la data (esempio 
'31.12.2011').
Print Paper: A4 Portrait
Salvare la configurazione e attivare 'Language Maintenance'
```

Abilitiamo la lingua "en_GB"

```
Attiviamo solamente la checkbox chiamata --> System Language
Salvare la configurazione e attivare 'Language Maintenance'
```

#### Aumentare Lunghezza campi

**ATTENZIONE!! COME PRIMISSIMA COSA È IMPORTANTE CONTROLLARE LA LUNGHEZZA DI ALCUNI CAMPI:**

```
1)AD_Rule.Script lunghezza=8.000
2)AD_Package_Exp_Detail.SQLStatement lunghezza=6.000
3)AD_CtxHelpMsg.MsgText lunghezza=8.000
4)AD_CtxHelpMsg_Trl.MsgText lunghezza=8.000
Se così non fosse, andare su application in System e modificare+sincronizzare il campo in questione'''
```

#### Importazione Menu

Subito dopo importiamo il '''2packSystem_Menu''' (menù modificato con aggiunta di alcune voci di tipo IDEMPIERE CONSULTING + aggiornamenti sulla tabella ad_trenoodemm, tabella che consente l'ordinamento e l'aggancio alle voci di menu).

Il 2packSystem_Menu lo possiamo trovare nel repository idempiere-download/initialclientsetup/

Su iDempiere, con utenza di SuperUser, andiamo sulla maschera "Pack In" e lo installiamo manualmente.

Parte tecnica di come creare ed esportare il menu: http://188.228.172.188/index.php/Importazione_Menu

#### Importazione traduzioni ITA

Adesso importiamo le traduzioni in italiano (it_IT_Export.zip presente all'interno del seguente percorso: /opt/repos/idempiere-download/initialclientsetup) --> file it_IT_Export.zip

Sempre da System Administrator apriamo la window Translation Import/Export

```
 selezioniamo 'Italian' nella selectbox  'Language' e importiamo lo ZIP 'it_IT_trl_20151222' (o eventuale data più recente)
```

clicchiamo su :

```
IMPORT ZIP   
```

Al termine dell'importazione lanciamo :
da Menu  : ''''Syncronize Terminology''''

## Installazione Plugin InitialClientSetup e relativo 2pack

---

Andiamo nella console di Felix e installiamo il plugin 

```
 cartella : /opt/repos/idempiere-download
 it.cnet.impl.InitialClientSetup_Custom.jar
```

 cartella : /opt/repos/idempiere-download
 it.cnet.impl.InitialClientSetup_Custom.jar

presente all'interno della cartella 'idempiere-download'

Entriamo come System Administrator e nella maschera 'pack-in' installiamo il 

```
 2packSystemManuale(InitialClient+Task).zip
```

presente sempre nella cartella di 'idempiere-download'. Questo 2pack ci consente di visualizzare:

- tutti i 2pack da installare tramite la maschera 'Initial Client Setup Custom_SYSTEM' e 'Initial Client Setup Custom_CLIENT' (rispettivamanete a livello di System e di Client)

- tutti i processi da lanciare all'interno della maschera 'Process Task List' (solamente a livello di System)

## Initial Client Setup Process Custom_SYSTEM

---



**ATTENZIONE!! IMPORTANTE RESTARTARE L'APPLICATION dopo che si è installato il 2packSystemBase --> questo per rendere effettiva la syncronizzazione di alcuni campi**

All'interno di questa maschera (ovviamente login a livello di System) possiamo installare i relativi 2pack che ci interessano. Vediamo qualche esempio:

- **OBBLIGATORI**

* 2pack_System base  [[2PackSystemBase]]  AGGIUNG I CAMPI ITA 

* 2Pack_CountryRegion Carica i comuni d'italia

* 2packSystemBase_Fragment -- Aggiunta Campi per i plug-in fragment patch 'idIta.modification. .....' (new)

* 2PackTask(SQL)   CREA la lista della TASK LIST

* 2PackTask(PLUGIN) CREA la lista dei PLUGIN

- **FACOLTATIVI**

* 2Pack_Reports_Base 

* 2Pack _Reports_Base2

* 2Pack_Asset_ITPassword

## Install Plug-in Fragment Patch "idIta.modificatiom.*"

---

**RICORDA: ASSICURARSI CHE SIA STATO FATTO UN RESTART DELL'APPLICATION dopo che si è installato il 2packSystemBase --> questo per rendere effettiva la syncronizzazione di alcuni campi**

I Plug Fragment Patch sono essenziali per delle customizzazioni dirette sul core di iDempiere.</br>
I jar in questione risiedono sotto idempiere-download/plugin-italia/idItaModification; bisogna installarli via console di Felix e una volta installati, bisogna fare degli "update" singoli dei plug-in host. Per esempio:

* idIta.modification.org.adempiere.base_....jar ----> ricercare nella console il plug-in org.adempiere.base e cliccare sul pulsantino di destra di "update" (....il terzo...); una volta fatto ciò, assicurarsi sempre nel plug-in host sia agganciato il fragment in questione

## Installare il Tema con relativi loghi

---

http://188.228.172.188/index.php/Home_Page_Custom_%2B_Theme

## Process Task List

---

All'interno di questa maschera (ovviamente login a livello di System) possiamo lanciare 

Importante lanciare i taskSystem(SQL) prima dell'installazione dei Plugin. Vediamo di seguito:

- Lanciamo tutti i task SQL (potrebbe essere necessario riavviare 'idempiere-server' per vedere le modifiche apportate)

- DA FARE OGNI VOLTA CHE SI INSTALLA UN PLUGIN 

   ```
   Installazione PLUGIN (CREA LISTA INIZIALE)
   ```

   Questo task è importante per l'installazione dei plugin. 
   Esso deve essere lanciato: 
   *1) ogni volta che si installa una serie consecutiva di plugin; 
   *2) ad ogni aggiornamento (anche di un solo plugin); 3) ad ogni cancellazione (anche di un solo plugin)

- Lanciamo i task di 'Installazione PLUGIN' che ci interessano

**CONSIGLIATI** :

```
PLUGIN "ResourceAttendance"
PLUGIN "PaymentTerm"
PLUGIN "Witholding" [[Plugin_Ritenute]]
PLUGIN "Contract" [[Plugin_Contratto]]
PLUGIN "NatIDNumber" [[Plugin_Codice_Fiscale]]
PLUGIN "Letter Intent" [[Plugin_Lettera_d'intento]]
PLUGIN "LIT_GLJournal" [[Plugin_Contabilità]]
PLUGIN "LIT_RIBA"  [[Plugin_RIBA]]
PLUGIN "LIT_VATJournal" [[Plugin_VAT_Journal]]
PLUGIN "CopyCustomColumn" [[Plugin_Copia_Impostazioni_Griglia]]
PLUGIN "AttachmentFileSystem" [[Plugin_Lettera_d'intento]]
PLUGIN "OrderTemplate" 
PLUGIN "Kanban Dashboard" [[Plugin_KanbanDashboard]]
PLUGIN "ADAXA Mobile" [[Plugin_ADAXA_Mobile]]
PLUGIN "Broadcaster Events"
PLUGIN "JPiere Simple Input Window"
PLUGIN "Caldav Cardav"
PLUGIN "Zoom from URL"
```

# **INSTALLAZIONE CLIENT**

---

Per creare un nuovo Client andiamo nella maschera 'Initial Client Setup Process' (a livello di System Admin) e creiamo il nostro Client inserendo le impostazioni che ci interessano. 

## Importazione Piano dei Conti

---

Nel campo '**Chart of Accounts FIle'**  carichiamo il Piano dei Conti 'Idempiere 2.0 CoaIta.csv' presente all'interno della directory idempiere-download/initialclientsetup

Vediamo un esempio:

![Image](800px-InitialClientSetup.png)

Alla fine del Processo dobbiamo eseguire la reimportazione del Piano dei Conti (questo perchè non viene importata in modo corretto da System). 

**Entriamo nel Client appena creato**  e come prima cosa abilitiamo il campo "Driven Search Key" della maschera Piano dei Conti (Account Element) in modo da visualizzare la struttura ad albero con Value - Name

![Image](800px-DrivenSearch.png)

Accediamo alla maschera "Import File Loader" e reimportiamo il Piano dei conti:

![Image](800px-PianoConti.png)

Andiamo nella maschera Importazione Conti (Import Account) e clicchiamo nel processo "Importazione Conti"

![Image](ImportAccount1.png)

## Inserire Listini di Default

---

```
Inserire un Listino di Acquisti e un listino di Vendita
```

## Aertuta Periodi Contabili di tutto l'anno

---

```
Nella Maschera Calendar Year and Period (Esercizi) andiamo ad aprire tutti i mesi dell'anno corrente (ed eventualemente anche l'anno successivo, nel caso del cloud)
```

## Initial Client Setup Process Custom_CLIENT

---

**OBBLIGATORI** :

```
 2packClientBase (Obbligatorio) --> setaggio delle impostazioni di default
```

```
 2packTaxBase --> importazione delle Tax Base (iva 22%.....)
```

```
2packPaymentTerm --> importazione dei Termini di Pagamento (importante aver installato prima il plugin PaymentTerm)
```

```
2packWitholding --> importazione delle Withholding (importante aver installato prima il plugin Withholding) 
```

***ATTENZIONE***: non basta solamente installare il 2pack. Qui dobbiamo inserire manualmente alcune impostazioni non presenti nel 2pack: 'un prodotto GS' + 'Withholding Rule' (quest'ultima è una Tab presente nella maschera 'Withholding Type')

**SU RICHIESTA** :

```
2packContract
```

```
2packAttachmentFileSystem --> Nella maschera dell'Attachment Para viene parametrizzato il path per il salvataggio dell'allegato. Vedi qui di seguito (Già presente nel 2packAttachmentFileSystem)
```

```
P/Ordine_di_Vendita/,VOrdine,FDocumentNo,SUSERNAME,SDATEdd-MM-yyyy
  P/Ordine_di_Acquisto/,VOrdine,FDocumentNo,SUSERNAME,SDATEdd-MM-yyyy
  P/Fatture_di_Vendita/,VOrdine,FDocumentNo,SUSERNAME,SDATEdd-MM-yyyy
  P/Fatture_di_Acquisto/,VOrdine,FDocumentNo,SUSERNAME,SDATEdd-MM-yyyy 
```

## INSTALLAZIONE REGISTRI IVA

---

Dopo aver installato il plugin LIT_VATJournal installare (a livello Client) il '''2packRegistriIVA''' presente all'interno della seguente directory (/opt/repos/idempiere-download/initialclientsetup/)

Purtroppo il 2pack non importa tutti i campi, quindi inserire manualmente i campi presenti nella sottotab VATDocTypeSequence che si trova nella maschera DocumentType dei seguenti documenti:

```
AR Invoice
AR Credit Memo
AP Invoice
```

![Image](RegitriIva.png)

[[Category:Installazione]]

## Parametrizzazioni di Base

---

* ''Inserire una banca''


* ''Calendario Contabile'': 

```
-La gestione del Calendario Contabile viene "Disabilitata" durante l'installazione del 2PackClientBase (disabilitata di default).
```

```
Se vogliamo gestirlo dobbiamo andare (ovviamente a livello Client) nella window "System Configurator" ed eliminare il record "CLIENT_ACCOUNTING"
Dopodichè:aprire la window "Calendar Year and Period", passare alla Tab "Anno" e selezionare l'anno corrente. Se necessario creare l'anno, creando un nuovo record e
lanciando il processo "Create Periods" (questa procedura genera i 12 periodi standardGennaio-Dicembre)); - passare al tab "Periodo" e selezionare il periodo necessario; - 
verificare  lo stato del periodo nel tab "Controllo Periodo"; - se lo stato e' "Mai Aperto", ritornare al tab "Periodo" e lanciare il processo "Open/Close All"; - 
selezionare l'azione opportuna (molto probabilmente "Apri periodo"); - dare OK; - verificare nuovamente nel tab "Controllo Periodo" che tutti i documenti abbiano il  
periodo nello stato richiesto
```

* controllare che BP sia impostato a : Invoice Rule [Immediate] e Delivery rule [Force]

  # Backup Server

---




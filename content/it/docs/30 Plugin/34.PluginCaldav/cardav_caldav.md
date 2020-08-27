---
title: "Cardav_Caldav"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b>734. </b>"
---

# Plugin: Cardav Caldav-OLD

---

## Descrizione Plugin

---

## Funzionalità supportate

---

## Installazione Plugin

**--OLD-- ATTENZIONE: VECCHIA GESTIONE PER LA SINCRONIZZAZIONE DEI  CALDAV E DEI CARDAV. PROCESSI SCHEDULATI IN IDEMPIERE. NON USARE QUESTA  INSTALLAZIONE, INSTALLARE DIRETTAMENTE PLUG-IN**

\- Recuperare i jar relativi al job esterno per syncronizzare presenti sia su [link repository dedicato](https://bitbucket.org/consulnet/idempiere-cardav-connector/src) che su [idempiere-download](https://bitbucket.org/consulnet/idempiere-download) - copiare nella cartella del server /opt/job

[![PluginCalCar ListaFile.png](http://192.168.178.102/images/thumb/b/b2/PluginCalCar_ListaFile.png/600px-PluginCalCar_ListaFile.png)](http://192.168.178.102/index.php/File:PluginCalCar_ListaFile.png)

\- modificare la crontable come necessario

```
 crontab -e (aprirà la crontab con l'editor definito nella variabile EDITOR, vi o nano)
 # Calendario 
 5 * * * * /opt/job/cdav-connect_CNET.sh    >/dev/null 2>&1 
 30 * * * * /opt/job/cdav-connectSync_CNET.sh  >/dev/null 2>&1
 # Contatti 
 30 * * * *  /opt/job/cardav-connectSync_CNET.sh >/dev/null 2>&1
 5  * * * * /opt/job/cardav-connect_CNET.sh >/dev/null 2>&1
```

\- installare il plugin con la Console Felix

```
  /opt/repos/idempiere-italia-plugin/idempiereit.cnet.impl.LIT_CaDav
```

---

## Parametrizzazione Plugin

Impostare come SuperUser nella maschera System Configurator

[![PluginCalCar Videata1.png](http://192.168.178.102/images/thumb/3/3a/PluginCalCar_Videata1.png/600px-PluginCalCar_Videata1.png)](http://192.168.178.102/index.php/File:PluginCalCar_Videata1.png)

CALDAVTimeunit -> Ogni quanti minuti deve avviarsi il processo di sincronizzazione del calendario kerio

```
 nota: Ogni CaldavTimeunit viene eseguito e controlla se nella tabella 
  r_request ci sono degli eventi con il campo in r_request_synch=false
  l'evento viene creato con un ID = r_request_id + starttime-endtime
```

LIT_NRDAYSCALDAVBEFORE -> lettura degli eventi calendario presenti  su kerio da LIT_NRDAYSCALDAVBEFORE giorni fino ad oggi e sincronizza  gli eventi.

A livello client, impostare il tipo zul calendar creato: entrare come  SuperUser e selezionare il Client che si desidera il calendario; da  menu system admin > Organization Rule maschera "Dashboard Content"  impostare il campo Gadget URI con il seguente dato:

```
 /zul/calendar_cnet.zul
```

E' possibile impostare il "Nome" piacimento

[![PluginCalCar Videata2.png](http://192.168.178.102/images/thumb/6/64/PluginCalCar_Videata2.png/600px-PluginCalCar_Videata2.png)](http://192.168.178.102/index.php/File:PluginCalCar_Videata2.png)

E' inoltre possibile impostare nello stesso momento un secondo calendario:

```
 /zul/calendar_cnet2.zul
 ADESSO LIMITATO A DUE SOLI CALENDARI
```

Dopo, impostare i ruoli degli utenti per la visualizzazione del calendario sulla proprio dashboard

Da menu System Admin > Organization Rule maschera "Dashboard Preference"

[![PluginCalCar Videata3.png](http://192.168.178.102/images/thumb/0/01/PluginCalCar_Videata3.png/600px-PluginCalCar_Videata3.png)](http://192.168.178.102/index.php/File:PluginCalCar_Videata3.png)


 Si può creare più ruoli per lo stesso Dashboard Content creato, come da esempio:

[![PluginCalCar Videata4.png](http://192.168.178.102/images/thumb/8/8e/PluginCalCar_Videata4.png/600px-PluginCalCar_Videata4.png)](http://192.168.178.102/index.php/File:PluginCalCar_Videata4.png)


 Fare logout, e rientrare nel client. Risultato:

[![PluginCalCar Videata5.png](http://192.168.178.102/images/thumb/6/62/PluginCalCar_Videata5.png/600px-PluginCalCar_Videata5.png)](http://192.168.178.102/index.php/File:PluginCalCar_Videata5.png)


 Impostare nella maschera System Admin > Italian System Config >  Caldav Param - il nome del calendario presente su kerio - l'utente  abilitato a creare l'evento - il tipo di richiesta - gli utenti a cui  scrivere l'evento sul loro calendario, oltre all'utente principale: nome  utenti specificati nella maschera USER(campo "name") e che hanno i  parametri credenziali, per accedere sul server posta/calendario kerio,  valorizzati (usernamexdav, passwordxdav, caldavpath, cardavpath).  Scrivere gli utenti separati da ';'

Outlook/kerio

[![PluginCalCar Videata6.png](http://192.168.178.102/images/7/70/PluginCalCar_Videata6.png)](http://192.168.178.102/index.php/File:PluginCalCar_Videata6.png)

[![PluginCalCar Videata7.png](http://192.168.178.102/images/thumb/a/a6/PluginCalCar_Videata7.png/600px-PluginCalCar_Videata7.png)](http://192.168.178.102/index.php/File:PluginCalCar_Videata7.png)


 Nella maschera User, impostare le credenziali d'accesso degli utenti che hanno il servizio di posta/calendario kerio attivo

[![PluginCalCar Videata8.png](http://192.168.178.102/images/thumb/4/47/PluginCalCar_Videata8.png/600px-PluginCalCar_Videata8.png)](http://192.168.178.102/index.php/File:PluginCalCar_Videata8.png)


 Request

Settare nella maschera "Request Type" il nome del calendario nel campo "Calendar"

[![PluginCalCar Videata9.png](http://192.168.178.102/images/thumb/c/c6/PluginCalCar_Videata9.png/600px-PluginCalCar_Videata9.png)](http://192.168.178.102/index.php/File:PluginCalCar_Videata9.png)


 isExcludeSaturday : NON IMPLEMENTATO isExcludeSunday : NON IMPLEMENTATO

---

## Istruzioni Plugin

### Premessa - Funzionalità gestite

### Gestione Calendari (Caldav)

Se vogliamo che nella schermata principale di utente guest si  visualizzi il calendario in forma estesa si impostare un flag sulla  maschera user dove l'utente admin imposta quale user vede il calendario  in forma estesa.

Una volta creato l'utente e abilitato a visualizzare il calendario in  forma estesa, entriamo in diempiere loggandoci come utente guest.

La schermata che ci verrà proposta sarà:

[![PluginCalCar Videata10.png](http://192.168.178.102/images/thumb/0/0e/PluginCalCar_Videata10.png/600px-PluginCalCar_Videata10.png)](http://192.168.178.102/index.php/File:PluginCalCar_Videata10.png)


 Creazione evento:

In questa schermata abbiamo la possibilita di creare degli eventi  all'interno dei giorni del calendario tramite un semplice interfaccia  grafica. Per aprire questa scheda basta fare un doppio clic sul giorno  in cui desideriamo creare un evento. La schermata che ci viene proposta  da compilare si presenta in questo modo:

[![PluginCalCar Videata11.png](http://192.168.178.102/images/2/22/PluginCalCar_Videata11.png)](http://192.168.178.102/index.php/File:PluginCalCar_Videata11.png)


 Parametri:

1 - Tipo di scadenza: 2 - Tipo di richiesta: Impostazione del tipo di  evento 3 - Priorità: 4 - Riepilogo: Descrizione dell'evento che si  visualizzerà sul calendario 5 - Rappresentante di vendita: utente che  crea l'evento 6 - Inizio pianificato: Data inizio dell'evento 7 -  Completamento: Data fine evento 8 - Ora Inizio: Orario inizio evento 9 –  Ora fine: Orazio fine evento

Creare dei parametri per evento:

Per parametrizzare un modello di evento si può fare nella finestra  Richieste (tutte). Nella schermata che viene riportata di seguito un  esempio di parametrizzazione di una richiesta:

[![PluginCalCar Videata12.png](http://192.168.178.102/images/thumb/d/db/PluginCalCar_Videata12.png/600px-PluginCalCar_Videata12.png)](http://192.168.178.102/index.php/File:PluginCalCar_Videata12.png)


 -Cliccando su di un giorno del calendario posso effettuare una prenotazione e si visualizza a video OK

\- Eliminare una prenotazone direttamente cliccando su di essa da calendario. FATTO!!Funzionante

\- Dopo aver creato l'utente (User) in idempiere e compilato i campi :  “UserNamexdav” + “Passwordxdav” + “Caldavpath” + “Cardavpath” ogni  volta che creo l'evento in idempiere lui mi sincronizza l'evento in  kerio. Funziona la parte di ide su kerio

\- Modificando un evento (su ide) gia creato si sincronizza su kerio dopo 30 min. In fase di test

\- Eliminando un evento in Idempiere me lo elimina in Kerio. Fase di  Test - Eliminando un evento da kerio me lo elimina in idempiere. Da fare

---

## Gestione Sincronizzazione Calendari (Caldav)

---

## Versione 2.0 - installazione

Installazione su Felix o tramite "Initial Client Setup Custom" del plug-in ***it.cnet.impl.LIT_CaDav.jar***

L'utente deve avere impostati i parametri di connessione verso il server di posta.

Impostazioni base dei dati dell'utente:

Da Menu > User:

- ***Username CardAv/CalDAV*** = nome utente server di posta
- ***Password CardAv/CalDAV*** = password server di posta
- ***Path CardAv/CalDAV*** = URL server di posta


 Nella maschera "Caldav Param"

[![CaldavParam 1.png](http://192.168.178.102/images/e/eb/CaldavParam_1.png)](http://192.168.178.102/index.php/File:CaldavParam_1.png)

impostare:

- ***Calendar Name*** = nome calendario. **IMPORTANTE:** il  nome deve per forza contenere la parola chiave 'calendar'; senza  questa, questa parametrizzazione non verrà presa in considerazione...
- ***Column Date ID From/To*** = date di riferimento per la  creazione del vCalendar; questi campi vengono valorizzati in base alla  selezione della prima tab/table....sono date di riferimento dei  documenti di testata: es. C_Order, C_Invoice, etc...
- ***Visible Popup*** = se selezionato, permette all'utente di  scegliere di creare o meno l'evento sul calendario; se non viene  selezionato, l'evento calendario verrà creato in automatico in base ai  criteri filtro soddisfatti della tabella/maschera presa in  considerazione
- ***Filter Button for Field (A/B)*** = SpecialEditorField  utilizzati per creare il filtro di ricerca dei record sulle tabelle che  interessano segnalare sul calendario. È consigliato selezionare i campi  presenti sulla stessa tab/table....
- ***Add Time*** = campo per gestione di impostazione (1)ora  inizio evento (2)durata evento (3)eventuale differenza di  anticipazione/posticipazione evento. Come nell'esempio, i dati vengono  separati da un ";"(essenziale anche quando non ci sono dati....es.  "0;0;0") e devono essere scritti come da esempio: "**10:00;1:20;-1gg 1h20mm**". Il segno '-' viene messo solo nel caso in cui si voglia anticipare l'vento calendario, altrimenti non viene messo. **IMPORTANTE**:  se non vengono valorizzati alcuni dati, è IMPORTANTE che venga aggiunto  uno zero ("0") tra un ';' e l'altro.....se no va in errore il  processo....
- ***Message Calendar*** = messaggio parametrizzato da  visualizzare sul calendario; in base alla tabella/maschera che si vuole  prendere in considerazione, s'impostano i campi come parametri. Esempio  di parametrizzazione: "**Bussiness partner: @c_bpartner.name@ -- Descrizione: @Description@**".

Nella sotto tab "*User Caldav Param*" deve essere associato l'utente al calendario. Verificare che i parametri di connessione siano giusti...

---

## Funzionamento

La procedura di salvataggio evento su calendario avviene al momento  del salvataggio del record della maschera, sempre se rientra nella  parametrizzazione fatta su "Caldav Param".

Il processo controlla che la tabella e record che si sta prendendo in  considerazione non siano già stati sincronizzati sul calendario; il  controllo avviene all'interno della tabella LIT_CaldavSync (maschera:  Caldav Synchronize). Se il record non è stato sincronizzato, allora in  base ai criteri impostati sulla "Caldav Param"

---

## Gestione Contatti (Cardav)

Appunti debug:

- Recupero degli utenti da sincronizzare tramite vista lit_cardavlist_v
- Connessione con la rubrica di kerio
- In base all'utente recuperato da idempiere, vengono settati i dati su il nuovo cardav

Query di recupero utenti/contatti da sincronizzare basata su una vista:

```
CREATE OR REPLACE VIEW lit_cardavlist_v AS 
SELECT ad_user.ad_user_id AS ad_user_ad_user_id,
   ad_user.ad_client_id AS ad_user_ad_client_id,
   ad_user.lit_usernamexdav AS ad_user_lit_usernamexdav,
   ad_user.lit_passwordxdav AS ad_user_lit_passwordxdav,
   ad_user.lit_pathxdav AS ad_user_lit_pathxdav,
   lit_ad_user_contacttypegroup.lit_ad_user_conttypegroup_id AS lit_ad_user_contacttypegroup_lit_ad_user_conttypegroup_id,
   lit_ad_user_contacttypegroup.lit_cardavsync AS lit_ad_user_contacttypegroup_lit_cardavsync,
   lit_ad_user_contacttypegroup.lit_contacttypegroup_id AS lit_ad_user_contacttypegroup_lit_contacttypegroup_id,
   lit_ad_user_contacttypegroup.name AS lit_ad_user_contacttypegroup_name,
   lit_ad_user_contacttypegroup.ad_user_id AS lit_ad_user_contacttypegroup_ad_user_id,
   ad_user_a.ad_user_id AS ad_user_a_ad_user_id,
   ad_user_a.ad_client_id AS ad_user_a_ad_client_id,
   ad_user_a.name AS ad_user_a_name,
   ad_user_a.description AS ad_user_a_description,
   ad_user_a.password AS ad_user_a_password,
   ad_user_a.email AS ad_user_a_email,
   ad_user_a.c_bpartner_id AS ad_user_a_c_bpartner_id,
   ad_user_a.emailuser AS ad_user_a_emailuser,
   ad_user_a.emailuserpw AS ad_user_a_emailuserpw,
   ad_user_a.c_bpartner_location_id AS ad_user_a_c_bpartner_location_id,
   ad_user_a.lit_contacttypegroup_id AS ad_user_a_lit_contacttypegroup_id,
   ad_user_a.lit_usernamexdav AS ad_user_a_lit_usernamexdav,
   ad_user_a.lit_passwordxdav AS ad_user_a_lit_passwordxdav,
   ad_user_a.lit_pathxdav AS ad_user_a_lit_pathxdav
  FROM ad_user ad_user
    JOIN lit_ad_user_contacttypegroup lit_ad_user_contacttypegroup ON ad_user.ad_user_id = lit_ad_user_contacttypegroup.ad_user_id
    JOIN ad_user ad_user_a ON lit_ad_user_contacttypegroup.lit_contacttypegroup_id = ad_user_a.lit_contacttypegroup_id
 WHERE ad_user.lit_usernamexdav IS NOT NULL AND lit_ad_user_contacttypegroup.lit_cardavsync = 'Y'::bpchar;
ALTER TABLE lit_cardavlist_v
 OWNER TO adempiere;
```

---

## Documentazione Tecnica Plugin

**TODO......** Nell'installazione del plug-in, L'SQL Statement  della creazione della vista "lit_cardavlist_v" del 2pack NON VA; da  errore "column ad_user_a.lit_contacttypegroup_id does not exist". Mentre  eseguendo la creazione vista manuale con stesso script da pgAdmin, la  esegue SENZA NESSUN PROBLEMA.

*Controllare.......*

---

## Modifiche all'AD

### Tables / Windows esistenti

### Nuove Tables /Windows

---

## Funzionalità Future

- a) nuovo campo su tabella LIT_AD_User_CaldavParam

  ***(boolean "Y/N") --> isKerioTo iDsync***

  Permette di scegliere quale utente ha la possibilità di riportare le  modifiche fatte direttamente da Kerio su il record di  iDempiere....questo se ci sono più utenti collegati sullo stesso evento

- b) sync back su kerio se marco modifica e andrea deve ricevere la modifica

  Se l'utente di default fa la modifica su Kerio e si avvia il  processo di sincronizzazione da Kerio to idempiere, anche gli altri  utenti che sono collegati allo stesso evento devono vederlo sul proprio  calendario....

---

## Errori e bug

---

## Release 2.0

Nuovi campi per AD_User

```
LIT_Username_Cdav
LIT_Password_Cdav
LIT_Caldavpath
LIT_Cardavpath
```

Nuova tabella: LIT_CalDavParam (vedi pojo jar progetti cardav/caldav e maschera macchina 8041....)

```
1. Campi di base
2. Associazione per Ruolo o per Utente (vedi 'window Customization') AD_Role e Ad_User
3. AD_Table_ID e AD_Column_ID(dinamyc validation di tipo DATA...)
```

Domanda : se non voglio che tutte le date di una tabella vengano sul calendario ?

Nuova tabella: LIT_CardDavParam (vedi pojo jar progetti cardav/caldav e maschera macchina 8041....)

Nuova tabella: LIT_GroupCArdav

CALDAV . che cosa scrivo

```
- data da 
- data a
- sommario [ ]
- ididentifier
```

 

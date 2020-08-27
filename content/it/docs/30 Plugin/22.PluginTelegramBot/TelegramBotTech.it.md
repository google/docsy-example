---
title: "Plugin Telegram Bot - Tecnico"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 25
pre: "<b>722. </b>"
---

## Progetto IdempiereBOT - Telegram

---

## Riferimenti

- link pubblico  : non applicabile
- link idempiere italia  : <https://bitbucket.org/consulnet/idempiere-ita-plugin> - it.idIta.impl.LIT_idempiereBOT
- link jar  : /opt/repos/idempiere-download/plugin-italia/LIT_iDempiereBOT/
- versione idempiere  : idempiere 4.1
- versione zk supportata : ??

## Descrizione Plugin

---

## Funzionalità supportate

---

## Installazione Plugin

### Creazione Bot Telegram

Nella funzione di cerca contatti di telegram scrivere [@BotFather](https://telegram.me/botfather); una volta trovato, cliccare per avviare la chat. A chat avviata, visualizzerà tutti i comandi possibili che si possono utilizzare. P.S. se non visualizza nulla, come di seguito, avviare con il comando **/start**

```
I can help you create and manage Telegram bots. If you're new to the Bot API, please see the manual (https://core.telegram.org/bots).

You can control me by sending these commands:

/newbot - create a new bot
/mybots - edit your bots [beta]
/mygames - edit your games (https://core.telegram.org/bots/games) [beta] 

Edit Bots
/setname - change a bot's name
/setdescription - change bot description
/setabouttext - change bot about info
/setuserpic - change bot profile photo
/setcommands - change the list of commands
/deletebot - delete a bot

Bot Settings
/token - generate authorization token
/revoke - revoke bot access token
/setinline - toggle inline mode (https://core.telegram.org/bots/inline)
/setinlinegeo - toggle inline location requests (https://core.telegram.org/bots/inline#location-based-results)
/setinlinefeedback - change inline feedback (https://core.telegram.org/bots/inline#collecting-feedback) settings
/setjoingroups - can your bot be added to groups?
/setprivacy - toggle privacy mode (https://core.telegram.org/bots#privacy-mode) in groups

Games
/newgame - create a new game (https://core.telegram.org/bots/games)
/listgames - get a list of your games
/editgame - edit a game
/deletegame - delete an existing game
```

Il primo comando che serve è **/newbot**. Dando questo comando @BotFather chiederà il nome del nostro Bot, e poi l’username: nell'esempio di test è stato creato un BOT dal nome "myidempierebot"..... il carattere '@' lo aggiungerà davanti al nome in automatico dopo la creazione del BOT.
È importante che il nome termini con “Bot”, sempre che non siano già stati scelti da altri utenti. Una volta finita la creazione del Bot, @BotFather ci risponderà così:

```
Done! Congratulations on your new bot. You will find it at t.me/myidempierebot. You can now add a description, about section and profile picture 
for your bot, see /help for a list of commands. By the way, when you've finished creating your cool bot, ping our Bot Support if you want a better username for it. 
Just make sure the bot is fully operational before you do this.

Use this token to access the HTTP API:
000000000:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

For a description of the Bot API, see this page: https://core.telegram.org/bots/api
```

L’informazione più importante è ovviamente il ***token***, una stringa lunga 45 caratteri, che avrà la funzionalità di una coppia “utente-password“; questo e più il nome del BOT dovranno essere utilizzate e paramettrizzate all'interno di iDempiere o di un file di .properties.
Per comodità e avere i dati parametrizzati su iDempiere, è stata creata una maschera apposta per salvare i dati del bot

|                                                              |                                                              |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
![Token Client](/image/PluginTelegramToken_1.png)
Maschera/Sotto-tab "Telegram AD Client": ogni Client in questa tab inserirà le giuste informazioni del botTelegram creato; il plug-in, al suo avvio principale o riavvio del server, prevede la lettura di questa tabella per tutti i CLient attivi e se i dati corrispondono su telegram avvierà il servizio telegramBot collegato. **N.B IMPORTANTE:** *attualmente, in una istanza idempiere-server si possono attivare al MAX 2 telegramBOT PER UN SOLO CLIENT. Prossimamente si faranno modifiche per gestire più telegramBOT x ogni CLIENT...* |
|                                                              |                                                              |


### Invare Richiesta Utente

Agganciamo il nostro client privato di Telegram con il Bot di iDempiere. Cerchiamo il Bot creato, in questo caso "myidempierebot":
![Token Client](/image/PluginTelegramRequest1.png)

Appena la richiesta viene inviata nella Maschera di Idempiere "Telegram Request Bot" comparirà questo record, dove poi andremo ad agganciarlo all'Utente di iDempiere

![Token Client](/image/PluginTelegramRequest2.png)

### Comandi Bot Telegram personalizzati

Come prima cosa dobbiamo inserire (a livello Client) la visualizzazione ad albero della "Telegram Bot Methods". Andiamo nella window Tree e creiamo il seguente record:

![Token Client](/image/PluginTelegramTree.png)


La gestione dei comandi BOT personalizzati vengo parametrizzati su iDempiere tramite la maschera "*Telegram Bot Methods*". Questi comandi non sono altro che le chiamate a livello utente su Telegram.

I comandi per ora stabiliti per i BOT su iDempiere sono:



#### **TIPO MESSAGE (uso interno e esterno) --->/message** 

Questo tipo di comando, permette di fare delle interrogazioni da Telegram verso iDempiere riguardo principalmente ai documenti creati sul gestionale, come ad esempio fatture e ordini.

Il comando, ricerca sulla tabella LIT_TelegramBot tutti i tipi di gestione che siano di tipo telegramAction "message" di un determinato Client (==> l'utente telegram è associato ad un Client predefinito....) e in base alla scelta fatta, viene visualizzato l'elenco dei documenti o altro (in base ad un criterio impostato su iDempiere...) che si ha a disposizione; e se l'utente ha l'accesso, può anche fare il download del report del documento.

Qui di seguito, esempi del comando **/message** con la relativa parametrizzazione su iDempiere

|                                                              | STEP                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![Inizio](/image/PluginTelegramMessage_1.png) | Come si presenta il comando iniziale; schiacciare il pulsante corrispondente al documento che si vuole ***N.B:** i comandi/scelte sono visualizzati in base alla profilatura/accesso dell'utente registrato* |
|                                                              |                                                              |
| ![Scelta ordine](/images/PluginTelegramMessage_2.png) | Una volta cliccato su "ordine", da un elenco degli ultimi ordini, in base ad un determinato criterio.... ***N.B:** i comandi/scelte sono visualizzati in base alla profilatura/accesso dell'utente registrato* |
|                                                              |                                                              |
| ![Download document](/image/PluginTelegramMessage_3.png) | Possibiltà di cliccare sul link di download del documento e riceverlo, se disponbibile.... ***N.B:** i comandi/scelte sono visualizzati in base alla profilatura/accesso dell'utente registrato* |

Parametrizzazione a livello iDempiere

|                                                              | STEP                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![Param](/image/PluginTelegramMessageParam_1.png) | **Telegram AD_Client:** associazione botTelegram impostato attivo nella sottoTab del client. È un dato obbligatorio per motivi di sicurezza e accesso**Telegram Action:** il comando telegram '/message'**Name:** in questo esempio è "ordine" ed è il pulsante di scelta documento**Table:** dato essenziale per recuperare i dati del documento/record che interessa**Process:** report della tabella associata; in questo esempio è legato alla Sales Order. Se il campo non è valorizzato, non viene visualizzato il link di dowload del documento**Message:** messaggio personalizzato di ritorno di telegram; associato a questo, se l'utente è abilitato ed è valorizzato il campo "Process", viene messo in automatico il link di download del documento**Sql WHERE:** criterio di ricerca documenti; in questo esempio si ricercano gli ordini completati da oggi fino a 80 giorni fa ***N.B:** nella sotto tab, vi è la profilatura/accesso dell'utente registrato; se non è valorizzato, l'utente non può accedere da telegram al determinato comando....* |
|                                                              |                                                              |

#### **TIPO CONTACT (uso interno ) --->/contact** 

lit_bot_contact (select from c_Bpartner jon location UNION select ad_user )

|            |             |                  |                    |             |
| ---------- | ----------- | ---------------- | ------------------ | ----------- |
| Tabella    | Name        | Phone            | Email              | Address     |
| c_bpartner | consulnet   | +39 0438 1890684 | info@consu.it      | via del mar |
| c_bpartner | ormet       | +39 0483 4444    |                    |             |
| ad_user    | marco longo | +39 349 1111990  | marco.lasdfasdfjkh |             |


TIPO LOCATION /location

ok

TIPO CHAT /chat catturare un messagio e inserirelo in una maschera di chat

chat_user_id ticket =11111

#### TIPO INSERT -->/insert**

L'action "insert" è stata implementata, per il momento, per un inserimento di un solo record direttamente su DB di iDempiere; alla selezione di "insert" dal campo 'Telegram Action', viene visualizzata una tab supplementare per creare "parole chiavi" che vengono riconosciute a sistema e permettono di inserire nel modo corretto i dati e quindi creare un nuovo record di tabella in iDempiere.

Qui di seguito vi è un esempio funzionante, con la spiegazione della giusta parametrizzazione della maschera

Un inserimento tipo esatto, usato come esempio e FUNZIONANTE:
***/insert ore dataFrom="13/02/2017 14:00" qty=2 risorsa=aChecchia*** ---> È IMPORTANTE che ogni parola chiave(KeyComand) sia seguito da un "=" e subito dopo il valore da inserire; inoltre È IMPORTANTE che, quando si vuole inserire un dato/valore lungo e con la presenza degli spazi come il 'dataFrom' qui in esempio o il tipo 'description' presente su tabella etc., il dato sia delimitato dai doppi apici ("")

|                                                              | STEP                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![Param_Insert](/images/PluginTelegramInsert_1agg.png) | Parametrizzazione del comando telegram "insert": da notare che, una volta selezionata la voce, viene visualizzata la tab supplementare chiamata "Telegram Command Key" ***N.B:** i comandi/scelte sono visualizzati in base alla profilatura/accesso dell'utente registrato* |
|                                                              |                                                              |
| ![Command Key](/image/PluginTelegramInsertCmdKey_1.png) | In questa maschera, si possono censire tutte le parole chiavi che si vogliono utilizzare per un giusto inserimento record da telegram; nel caso dell'esempio: **Tabella:** *S_ResourceAttendance* ---- vogliamo inserire le ore di una risorsa**Dati PARAM specifici_1****Name:** *qty***KeyCommand:** *qty* (parola chiave su telegram)**Field Command:** *Qty* (campo della tabella selezionata) //// [qty=2] Se inserito nel nostro comando di telegram, si vuole inserire la quantità di 2h fatteName:dataFrom -- KeyCommand:dataFrom (parola chiave su telegram) -- Field Command:AssignDateFrom (campo della tabella selezionata) //// [dataFrom="13/02/2017 14:00"] Se inserito nel nostro comando di telegram, si vuole inserire la data e l'ora di partenza del nostro rilevamento ore; da NOTARE CHE è racchiuso da virgolette (""), perché dato che contiene uno spazio e si vuole prendere in considerazione l'intera stringa della data+ore, è opportuno che si scriva così, se no darà errore d'inserimento....Name:isConfirmed -- KeyCommand:(vuoto) (NO parola chiave su telegram, perché valore fisso) -- Field Command:isConfirmed (campo della tabella selezionata) -- Fixed Value:Y //// In questo caso siamo in una dichiarazione di un valore fisso da aggiungere sul record; in questo caso di esempio, dato che la colonna "isConfirmed" della tabella è obligatorio e non segnato a comando, è importante dichiararlo così.... ***N.B:** i comandi/scelte sono visualizzati in base alla profilatura/accesso dell'utente registrato* |
|                                                              |                                                              |
| Missing | XXXXXXX ***N.B:** i comandi/scelte sono visualizzati in base alla profilatura/accesso dell'utente registrato* |



##### AGGIORNAMENTO DEL 05/04/2017:

altro inserimento, ancora più corretto è

***/insert ore dt="05/04/2017 8:00" q=8 c=Consulnet d="Plug-in LIT_idempiereBOT: Gestione chat su record anche con telegram_BOT" k="PID iDempiere_BOT"*** che include la descrizione e il progetto da inserire per il Rilevamento Ore Risorsa

![Command Key_2](/image/PluginTelegramInsertCmdKey_2.png) Tenere conto di questi comandi, come da esempi specifici

Per il Rilevamento Ore Risorsa sono state studiate delle varianti, per rendere ancora più semplice l'inserimento, ma altrettanto efficace (tenere conto dell'immagine precedente per il corretto funzionamento e per eventuali test....)

- **/insert ore dt="05/04/2017 8:00" q=8 c=Consulnet d="Plug-in LIT_idempiereBOT: Gestione chat su record anche con telegram_BOT" k="PID iDempiere_BOT"** : in questo caso non è stato specificato la risorsa, questo perché se non specificato, viene presa la risorsa legata all'utente idempiere/Telegram censito ad accesso a questo metodo
- **/insert ore dt="8:00" q=8 c=Consulnet d="Aggiornamento DB" k="PID iDempiere_BOT"** : anche in questo caso la risorsa viene recuperata in base all'utente attivo e collegato al telegramBOT. Viene specificato l'orario di inizio lavori e ciò vuol dire che la data è OGGI + ora (dt)
- **/insert ore q=-2 c=Consulnet d="Aggiornamento DB" k="PID iDempiere_BOT"** : anche in questo caso la risorsa viene recuperata in base all'utente attivo e collegato al telegramBOT. Ma non vi è nessun riferimento alla data di inizio del lavoro fatto e la qtà delle ore lavorate sono 2; ciò vuol dire che la data di riferimento è SYSDATE. Inoltre la qtà, come da esempio, regola la data di inizio e fine attività: se il numero è preceduto dal segno '-' vuol dire che nel Rilevamento ore che si vuole inserire la data inizio è SYSDATE-2ore, altrimenti SYSDATE+2ore


Tabella esempio, test....

|             |              |                   |                                |                        |
| ----------- | ------------ | ----------------- | ------------------------------ | ---------------------- |
| Tabella     | Name         | KeyComand(string) | Field(stringa)                 | Valore Fisso (Stringa) |
| c_order     | Nome cliente | cliente           | @c_order.c_bpartner.name@      |                        |
| c_order     | tipo doc     |                   | @c_order.c_doctypetarger.name@ | “Standard Order”       |
| c_orderline | Progetto     | progetto          | @C_project.description@        |                        |

## Personalizzazione Chat con telegram

![Chat_1](/image/PluginTelegramChat_1.png)

Questa utilità permette di mandare un messaggio diretto sul botTelegram dell'utente associato oppure un messaggio broadcast sull'istanza di iDempiere; è stata personalizzata la maschera-toolbar "Chat" e a livello codice java è stata creata una classe standard per l'invio del messaggio, tramite le API di Telegram.

|                                                              | STEP                                                         |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![Chat_2](/image/PluginTelegramChat_2.png)| È necessario per prima cosa impostare il 'Chat Type': questo permette di differenziare il tipo d'invio del messaggio, se via Telegram o via broadcast; è importante impostare nel chatType per telegram la tabella "LIT_TelegramBroadMsg", mentre per il broadCast la tabella "AD_BroadcastMessage". Queste due tabelle, nello specifico, verranno utilizzate da contenitori per i messaggi che inviamo dalla chat |
|                                                              |                                                              |
| ![Chat_3](/image/PluginTelegramChat_3.png) | **Maschera "Telegram Broadcast Message":** questa maschera ha una doppia utilità: 1)archivio dei messaggi inviati da chat; 2) inviare in modo diretto nuovi messaggi all'utente di telegramBot desiderato o riproporre il messaggio di chat all'utente; tutto questo schiacciando sul bottone "Publish Message Telegram" |
|                                                              |                                                              |
| Missing | XXXXXXX                                                      |

## Parametrizzazione Plugin

### Tabelle da sincronizzare

|      |      |      |      |      |
| ---- | ---- | ---- | ---- | ---- |
|      |      |      |      |      |
|      |      |      |      |      |
|      |      |      |      |      |
|      |      |      |      |      |

TABELLA """

---

## Processo di Sincronizzazione

---

## Mapping Product

---

## Istruzioni Plugin

---

## Documentazione Tecnica Plugin

### Modifiche all'AD

#### Tables / Windows esistenti

#### Nuove Tables /Windows

---

## Funzionalità Future

---

## Errori e bug

---

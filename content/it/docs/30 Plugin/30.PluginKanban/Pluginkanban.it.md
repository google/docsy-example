---
title: "Plugin Kanban"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b>730. </b>"
---


## Riferimenti

- link pubblico  :<http://wiki.idempiere.org/en/Plugin:_Kanban_Dashboard>
- link repository consulnet:<https://bitbucket.org/consulnet/plugin-standard.kdb_idempiere>
- link jar  :/opt/repos/idempiere-download/plugin-standard/Kanban_Dashboard/
- versione zk supportata  : zk8

---

## Descrizione Plugin

```
 - Kanban Board mostra una panoramica del processo che si desidera.
 - È possibile definire gli stati di un processo basato su un elenco o una colonna.
 - È possibile spostare una carta da uno stato all'altro con il drag and drop.
 - È possibile ordinare le carte in base alla priorità.
 - Vedere le carte in diversi colori in base al loro valore di priorità.
 - Controllare chi può interagire con la scheda e chi no.
 - Impostare le informazioni che si desidera visualizzare in ogni scheda.
 - Utilizzare il campo Coda SQL per impostare una regola che invia ogni documento che soddisfa ad una coda fino a quando la condizione è risolta
 - Controlla il tuo WIP impostare il numero massimo di carte consentito in uno stato
```

Il plugin aggiunge tre Windows:

```
 1) Kanban Board Configuration  
 2) Kanban Status Configuration    
 3) Kanban Board
```

---

## Funzionalità supportate

---

## Installazione Plugin

Installare nella console felix il jar reperibile su [idempiere-download](https://bitbucket.org/consulnet/idempiere-download)

---

## Parametrizzazione Plugin

Inserito 2packClientKanban.zip da installare a livello Client.

```
/opt/repos/idempiere-download/plugin-standard/Kanban_Dashboard/2packClientKanban.zip
```

Dopo aver Installato il 2packClientKanban.zip è importante andare nella Window 'Kanban Board Configuration' e lanciare il processo 'Create Statuses in Kanban Board' (posto nella tollbar in alto). Questo va fatto per ogni record (Ricorda che per instalalre questo 2pack deve esserci il plugin delle Resource Attendance)

---

# Istruzioni Plugin

## 1) Configurazione (Kanban Board Configuration)

Questa window consente all'utente di creare e configurare la kanban board. È necessario scegliere il processo che deve essere modellato nella Kanban Board (Es: Invoice Process -> C_Invoice). Poi si sceglie un elenco List o una Column per impostare gli stati. Se si desidera limitare i risultati da visualizzare, è possibile farlo con una dichiarazione di sql nel campo "SQL WHERE". Es: Se si desidera visualizzare le fatture non pagate, è necessario compilare questo campo con: is Paid='N'

![Kanban1.png](/images/PluginKanban1.png)

Nuovo campo Sql Order By: È possibile scegliere come ordinare le carte nella board. Se si lascia vuoto questo campo l'ordine sarà stabilito dalla regola di priorità.

**IMPORTANTE!!** Andare nella TAB “Kanban Board Control Access” per permettere l’accesso e quindi la visualizzazione alla Kanban Board! Inoltre flaggare Read/Write per permettere lo spostamento o la lettura delle carte nella Kanban Board

## Configurazione regola di priorità

Questo campo deve essere compilato se si desidera ordinare le carte da qualche regola o campo, il valore deve essere un'istruzione SQL valida associata alla tabella del processo. Se si desidera utilizzare la funzionalità per stampare le carte da colori a seconda della sua priorità, questo campo deve restituire un valore numerico.

## Contenuti Kanban Scheda

Per impostare il testo che verrà visualizzato nelle carte, il campo Kanban Board Text deve essere riempito in questo modo:

```
 - Il testo che sta per essere visualizzato da valori dal database deve essere compresa tra '@' con il nome del campo.
 - Se si tratta di un campo di una tabella esterna, è necessario digitare il nome di quella tabella seguito da un '.' e il nome del campo, tutto quello tra la '@'
 - Qualsiasi altro testo che non soddisfa questi parametri verrà stampato senza formato nella scheda
```

![Kanban2.png](/image/PluginKanban2.png)

Nel caso dei campi con il tipo di dati: Date e amount, è possibile anche inviare il formato che si desidera utilizzare per esso tra <> prima della @ finale.

![Kanban3.png](/image/PluginKanban3.png)

## 2) Kanban Status Configuration

Questa finestra permette di configurare i diversi stati della scheda. È possibile creare un Alias per lo stato, quell’alias verrà stampato al posto del nome nella scheda kanban.

Se si vuole si può limitare il numero di carte in uno stato, questo limita il W.I.P. La Seq Value determina l'ordine delle colonne nella board. Se si fa clic su “isShowOver,” la board mostrerà tutte le carte in quello stato, anche se superano l'importo massimo definito precedentemente, in questo caso l'intestazione di colonna sarà dipinta di rosso.

È possibile impostare uno stato finale impostando isShowOver = 'N' e il Max Number Cards a -1.

Se si desidera creare una regola per mettere le carte in una coda invece di una colonna, il campo di istruzione SQL fa quello. È possibile impostare qualsiasi tipo di regola che può essere in una where clause in “SQLStatment”. Se si desidera visualizzare in coda tutte le carte che non hanno un BPartner associato, è necessario compilare il campo con C_BPARTNER = null, saranno poste tutte le carte nella colonna di stato ma in più si creerà una nuova colonna a sinistra che rappresenta una coda dallo stato attuale, le carte nella colonna coda non possono essere spostate, si sposterà automaticamente una volta soddisfatta la condizione che è stata impostata per esso. È inoltre possibile impostare che sarà inviato alla coda se le carte in quello stato superano il numero massimo di carte consentite per esso, in questo caso è necessario compilare quel campo con una C (Card).

---

## Priorità

Qui è possibile configurare la priorità, si assegna un colore a ogni intervallo definito dalla regola di priorità.

![Kanban4.png](/images/PluginKanban4.png)

Questa finestra consente di ordinare e impostare i parametri dello stato, qui è possibile modificare i valori delle colonne in modo semplice.

È possibile modificare gli stati “ordini”con drag and drop.

Quando si fa clic su una colonna, il pannello di destra mostra tutte le proprietà di questo Stato, è possibile modificare tali valori. Se si trascina uno Stato e rilasciarlo nel cestino, questo stato sarà cancellato.

## 3) Kanban Board (Utilizzo)

![Kanban5.png](/images/PluginKanban5.png)

La finestra Kanban Board consente di interagire con le schede pre-configurate. Viene visualizzato un elenco delle schede disponibili (se pre-configurato).

Quando si seleziona una delle schede, la scheda kanban associato viene visualizzato con ogni colonna corrisponde ad uno stato, e ogni carta a un record di questo processo che è attualmente in quello stato.

È possibile spostare le carte tra i diversi Stati, se lo vuoi, se non viola qualsiasi flusso di lavoro, il valore dello Stato card sarà aggiornato.

È possibile eseguire lo zoom nel documento facendo doppio clic sulla scheda.

È possibile impostare diversi tipi di schede (anche se non sono Kanban Boards), come rapporto vendite venditore

## Documentazione Tecnica Plugin

### Modifiche all'AD

```
-----------
| nomeSup |
-----------------------------
| nome | tipo | descrizione | 
-----------------------------
```

#### Tables / Windows esistenti

#### Nuove Tables /Windows

## Funzionalità Future

## Errori e bug

## Miglioramenti nelle versioni più recenti

La finestra Kanban Board presenta i seguenti miglioramenti:

Ora è possibile vedere quali componenti è possibile interagire con, in quanto il cursore cambia quando si trova sopra una carta che può essere spostato.

Ogni stato ha un menu che viene visualizzato quando si fa clic sul pulsante che si trova sul lato destro della colonna, il menu mostra la lista degli stati configurati per la scheda, quando si fa clic su una delle voci della colonna corrispondente è nascosta.

![Kanban6.png](/images/PluginKanban6.png)

# Kanban Consiglio 2.0

Questa è la nuova versione del Kanban Board, ha nuove caratteristiche, è in una versione beta. Sentitevi liberi di usarlo, testarlo e tutte le risposte che si desidera condividere con me sarà molto apprezzato.

## Sommario

Ora è possibile avere un riassunto in ogni stato, diciamo per la configurazione di kanban per controllare le diverse fatture in stato di diverso. Con questa nuova funzione è possibile visualizzare tutte le informazioni che si desidera visualizzare nell'intestazione dello stato. Il campo è riempito da una clausola SQL con la quale si può fare qualsiasi cosa lì, nell'immagine qui sotto potete vedere un kanban per le fatture che riassumano la somma totale di tutte le fatture in ogni stato.

Come farlo? Riempire il Summary SQL con @SQL = Select Somethingq, Something2 FROM (La tabella da te definita per il Kanban) JOIN ... WHERE (StatusColumn) = @ KanbanStatus @ AND ...

Non utilizzare alias per la tabella principale nella clausola FROM

```
 - StatusColumn deve sostituire con la colonna corrispondente che è stata scelta per impostare gli stati.
 - @KanbanStatus@ deve essere scritta esattamente come quello di analizzare i valori reali per ogni stato.
```

ad esempio @SQL = SELECT SUM(totallines) || '€' AS Totalamount FROM C_Order WHERE DocStatus = @KanbanStatus@

![Kanban7.png](/image/PluginKanban7.png)

Il risultato sarà qualcosa di simile al seguente

![Kanban8.png](/image/PluginKanban8.png)

È possibile inserire il numero di colonne dei risultati che si desidera, saranno separate da /

---

## Processo all'interno Kanban

Questa funzione ha lo scopo di rendere le cose più semplici, è già possibile visualizzare le tue informazioni in modo generale, ma cosa succede se si desidera elaborare esso (singolarmente o in gruppo) dal kanban Board. E 'ora possibile. Per questa nuova funzione si sarà in grado di configurare processo che può influenzare le carte in tutta la Board, schede in un unico stato, o di una singola scheda.

È possibile configurare la nuova scheda Processo Kanban Associata

![Kanban9.png](/image/PluginKanban9.png)

Selezionare il processo che si desidera eseguire nel Kanban nel campo processo.

Nel campo di applicazione è possibile selezionare se verrà eseguito il processo per la board - status o - card.


![Kanban10.png](/image//PluginKanban10.png)


![Kanban11.png](/image/PluginKanban11.png)

Il processo lavora come nella Info Window a seconda della tabella T. Per utilizzare il processo si deve fare qualcosa di simile

![Kanban12.png](/image/PluginKanban12.png)

Il processo aprirà la finestra di dialogo normale come ogni altro processo in iDempiere e chiederà i parametri, se necessario.

## Il colore del testo configurabile sulle schede

Questa funzione può essere utilizzata per aggiungere un contrasto con il testo, se si imposta un colore di priorità si possono identificare alcune carte più facilmente. Ora è possibile scegliere il colore del testo anche per creare un contrasto più bello nelle carte.Basta compilare il campo 'Text color' nella Tab "Kanban Priority".

![Kanban13.png](/image/PluginKanban13.png)

E si sarà in grado di vedere il nuovo colore del testo

![Kanban14.png](/image//PluginKanban14.png)

---

## Impostazione standard del formato scheda

Ora è possibile configurare le dimensioni delle carte in una scheda Kanban. È possibile impostare l'altezza e la larghezza, in tal modo, tutte le carte saranno visualizzate con le stesse dimensioni della scheda. Basta riempire i campi 'Standard Column Width' e 'Standard Card Height' con i valori

![Kanban15.png](/image/PluginKanban15.png)

Se il contenuto della scheda supera la dimensione scelta, una barra di scorrimento verrà inserita nella scheda di navigazione attraverso i contenuti. Se non si riempiono questo valori, le carte si comporteranno come default in ZK.

![Kanban16.png](/image/PluginKanban16.png)

---

## Kanban Board Auto Refresh

Molte volte si vorrebbe lasciare uno schermo aperto per verificare di volta in volta quello che i processi stanno eseguendo. Con questa nuova funzionalità, è possibile configurare la Kanban Board di aggiornamento automatico ogni certo periodo di tempo. Permettendo di vedere cambiamenti nel flusso di processo senza interagire direttamente con il sistema. Configurare un sysconfig 'KDB_KanbanBoard_RefreshInterval' con il tempo impostato in millisecondi, come mostrato nell'immagine qui sotto.

![Kanban17.png](/image/PluginKanban17.png)]

---

## Kanban Board Auto Refresh 2.0 -- iDempiereConsulting

È stata aggiunta la possibilità di aprire automaticamente una kanbanboard specifica al momento del login e avere un effetto "insegna ciclica"(o slide automatica) in base dei criteri prestabiliti.

Per prima cosa è importante specificare SEMPRE nella maschera della special form relativo alla Kanbanboard, con classname "org.idempiere.webui.apps.form.WKanbanBoard.WKanbanBoard", a livello System, l'ID della form specifica; questo mi permette di fare un confronto a livello codice e aprire o no l'automatismo
* ImmagineAssente

Bisogna specificare nella maschera "Menu Favoutites" la window che si vuole aprire automaticamente (il numero del nodo non è altro che l' AD_Menu_ID della window specifica....)e il *Login automatic open sequence*, per far in modo che ci sia l'automatismo alla login.
* ImmagineAssente

Specificare nella sotto tab "KDB_AutomaticControl" della window "Kanban Board Configuration" l'utente specifico che può aprire la kanban specifica e se previsto l'eventuale fase "ciclica" dei kanban raggruppati
[File:KDB Impl 3.png](http://192.168.178.102/index.php?title=Special:Upload&wpDestFile=KDB_Impl_3.png)

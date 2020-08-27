---
title: "Importazione Dati CSV"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 95
pre: "<b>1.4.2 </b>"
---

## Importazione tramite file CSV in iDempiere

---

Importare in iDempiere dati tramite file in formato CSV (Comma Separated Values) è possibile in più modi.

Si possono importare uno o più record:

- tramite lo strumento di importazione CSV situato nella toolbar di una qualsiasi tab (in alto a dx);
- tramite il processo di importazione CSV ricercabile con la barra di ricerca in alto a sinistra: **Import CSV Process**.

I pro e contro dei due metodi verranno trattati nella sezione dedicata.

## 1) Importazione tramite strumento di importazione CSV

Lo strumento di importazione CSV dalla toolbar è il più immediato,  perché nel momento in cui si individua la tab è sufficiente premere il  pulsante, indicare il file ed il metodo di inserimento e dare conferma.

Per importare uno o più record tramite questo metodo, i passi da eseguire sono:

- individuare in quale window tab & field bisogna inserire/aggiornare i(l) record (Prodotto piuttosto che Listino..);
- preparare i dati da importare nel file CSV;
- avviare il processo di importazione;

### Individuare la window tab & field

Per individuare quale sia la window tab & field che andrà a  ricevere modifiche, è sufficiente navigare nel sistema (sia tramite  menù, sia tramite ricerca) ed individuare la finestra adeguata allo  scopo. Nel momento in cui la finestra è stata aperta, si può procedere  ad importare i dati direttamente nella prima tab (quella in primo piano)  oppure navigare fra le tab disponibili ed aprire quella desiderata.  Nella tab i campi che nel nome presentano un asterisco (es: Nome* ) sono  obbligatori, e quindi vanno riempiti in ogni record nel file CSV. Nel  caso vengono omessi, il file CSV di ritorno dal sistema verrà segnalato  l'errore come in figura:

```
  @FIGURA@
```

## 2) Import CSV Process (Importazione tramite processo di importazione CSV)

Il processo di importazione CSV è un altro metodo per importare dati  nel sistema tramite file CSV. Per funzionare bisogna prima creare un  record nella window "**Import Template**", dove si inseriscono dati  di natura tecnica in modo tale da importare dati senza dover entrare  ogni volta nella tab di destinazione. Dopo aver creato un template, si  può utilizzare il processo di importazione "**Import CSV Process**".

Vediamo un esempio di importazione Prodotto con la sua relativa sottoTab Price:

[{{< figure src="/image/ImportDataCSV1_1.png"  width="850"  >}}](/image/ImportDataCSV1_1.png)


[{{< figure src="/image/ImportDataCSV2_2.png"  width="850"  >}}](/image/ImportDataCSV2_2.png)


---

## Utilizzo 

Per usare un template per importare uno o più dati è necessario:

- Scaricare il template necessario (Prodotti per uno o più prodotti, ...)
- Aprire il file con il proprio programma di foglio elettronico preferito (o con un editor di testo)
- Inserire riga per riga i dati, disponendoli sotto la colonna giusta.

```
  La prima riga indica quali sono i campi, e quindi NON va cancellata, mentre la seconda riga sono dati d'esempio, possono essere rimossi.
  E' importante che i tipi dei dati siano corretti, quindi assicurarsi che il foglio elettronico non abbia formattazioni dei dati invalide:
  * i dati di tipo testo restano testo (Nome, Magazzino, Listino)
  * i dati di tipo numerico devono essere numeri e non stringhe. Se hanno cifre decimali, utilizzare la notazione inglese, non quella italiana
```

- Salvare il documento sempre come CSV (se chiede quale formato utilizzare, selezionare "Formato CSV")

Come risultato dell'operazione, iDempiere invia al vostro computer un  file CSV contentente i dati inviati, più la colonna LOG. In questa  colonna il sistema mette gli errori che ha individuato, oppure un  messaggio di successo ("Inserito M_...")

---

## INSERT / UPDATE /MERGE

- Specificare il metodo:

```
Insert: inserisce il record, o ignora se già esistente
Update: aggiorna i record
Merge: Insert + Update (con questa modalità l'importatore aggiornerà tutti i record se la chiave definita esiste, in caso contrario verrà inserito un nuovo record)
```

### UPDATE E MERGE:

Questa modalità consente di aggiornare i record già esistenti (Update), oppure aggiornare ed inserire altri record (Merge).

Qui almeno una colonna chiave deve essere specificata per ciascuna  Tab descritta (genitore o dettaglio) nel record di intestazione,  altrimenti il processo verrà interrotto e un'eccezione sarà generata  sullo schermo con questo messaggio "***There must be key columns in order to update or merge record(s)***" Qui dobbiamo inserire lo "/K" nelle colonne chiave, **Ovviamente lo inserisco nel mio file excel**  e non nel campo header dell'Import Template. È possibile sceglierne più  di uno di loro (come chiave primaria congiunta). Così si dovrebbe  contrassegnare sia la colonna che si collega al record principale che la  colonna del subrecord con "/K". Vediamo l'esempio:


[{{< figure src="/image/ImportDataCSV3_3.png"  width="850"  >}}](/image/ImportDataCSV3_3.png)




Nel nostro esempio del Import Product abbiamo impostato lo"/K" nelle due colonne chiavi seguenti:

```
*Value/K                                   (Chiave del Product)
*M_ProductPrice>M_Product_ID[Value]/K      (Chiave del Product-->Price)
```

---

## SCHEDULAZIONE

Dopo aver copiato il file csv nella directory /opt/idempiere/InOut/

Entrare nella Window "Scheduler" ed impostiamo i seguenti parametri:

[{{< figure src="/image/ImportDataCSV4_4.png"  width="850"  >}}](/image/ImportDataCSV4_4.png)

(http://192.168.178.102/index.php/File:SchedulerImportCSV.png) 


[![SchedulerImportCSV.png](http://192.168.178.102/images/thumb/6/64/SchedulerImportCSV.png/1400px-SchedulerImportCSV.png)](http://192.168.178.102/index.php/File:SchedulerImportCSV.png) 

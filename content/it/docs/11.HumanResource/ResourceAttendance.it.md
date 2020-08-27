---
title: "Rilevamento Ore [RO10]"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 1
pre: "<b></b>"
---

## Riferimenti

- link pubblico  : non applicabile
- link idempiere italia  : <https://bitbucket.org/consulnet/idempiere-ita-plugin> - it.cnet.impl.resource_attendance
- link jar  : /opt/repos/idempiere-download/plugin-italia/ResourseAttendance/
- versione idempiere  : idempiere 3.1
- versione zk supportata : zk8

---

## Prerequisiti per l'installazione

Installare prima:

```
1) 2packSystemBase
2) Plugin Contract
3) Plugin PaymentTerm 
4) Plugin Withholding
```

---

## Descrizione Plugin

Premessa

Le trasferte sono gestite a sistema come dei codici articolo di servizio ( PRODOTTO ) Esempio T.01 zona A 20 € T.02 zona B 30 € T.03 zona C 50 €

---

## Funzionalità supportate

- conferma ore
- approvazione ore

### Creazione ResourceAttendance tramite schedulazione (??) da tabella creata tramite trigger

Data una tabella popolata tramite trigger, di nome "LIT_Ext_RilIngr" (window Resourse Attendance Raw Data), che contiene i dati di "strisciata badge", è stato creato un processo che permette di creare record di Rilevamento ore, per ogni utente specifico.
Per utilizzare questo processo, bisogna specificare il processo chiamato "Create Res. Attendance From Raw Data" nella maschera "Scheduler" a livello Client; e per filtrare i DataType di tipo ResourceAttendance, bisogna creare un variabile di sistema, a livello System, nella maschera "System Configurator" con nome "LIT_RilIngrDatatype" e valore '10', oppure '20',...ecc, Se non viene specificato, il valore di default sul processo java è uguale a '20'.
Verrà quindi recuperato il campo DataType (es:20) presente nella maschera "Resourse Attendance Raw Data". Inoltre verrà caricato l'utente che ha lo stesso LIT_RFID presente nella window Resource

---

## Installazione Plugin

Installare nella console felix il jar reperibile su [idempiere-download](https://bitbucket.org/consulnet/idempiere-download)

Tenere conto che nel 2pack, c'è la dichiarazione della window "Sales Order 2", che ha la gestione del contact activity come sua sotto tab; per via di esportazione dati di questa window, purtroppo porta con sè alcuni dati sporchi e quindi, se nell'installazione del plug-in si verificano degli errori, bisogna operare manualmente sul packOut creato (A.Checchia 19/05/2017)

### Grafici sul cruscotto per i client

Per visualizzare nella Home (a livello Client) il grafico Rilevamento Ore (Cruscotto Rilevamento Ore) dobbiamo creare il record nella maschera Dashboard Content. Entriamo nel Client desiderato ed inseriamo a mano nella Dashboard Conent i seguenti 2 record (questi 2 record devono avere il campo Chart impostato a Hours Resource e Hours Resource 2) (Questo setaggio può essere inserito successivamente nel InitialCLientSetup_CLIENT)

---

## Parametrizzazione Plugin

```
* Definire un Resource Type
```

**PUNTO 2:** aggiunto/da aggiungere una variabile sul System Configurator (livello Client) dal nome ***LIT_RILOREPROD_VIEW*** e assume valore stringa di 4 caratteri, caratteri che fanno riferimento a valori booleani, ad esempio "NYNY". Questa variabile gestisce la visualizzazione dei campi di ricerca sulla maschera/Form "Resource Attendance PROD". Ogni carattere corrisponde al campo di ricerca di

- Request(Richiesta)
- Project(Progetto)
- Production(Produzione)
- Order(Ordine)

Questa variabile, se non presente sul System Configurator, è gestita di default sul codice java ed ha come valore *YYYY* -> visualizzazione di TUTTI i campi ricerca sopra definiti


**PUNTO 3:** aggiunto/da aggiungere una variabile sul System Configurator (livello Client) dal nome ***LIT_SHORTCUT_RESATTENDANCE***; valore di confronto per far applicare in modo automatico il processo di avvio/salvataggio rilevamento ore produzione. Questo confronto avviene quando sul campo "Nome" della form si da INVIO (soprattutto da comando da barcode....): se il campo contiene il valore del parametro presente sulla variabile, allora si avvia automaticamente il processo del bottone START/STOP della form.

---

## Istruzioni Plugin

### inserimento ore per accredito (sconto )

```
 Esempio : viene riconosciuto un credito di 2 ore di intervento da scontare nella prossima fattura di consulenza
 Inserire un rapportino con la risorsa definita e impostare il nr delle ore dsiderate (esempio 2 )
 Esempio  : Longo Marco   dal 1-2-2016 ore 8.00 al 1-2-2016 ore 10.00  totale ore 2
 Il sistema calcola l'importo totale in base al listino  Esempio 70€ ora Totale 140
 E' sufficiente aggiungere il meno (-) davanti all'importo per renderlo sotto forma di credito importo 
 Questa riga verrà aggiunta insieme alle altre nel momento della creazione dell'ordine di vendita
```

---

## Documentazione Tecnica Plugin

### Modifiche all'AD

#### Existing Tables / Windows

#### New Tables /Windows

```
S_RES
```

#### Removed Tables /Windows

Campi tolti dalla Window Resource Attendance e Tab Resource Attendance (Project):

```
----------------------------------------
| RowType | TransfertType | Production | 
----------------------------------------
```

---

## Funzionalità Future

---

## Errori e bug

1. traduzioni

```
in caso di tipo risorsa non parametrizzato sulla risorsa compare il messaggio "Round Type not set"
```



```
Order Resource_Saved
```


Problemi rilevati dalla maschera INFORILEVAMENTO ORE

\1. lancio il processo APPENDRESOURCEATT INFO genera l'ordine con il riporto delle date non in ordine cronologico

\2. dopo aver lanciato il processo dovrebbe uscire una casella con scritto il numero ordine e la possibilità cliccando, di accedere direttamente all'ordine

\3. se le ore hanno importo a 0 perché non vanno addebitate, ma riportate in fattura, non crea le linee all'interno dell'ordine

\4. TRASFERTE : non riporta tutte le trasferte a livello di ordine. Se nel rilevamento ore sono riportate non c'è una corrispondenza a livello di ordine (vedere se dipende dal fatto che nell'ordine riporta una riga cumulativa es. "n. 5 trasferte" e non riga per riga)

\5. vedere quando il processo deve mettere il flag sul campo fatturato all'interno della maschera Rilevamento Ore.

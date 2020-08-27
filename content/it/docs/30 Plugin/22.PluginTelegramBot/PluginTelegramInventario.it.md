---
title: "Plugin Telegram Inventario"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 15
pre: "<b>722. </b>"
---


```
Nel Telecomando c'è una operazione di o nome "inventario " che associa il processo "inventory" (hard coded)
```

### Punto 1 - Inserimento Testata - Magazzino

```
Domanda         : Indica il magazzino :
Attendo input   : M01  (esempio di inserimento dell'operatore)
Verifico se è un magazzino valido
a) se è valido     -> Rispondo "Magazzino [M01] Mag Produzione OK "
                             "Inizio procedura Inventario"
 CREO LA TESTATA del PHYSICAL INVENTORY   
* L'unità organizzativa viene presa quella indicata nella maschera Utente > campo "Unità Organizzativa della Transazione"
  [controllare se non presente e segnalare l'anomalia per evitare NPE ]
* Tipo di documento : cercare il doctype_id con questo filtro MMI è isdefault ='Y'
* Data del movimeno = SYSDATE
procedo al punto 2
b) se il magazzino non è valido  ->Rispondo  "Magazzino non valido " e torno al punto 1)
```

### Punto 2 - Inserimento righe

```
domanda : "Inserisci il Cod.Prodotto :"
Attendo input
cerco il prodotto  prima la righe dell'inventario e riporto quello altrimento  vaod m_storageonhand  ( ricerca x  value,name,barcode,sku )
a) se non trovo il codice  -> Rispondo "Prodotto non trovato "
                                  e torno al punto 2
b) trovo il codice
  mi trovo la descrizione e giacenza per il magazzino selezionato 
  e Rispondo  "1234123213 Candela rossa  qta 7 "
              "Inserisci la quantità :
Attendo input 
a) se l'input è un numero registro la riga  DI PHYSICAL INVENTORY  e TORNO al punto 2  
   [se l'insert va in errore per duplicazione dare un messaggio "Prodotto già inserito" e tornare al punto 2
  
b) se l'input non è un numero Rispondo-> " Inserire un numero oppure salta per reinserire un nuovo prodotto oppure exit per uscire"
0) se inserisco exit  Rispondo "Inserimento Procedura inventario completata - Riporto qui di seguito i dati inseriti "
    faccio una select product ,qty e la mostro come elenco
     Esempio
     123123123 candela ross qty 4
     22222222  mouse nero   qty 5
```

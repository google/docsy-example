---
title: "Import Model"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 40
pre: "<b> </b>"
---
# Import Model



## Descrizione

Questa guida mostrerà come importare uno o più prodotti con i relativi prezzi e approvvigionamenti
tramite importazione dati in formato CSV.

Prerequisiti:
* Suite office (Libreoffice, OpenOffice, un programma che possa aprire un foglio di lavoro sostanzialmente)
* Istanza di iDempiere funzionante



## Cosa fare e come

Come prima cosa, bisogna aprire il documento dove sono presenti i dati da importare. Supponendo che i dati provengano da un foglio di calcolo, la situazione potrebbe corrispondere alla seguente

Ci sono tre file :

Importazione Prodotti
* ImpostazioneProdotto.csv

Campi Necessari
Value : Codice / Nome breve

Esempio Machieraldo : 

Copiare tutte i dati da seconda riga ..tutte le colonne

```
CODICE
DESCRIZIONE 
UNITA DI MISURA 
IMBALLO(QTA xscatola)
SOLOSCATOLA
Prezzo
Barcode
```


UM : Convertire Cf -> Numero



Importazione Listini

Importazione Approvigionamento 




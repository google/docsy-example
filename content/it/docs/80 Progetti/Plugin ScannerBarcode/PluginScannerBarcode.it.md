---
title: "Progetto Scanner Barcode"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 300
pre: "<b> </b>"
---
 




- link 2pack  : /opt/repos/idempiere-download/plugin-italia/ScannerBarcode_Save&New/2packScannerBarcode_Save&New.zip

---

## Descrizione Plugin

Plugin per semplificare l'inseriemnto dei Prodotti da Barcode

Callout che mi consentono di salvare ed andare su una riga successiva.

Inserendo nel mio campo LIT_Barcode il mio Barcode ho 4 casistiche:

```
1) Se il codice Barcode=Prodotto  --> allora automaticamente verrà copiato nel campo  M_Product il codice, salverà e andrà sulla riga successiva
2) Se il codice Barcode=Numero Quantità --> automaticamente verrà copiato nel campo  QtyEntered il numero e il focus si sposterà sul Prodotto
3) Se il codice Barcode presenta dei caratteri che non sono nè codici cè quantità -> mi fuoriesce una popup di avvertimento ERRORE
4) Se il codice Barcode=".Undo"  --> Ignora l'ultima modifica e torna indietro
```

Vedi le immagini seguenti:

![Barcode1.png](/image/PluginScannerBarcode1.png)


![Barcode2.png](/image/PluginScannerBarcode2.png)

![Barcode2.png](/image/PluginScannerBarcode3.png)



## Parametrizzazione

NOTA BENE: Column presente nella C_OrderLine (Ricordarsi di Creare la Fields)

```
1) Agganciare la collout "@script:beanshell:Save&New" nella column M_Product_ID
1) La collout "@script:beanshell:BarcodeSave&New" è già agganciata nella column LIT_Barcode
```

 

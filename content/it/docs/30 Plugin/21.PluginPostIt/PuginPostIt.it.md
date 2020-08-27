---
title: "Plugin PostIT"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b>721. </b>"
---

## Riferimenti

- link pubblico  : non applicabile
- link idempiere italia  : <https://bitbucket.org/consulnet/idempiere-ita-plugin>
- link jar  : /opt/repos/idempiere-download/plugin-italia/LIT_PostIt/
- versione idempiere  : idempiere 3.1
- versione zk supportata : zk8

[![PostIt 1.png](http://192.168.178.102/images/thumb/c/c3/PostIt_1.png/800px-PostIt_1.png)](http://192.168.178.102/index.php/File:PostIt_1.png)

---

## Descrizione Plugin

Tramite questa maschera tecnica, vengono impostati i criteri per far comparire in determinate maschere dei messaggi post-it.

Nell'esempio immagine che segue:

- si vuole ricordare che ogni volta che si crei una offerta d'ordine, un determinato BPartner è indietro con i pagamenti; se viene selezionato quel BPartner nella testa dell'ordine, viene visualizzato il messaggio come memo....

[![PostIt 2.png](http://192.168.178.102/images/thumb/9/93/PostIt_2.png/800px-PostIt_2.png)](http://192.168.178.102/index.php/File:PostIt_2.png)


Nella window tecnica ***Post-it***, si possono creare da 1 a 5 criteri che permettono di far visualizzare il post-it di riferimento; devono essere tutte verificate per poter visualizzare il messaggio.

- Visualizzazione del messaggio

  solo a popup ==> mettendo un segno di spunta sul campo "*Popup visibile*"(window Post-it), il messaggio post-it compare a video nell'immediato

  solo valorizzazione su campo testo della maschera aperta ==> a fondo della window ***Post-it*** vi è la possibilità di impostare un campo di destinazione per inserire il messaggio post-it

  entrambi valorizzati

Es.

| Impostazione nella Window 'Post-it' + flag "*Popup visibile*" impostato a TRUE |
| ------------------------------------------------------------ |
| [![PostIt 3.png](http://192.168.178.102/images/thumb/7/79/PostIt_3.png/800px-PostIt_3.png)](http://192.168.178.102/index.php/File:PostIt_3.png) |
| Risultato nella Window di esempio 'Ordine di vendita         |
| [![PostIt 4.png](http://192.168.178.102/images/thumb/c/c9/PostIt_4.png/800px-PostIt_4.png)](http://192.168.178.102/index.php/File:PostIt_4.png)
Cosa deve fare il programma : |

In Determinate Maschere / Processi (sales order, purchase order, shipment customen,invoice ) quando seleziono un oggetto (BP ) / oppure quando salvo

verifico che esista un record con i requisiti richiesti Se i requisiti sono idonei posso : - fare comparire un messagio a video - valorizzat un campo della maschera

Esempio : sono nell’oridne di vendita - quindi cerco record con DOVE =SOCR ..ci sono si… carico il campo MESSAGGIO e se non è print faccio un messagio a video altrimenti carico un campo che si chiama LIT_POSTIT ( puoi una stampa lo usera )

RefListDOVE : SOCR : Sales Order on Create SOHBP : SaleOrder After BP selection” SOLAFPROD : Sales Order after Product selection” Alcuni esempio :

```
Postit 1 : 
voglio che nell’ordine di vendita solo per il cliente consulnet compaio l’avviso “pagare a vista merce” da riportare nel ddt 
-> si truduce in un record  
RECORD LIT_PostIt
Dove : SOHBP : “SalesOrder Header -  dopo selezione BP  “  ( RefListDOVE ) 
BP : Consulnet 
Product : “null”
Avviso : “pagare a vista merce”
Print : Yes/No
```

Nota : “maneggiare con il protocollo 27363” da caricare in un campo delle righe.


Nota “chiedere al cliente prima della conferma dell’ordine” Applicato a : 1 BP Dove : Prepare Sales Order

Nota Generica Buisiness Partner nella fattura

---

## Istruzioni Plugin

Il plug-in ha una ***callout*** che viene eseguita SOLO se viene dichiarata nel campo *"Callout"* di una determinata colonna di tabella nella maschera "Table and Column">"Column".... (a livello System)

La callout, da dichiarare interamente è:

```
it.cnet.idempiere.LIT_PostIt.callout.CalloutPostIt.postIt_call
```

- NOTA BENE

  Se nel campo *"Callout"* vi è già presente un'altra dichiarazione di callout, separarle con un ";"

  Esempio: **Tabella** C_Order>**Colonna** C_BPartner_ID ==> Field *"Callout"*: org.compiere.model.CalloutOrder.bPartner`;it.cnet.idempiere.LIT_PostIt.callout.CalloutPostIt.postIt_call`

---

## Documentazione Tecnica Plugin

[![Postit.png](http://192.168.178.102/images/thumb/8/83/Postit.png/600px-Postit.png)](http://192.168.178.102/index.php/File:Postit.png)

### Modifiche all'AD

#### Tables / Windows esistenti

#### Nuove Tables /Windows

LIT_Postit

```
* Value
* Name
* Description
* Product
* Business Partner
* Document type
* Direct Print
```

---

## Funzionalità Future

---

## Errori e bug

Punti di intervento

Sales Order

su prepare sales order EVENTHANDLER dopo selezione Business Partner CALLOUT -> messaggio subito dopo selezione product (line) CALLOUT -> subito ????? o al prepare ??? (deciderlo in ta



- Purchase Order

```
creazione purchase order
creazione purchase line
dopo selezione Business Partner
dopo selezione product (line)
```

- Shipment Customer

```
creazione shipment customer
creazione shipment customer
dopo selezione Business Partner
dopo selezione product (line)
```

Invoice Customer

```
creazione invoice customer
creazione invoice customer line
dopo selezione Business Partner
dopo selezione product (line)
```

Post-it : Note fattura - ordine di vendita - acquisti


Alcuni esempi pratici da poter implementare :

Nota Generica Buisiness Partner nell’offerta/ordine

Nota “chiedere al cliente prima della conferma dell’ordine” Applicato a : 1 BP Dove : Prepare Sales Order

---

## Analisi tecnica di sviluppo

Dati

| ID   | Window        | ad_fieldA_ID           | ad_fieldARef        | ad_fieldB_ID      | ad_fieldBRef | ad_fieldC_ID | ad_fieldCRef | Messaggio    |      | Note |
| ---- | ------------- | ---------------------- | ------------------- | ----------------- | ------------ | ------------ | ------------ | ------------ | ---- | ---- |
| 1    | 'sales order' | 755 (Business Partner) | 11 (Caglio          | null              | null         | null         | null         | Test solo BP |      | OK   |
| 2    | 'sales order' | 101 (caglio)           | 11 barre di metallo | Test BP+Product   |              | OK           |              |              |      |      |
| 3    | 'sales order' | null                   | 12 tondini di ferro | Test solo Product |              | OK           |              |              |      |      |

- Caso 1

```
Sono nella Sales Order 
- nella testata 
- seleziono il BP "caglio"
->   filtro   (window:"sales order",BP:"caglio,Product:null) 
Risultato sarò : SOLO 1  ( perchè il record 2 si applica solo per il prodotto specificato )
```

- Caso 2

```
Sono nella sales order 
- nella righe
- seleziono il prodotto 11 barra
->   filtro   (window:"sales order",BP:"caglio,Product:11) 
idem purchase order 
idem invoice vendor
idem invoice customer
idem m_inout ( entrata merci ,shipping customer )
Progetti  bp testata ok 
Progetti riga   devo avere il product ? 

Ad_user  
 ? per il socio andrea postit "consegnare la tessera"
 ? ad_field_id  
```


1) gestire 5 campi 2) add campo note per ogni field (5 note) 3) add campo output

```
  TAB XXXX FIELD  (stringa)  (modalità ADD )
```

---

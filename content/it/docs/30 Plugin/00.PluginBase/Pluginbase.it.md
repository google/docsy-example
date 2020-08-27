---
title: "Plugin Base"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b>700. </b>"
---

# Plugin: Base

---

## **ZOOM 2**

Link Video:

```
https://drive.google.com/open?id=0B54O_1iS-GCgN25heWZQUS1SWU0
```

Funziona solo per Window ed InfoWindow

## Funzionamento e parametrizzazione

Premendo il click dx del mouse su un determinato campo (ad es. Business Partner) possiamo aprire una Window oppure Info Window che ha come filtro quel determinato Business Partner.

Vediamo un semplice esempio pratico di Apertura di una InfoWindow (lo stesso procedimento vale per le Window)

[![Zoom1.png](http://192.168.178.102/images/thumb/c/c3/Zoom1.png/703px-Zoom1.png)](http://192.168.178.102/index.php/File:Zoom1.png)

Siamo all'interno di un ordine (Sales Order oppure Purchase Order), vogliamo poter aprire una Info Window direttamente dal campo Business Partner (es Business Partner: Standard), questo per consentirci di visualizzare tutte le Fatture che fanno riferimento al Business Partner Standard.

[![Zoom2.png](http://192.168.178.102/images/thumb/a/ab/Zoom2.png/800px-Zoom2.png)](http://192.168.178.102/index.php/File:Zoom2.png)

La parametrizzazione è la seguente:

Entriamo come System. Andiamo nella tabella C_BPartner, Tab Zoom Condition e settiamo i seguenti parametri


[![Zoom.png](http://192.168.178.102/images/thumb/9/96/Zoom.png/800px-Zoom.png)](http://192.168.178.102/index.php/File:Zoom.png)

# **GENERAZIONE REPORT DA INFOWINDOW**

È stata aggiunta la possibilità di generare 1 o più report direttamente dalla infoWindow, a seconda della selezione fatta a video.

[![Report InfoWindow 1.png](http://192.168.178.102/images/thumb/7/71/Report_InfoWindow_1.png/800px-Report_InfoWindow_1.png)](http://192.168.178.102/index.php/File:Report_InfoWindow_1.png)

|                                        | Passo 1                                                      | Passo 2                                                      | Passo 3                                                      |
| -------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| Più report per ogni record selezionato | [![Report InfoWindow 2.png](http://192.168.178.102/images/thumb/2/24/Report_InfoWindow_2.png/600px-Report_InfoWindow_2.png)](http://192.168.178.102/index.php/File:Report_InfoWindow_2.png) | [![Report InfoWindow 3.png](http://192.168.178.102/images/thumb/d/de/Report_InfoWindow_3.png/600px-Report_InfoWindow_3.png)](http://192.168.178.102/index.php/File:Report_InfoWindow_3.png) | [![Report InfoWindow 4.png](http://192.168.178.102/images/thumb/5/57/Report_InfoWindow_4.png/600px-Report_InfoWindow_4.png)](http://192.168.178.102/index.php/File:Report_InfoWindow_4.png) |
|                                        | Verificare che nel jasper report ci sia il parametro 'RECORD_ID' nella condizione WHERE | Nella maschera "Report & Process" togliere il flag al campo "isBetaFunctionality". RICORDA: il bottone processo per la infoWindow, deve essere creato nella infoWindow corrispondente, a livello System.... | Per ogni record selezionato, bisogna lanciare il processo di anteprima Report; ciò vuol dire che per ogni anteprima, bisogna schiacciare il pulsante "OK" dell popup attiva sulla infoWindow |
|                                        | Passo 1                                                      | Passo 2                                                      | Passo 3                                                      |
| Unico report dei record selezionati    | [![Report InfoWindow 5.png](http://192.168.178.102/images/thumb/c/ca/Report_InfoWindow_5.png/600px-Report_InfoWindow_5.png)](http://192.168.178.102/index.php/File:Report_InfoWindow_5.png) | [![Report InfoWindow 6.png](http://192.168.178.102/images/thumb/6/6c/Report_InfoWindow_6.png/600px-Report_InfoWindow_6.png)](http://192.168.178.102/index.php/File:Report_InfoWindow_6.png) | [![Report InfoWindow 7.png](http://192.168.178.102/images/thumb/a/af/Report_InfoWindow_7.png/600px-Report_InfoWindow_7.png)](http://192.168.178.102/index.php/File:Report_InfoWindow_7.png) |
|                                        | Verificare che nel jasper report che ci sia un inizio di query come da esempio("-- "+NOME_TABELLA) e che nella condizione WHERE non ci sia nessun riferimento al RECORD_ID e impostato come da esempio | Nella maschera "Report & Process" mettere il flag al campo "isBetaFunctionality". RICORDA: il bottone processo per la infoWindow, deve essere creato nella infoWindow corrispondente, a livello System.... | Selezionare i record che interessano e poi lanciare il processo di anteprima Report; questo tipo di processo, crea il report unico in base ai filtri impostati nella info window |



# **COPIA OFFERTA-ORDINE DA TEMPLATE**

[![OrderTemplate 1.png](http://192.168.178.102/images/5/51/OrderTemplate_1.png)](http://192.168.178.102/index.php/File:OrderTemplate_1.png)

Creazione di un ordine partendo da un o più template impostati nel campo Order + aggiungere, nel nuovo ordine, un determinato prodotto presente nella lista del campo Product. Il campo Order e Product sono OBBLIGATORI: se non settati, il processo di creazione da template non funziona.


Per avere uno o più ordine come template, bisogna mettere un flag nella Window “Sales Order” al campo isOrderTemplate, per ogni ordine che si vuole utilizzare come template.

[![OrderTemplate 2.png](http://192.168.178.102/images/8/8a/OrderTemplate_2.png)](http://192.168.178.102/index.php/File:OrderTemplate_2.png)


Per avere una lista di prodotti validi, bisogna settare un ordine specifico (ordine possibilmente con più prodotti...) nel campo Order nella Window “Client>Client Info”

[![OrderTemplate 3.png](http://192.168.178.102/images/0/09/OrderTemplate_3.png)](http://192.168.178.102/index.php/File:OrderTemplate_3.png)

Alla fine della creazione, comparirà un campo dove verrà indicato il nuovo ordine appena creato; basta fare “zoom” sul campo, così da poter visualizzare l'ordine, con le sue linee d'ordine.

[![OrderTemplate 4.png](http://192.168.178.102/images/8/8c/OrderTemplate_4.png)](http://192.168.178.102/index.php/File:OrderTemplate_4.png)

## Classi java utilizzate

- `it.cnet.idempiere.orderTemplate.callout.CallOrderWizard`

## **CREA LISTINO**

Selezione di un prodotto che non rientra nel listino prezzi impostato al livello di testata dell’ordine. Errore che si riscontra: es. Error: Product is not on PriceList - Line No:10, Product:Standard, Price List:PL_Test2014_SALES, Date:09/05/2014

Soluzione:

\- impostare una variabile sul System Configurator → IDIT_PO_PriceList (questa mi consente di inserire il listino prezzi se non è presente nel prodotto)

Per impostare la possibilità di far rientrare il prodotto nel listino prezzi procedere così:

Se la mia variabile IDIT_PO_PriceList è stata impostata a:

```
N -->  non  entro nel plugin
0 -->  se non c’è pricelist  salvo con price=0 
Y -->  se non c’è pricelist salvo price = orderlineprice
P -->  se non c’è pricelist  popup  “ vuoi creare il listino con il prezzo dell’ordine ? Y/N (da fare)
U -->  se non c’è pricelist, mi comporto come punto ‘Y’; se c’è pricelist, allora aggiornare quello esistente, se il relativo BPartner 
       abbia il flag “PriceListUpdatable” spuntato
X -->  solo se il BPartner ha il flag “PriceListUpdatable” spuntato: (1)se non c’è pricelist, mi comporto come punto ‘Y’; 
       oppure (2) se c’è pricelist, allora aggiornare quello esistente
```

## Classi Java utilizzate

- `it.cnet.idempiere.orderTemplate.model.ModelFactory_cnet`

## **ORDERMANDATORY in Shipment**

- Problema

  Nella creazione manuale di un documento di spedizione (Shipment), al momento del salvataggio, a livello di testata e di riga risulta obbligatorio il settaggio dell’ordine/ordine-riga.

- Soluzione

  Impostato una variabile sul System Configurator → IDIT_Shipment_OrderMandatory (Y/N)

## Classi Java utilizzate

- `it.cnet.idempiere.orderTemplate.model.ModelFactory_cnet`
- `it.cnet.idempiere.orderTemplate.model.MInOut_StepOver`
- `it.cnet.idempiere.orderTemplate.model.MInOutLine_StepOver`

## **SHOURTCUT SaveNew/Save (BARCODE FROM PRODUCT) DEPRECATO**

Non più utilizzato perchè gestito in modo migliore con le Rule: vedi: <http://188.228.172.188/index.php/Plugin_ScannerBarcode_Save%26New>

Link Video:

```
https://drive.google.com/open?id=0B54O_1iS-GCgV1Jwc2JRWjFvd2s
```

- Problema

  Avere la possibilità di inserire/salvare/creazione nuove righe ogni volta che immetto un determinato codice .

- Soluzione

  Impostato variabili sul System Configurator (livello CLIENT):→ LIT_SHORTCUT_SAVENEW: aggiungere un valore di confronto per far scatenare l'evento del salvataggio riga/record e creazione nuova riga/record→ LIT_SHORTCUT_SAVE: aggiungere un valore di confronto per far scatenare l'evento del salvataggio riga/recordA livello SYSTEM, impostare su Table & Column>Column(...scegliere quale campo da far scatenare la callout...)>campo "Callout" la seguente classe*it.cnet.idempiere.orderTemplate.callout.CallUtility.shourtCut*

## Classi Java utilizzate

- `it.cnet.idempiere.orderTemplate.callout.CallUtility.java`

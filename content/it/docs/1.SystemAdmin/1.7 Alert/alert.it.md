---
title: "Allarmi"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 17
type : "post"
pre: "<b>1.7 </b>"
---

## Creare un Alert (Avviso)

Video - SystemAdmin-Alert [V089] 
Video - SystemAdmin-Alert Esempio Prodotto Deperibile se Termini di Pagamento 30 [V123]

```
http://www.adempiere.com/Creating_an_Alert
```

In iDempiere, gli avvisi possono essere impostati per inviare informazioni agli utenti interessati in momenti specifici o se sono soddisfatte le condizioni specifiche del database. I report giornalieri, avvisi di scadenza, avvisi limite di archiviazione dati - tutto ciò che si può definire con una query SQL, può essere trasformato in un avviso. Descriviamo i passaggi necessari per creare gli Alert:

---

## Prerequisiti

Prima di iniziare, assicurarsi di avere l'e-mail di lavoro all'interno iDempiere. Passare alla ***Menu » System Admin » General Rules » Client Rules » Client*** per impostare e testare il sistema di posta elettronica. Ogni utente che deve ricevere le informazioni di allarme deve avere un indirizzo e-mail valido nella loro ***User*** (Informazione Utente) Un processore di allarme (Alert Processor) determina la frequenza con la quale la query di Alert (di avviso) viene valutata. Alert Processor (processori di avviso) possono essere trovati sul ***Menu » System Admin » General Rules » Server » Alert Processor.***

---

## Alert Processor

Come prima cosa accedere a livello Client come amministratore Vediamo un Esempio impostazione di un processore di avviso (Alert Processor):




[{{< figure src="/image/Alert-0.png"  width="850"  >}}](/image/Alert-0.png)


## Passi Alert

Come prima cosa accedere a livello Client come amministratore

Passare alla ***Window Menu » Performance Analysis » Performance Measurement » Alert***

Creare un nuovo record e dargli un nome ragionevole

Selezionare un Alert Processor esistente o crearne uno nuovo (vedi sezione sopra)

Inserire l'oggetto e il messaggio di avviso. Questi saranno utilizzati come soggetto e messaggio nella e-mail che vengono inviati

Segnare il record come valido (IMPORTANTE perchè funzioni)

Salvare il record

Passare alla scheda ***Alert Rule***

Creare un nuovo record e dargli un nome ragionevole

Nel campo sqlSelect, sqlFrom, sqlWhere inserire le istruzioni SQL

Segnare il record come valido (IMPORTANTE perchè funzioni)

Salvare il record

Passare alla scheda ***Alert Recipient*** (destinatario)

Creare un nuovo record

Selezionare un utente / Contatto

Salva record

Ripetere gli ultimi tre passaggi per ogni utente che deve ricevere l'avviso.



Window ALERT:
[{{< figure src="/image/Alert-1.png"  width="850"  >}}](/image/Alert-1.png)



Tab ALERT RULE:
[{{< figure src="/image/Alert-2.png"  width="850"  >}}](/image/Alert-2.png)


Tab ALERT RECIPIENT:
[{{< figure src="/image/Alert-3.png"  width="850"  >}}](/image/Alert-3.png)




**ATTENZIONE!!!** In questa maschera abbiamo aggiunto un campo "User SQL Field" che permette di specificare un campo utilizzato nella select e a cui verrà inviata la mail, es: salesrep_id **(estensione al plugin LIT_SendMail)** --> <http://188.228.172.188/index.php/Plugin_Send_Mail#Estensione_ALERT>

---

## Testare il nuovo Alert

Avviare Application Server se non è stata ancora avviata. In un browser, accedere al IDempiere Application Home Page. Clicca su IDempiere Management Server (iconcina in alto a destra) e accedere come utente di sistema.

Nella pagina Server Monitor, passare al processore di allarme che si è assegnato come avviso. Clicca su *"Run Now"* .

Passare indietro al processore di allarme nella pagina Monitor e controllare il log. Se l'Alert non è andato a buon fine, allora possiamo vedere il log direttamente aggiornando la sottoTab Alert Rule. Qui possiamo vedere gli eventuali log. Ad esempio:

[![Alert4.png](800px-Alert4.png)](http://192.168.178.102/index.php/File:Alert4.png)


**ATTENZIONE**: Una volta che le necessarie correzioni sono state fatte, si devono marcare l'avviso e la regola di avviso come valida di nuovo. (il campo "Valid" presente sia nella window "Alert" che nella sua relativa sottotab "Alert Rule" deve essere selezionato come valido)

---

## **Esempio 1 Un elenco di ordini attualmente attivi**

Invia una segnalazione contenente l'elenco di tutti gli ordini attivi nel sistema.

Seguendo i passi sopra, impostare i campi Alert Rule come segue:

```
   sqlSelect = "C_ORDER_ID","DOCUMENTNO","DOCSTATUS","TOTALLINES","GRANDTOTAL" 
   sqlFrom = C_ORDER 
   sqlWhere = ISACTIVE='Y' AND ISSOTRX='Y'
```

---

## E**sempio 2 Completato ordini dovuti per la consegna**

Invia un avviso messa in vendita di ordini completati che sono dovuti per la consegna entro i prossimi 7 giorni.

Completare i passaggi di cui sopra per l'esempio 1, ma cambiare la clausola di *sqlWhere* sulla scheda Alert Rule come segue:

```
 sqlWhere = ISACTIVE='Y' AND ISSOTRX='Y' AND DOCSTATUS='CO' AND ISDELIVERED='N' AND DATEPROMISED between sysdate and (sysdate +7)
```

---

## Esempio 3 ordini per specifici agenti di vendita

Invia un avviso con un allegato di tutti gli elementi di linea ordine inseriti oggi con i campi elencati di seguito per il rappresentante di vendita il cui nome è l'ordine. (Richiede che il rappresentante di vendita ha "e-mail" come tipo di avviso nella finestra utente, controllare anche la vostra client_id - l'esempio utilizza 1000000)

```
 Customer Name; Contact Name; Order Number; Order line number; Date Promised; Product Name; Order Line Description; Qty; Unit of Measure; Price, Line amount; Currency; Order-Entry-User 
```

SQL Select:

```
  bp.name , au1.name , o.documentno, ol.line, o.datepromised, mp.name , ol.description, ol.qtyordered, uom.name, ol.priceactual,ol.linenetamt, cur.iso_code, au2.name, au3.name
```

SQL From:

```
adempiere.c_orderline ol
join adempiere.c_bpartner bp on ol.c_bpartner_id=bp.c_bpartner_id 
join adempiere.c_order o on ol.c_order_id=o.c_order_id
join adempiere.ad_user au1 on o.ad_user_id=au1.ad_user_id
left join adempiere.m_product mp on ol.m_product_id=mp.m_product_id
join adempiere.c_uom uom on ol.c_uom_id=uom.c_uom_id
join adempiere.c_currency cur on o.c_currency_id=cur.c_currency_id
join adempiere.ad_user au2 on o.createdby=au2.ad_user_id
left join adempiere.ad_user au3 on o.salesrep_id=au3.ad_user_id
```

sql Where:

```
ol.ad_client_id='1000000' 
and extract('day'  from  ol.created)=extract('day' from timestamp 'now()')
and extract('day'  from  o.created)=extract('day' from timestamp 'now()')
and au3.name='REPLACE-THIS-WITH-SALESMANS-NAME'
;
```

 

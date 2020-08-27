---
title: "Contratti"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 260
pre: "<b></b>"
---


## Crea Contratto da ordine [CCO20]
[{{< figure src="/image/ContrattodaOrdine.png"  width="850"  >}}](/image/ContrattodaOrdine.png)
## Contratto di Vendita [CDV20]
[{{< figure src="/image/Contrattodivendita.png"  width="850"  >}}](/image/Contrattodivendita.png)
## Crea ordine di vendita da contratto [COVC20]
[{{< figure src="/image/CreaOrdinediVenditaContrattoCOVC20.png"  width="850"  >}}](/image/CreaOrdinediVenditaContrattoCOVC20.png)
## Info contratto di vendita [COVC20]
[{{< figure src="/image/IfoContrattodiVendita.png"  width="850"  >}}](/image/IfoContrattodiVendita.png)
## Scheda Business Partner [ICV00]
[{{< figure src="/image/SchedaBP0.png"  width="850"  >}}](/image/SchedaBP0.png)


## link esterni

---

## Riferimenti

- link pubblico  :
- link idempeire italia  :
- link jar  : /opt/repos/idempiere-download/plugin-italia/Contract/
- versione idempiere  : idempiere 3.1
- versione zk supportata : na

---

## Specifiche di ambiente test/demo

```
database    : idempiere_demobase
application : idempiere-demobase
```

---

## Link documentazione esterna

---

## Descrizione Funzionalità

Maschera gestione contratto , con dettaglio di righe .

![Contract 1.png](/image/Contract_1.png)

## Processo di accodamento all'ordine di vendita.

![Contract 2.png](/image/Contract_2.png)

![Contract 3.png](/image/Contract_3.png)


 Processo che permette di associare i contratti presenti ad un nuovo ordine o ad un ordine già presente.

- Validity date: criterio → ricerca i contratti che sono ancora attivi, in base alla data impostata

> MContract.COLUMNNAME_validfromdate + "<= ? AND " +
>  MContract.COLUMNNAME_validtodate + ">= ? AND " +
>  MContract.COLUMNNAME_DateInvoiced + "< ? AND "

- I contratti creati sono associati ad un Business Partner, quindi la scelta del BusinessPartner risulta obbligatoria

- Si può associare i contratti ad un ordine già presente, selezionando Sales Order desiderato

Il processo creerà un nuovo ordine (se non è esistente) e rispettive  linee ordine in base al numero delle linee di contratto presenti.


 Dati salvati:

```
product_ID, 
qty, 
price, 
contractID, 
C_UOM_ID
```

Una volta creato/aggiornato l'ordine, sul contratto verrà  visualizzato il numero dell'ordine associato e sulle righe d'ordine  verrà segnalato il contratto associato.



- A fine processo, verrà visualizzato un messaggio, dove verrà indicato

  1) il numero dei contratti salvati e l'ordine di riferimento.

- oppure

  2) nessun contratto è stato elaborato.

### Processo di accodamento dal ....

### Gestione ticket iTop

Creazione di utenze iTop per gestione dei ticket su iTop; la  creazione avviene nel momento del salvataggio dell'utente associato al  BPartner presente sulla *sotto-tab "Contract > Contact (User) for Web Ticket"* e che abbia il **flag "Web Ticket"** abilitato
 
![Contract 4.png](/image/Contract_4.png)
![Contract 5.png](/image/Contract_5.png)
![Contract 6.png](/image/Contract_6.png)


 Per riferimenti specifici su iTop, vedere la pagina wiki [ITop](http://192.168.178.102/index.php/ITop)
 
 Per il corretto funzionamento di questa funzione, è IMPORTANTE inserire le giuste credenziali di iTop nella *maschera "Client > Client Info"*
 [![Contract 7.png](http://192.168.178.102/images/thumb/e/ee/Contract_7.png/1050px-Contract_7.png)](http://192.168.178.102/index.php/File:Contract_7.png)

---

## Da Fare

---

## Modifiche all' AD

### Existing Tables / Windows

### New Tables /Windows

```
C_Contract
C_Contract_line
```

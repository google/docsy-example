---
title: "Plugin Sign Document"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b>737. </b>"
---

# Plugin: Sign Document

---

## PINCODE

---

## Riferimenti

- link pubblico  :
- link idempeire italia  :
- link jar  :
- versione idempiere  : idempiere 4.1
- versione zk supportata : zk8

---

## Prerequisiti per l'installazione

---

## Descrizione Plugin

La funzionalità di questo plug-in permette di apporre "una firma" di approvazione/presa visione del documento o di un determinato record a video. Nel stesso tempo, se è previsto dalla tabella con la presenza di campi di Doc Status e Doc Action, vi è anche la possibilità di completare direttamente il documento a video. (Impostato di default sulla window Quality Test)

[![SignDocument 1.png](http://192.168.178.102/images/thumb/8/82/SignDocument_1.png/880px-SignDocument_1.png)](http://192.168.178.102/index.php/File:SignDocument_1.png)
[![SignDocument 2.png](http://192.168.178.102/images/thumb/f/fc/SignDocument_2.png/880px-SignDocument_2.png)](http://192.168.178.102/index.php/File:SignDocument_2.png)

---

## Funzionalità supportate

---

## Installazione Plugin

Installare nella console felix il jar reperibile su [idempiere-download](https://bitbucket.org/consulnet/idempiere-download)

**Nome plug-in:** *it.cnet.impl.LIT_SignDocument.jar*

---

## Parametrizzazione Plugin

Per far funzionare i processi del plug-in, bisogna, come base, settare alcuni dati principali:

1. Creare le colonne sulle maschere che si vuole apporre la firma. Il 2pack del plug-in genera nel sistema i seguenti Element:
   - ***LIT_AD_User_Sign_ID***: nome colonna di tipo "Search" lungo 22 -- NOME FISSO DA NON CAMBIARE
   - ***LIT_Sign_Button***: nome colonna di tipo "Button" lungo 2 -- NOME FISSO DA NON CAMBIARE
   - ***LIT_Sign_Date***: nome colonna di tipo "Date+Time" lungo 7 -- NOME FISSO DA NON CAMBIARE
   - ***LIT_Sign_Image_ID***: nome colonna di tipo "Image" lungo 10 -- NOME FISSO DA NON CAMBIARE
2. Il 2pack crea sulla tabella "M_QualityTest" i campi prova sopra menzionati (Window "Quality Test")
3. Il 2pack crea una Reference di nome "AD_User - PINcode" --- viene utilizzata dal codice per determinare la lista degli utenti che posso apporre la firma
4. Per vedere la lista degli utenti abilitati alla firma, tramite la condizione impostata dalla Reference creata, è IMPORTANTE VALORIZZARE il campo "UserPIN" di ALMENO UN UTENTE su client....altrimenti il processo non funziona.....

---

## Istruzioni Plugin

Casi di utilizzo del Sign Document:

1. non c'è il campo lit_sign_ad_user a livello window, quindi il campo PinCode-utente è disabilitato e richiedo firma grafometrica; memorizzo la data di firma sulla window + l'immagine della firma
2. non c'è il campo lit_sign_image_id, quindi il campo PinCode-utente è abilitato e inserisco il codice, mentre il campo che gestisce la firma grafometrica non viene visualizzato e quindi non utilizzato; memorizzo l'ad_user e la data firma sulla window
3. ci sono tutti i campi, quindi richiedo il PinCode-utente e la firma grafometrica; memorizzo l'ad_user, la data firma e l'immagine della firma sulla window

L'apertura della popup di riferimento avviene SOLO se la data firma è uguale a NULL; altrimenti verrà bloccata...... (TODO: per sbloccare, fare una window che permette di cancellare la data firma e tutti gli altri campi.....)

---

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

---

## Funzionalità Future

---

## Errori e bug

---

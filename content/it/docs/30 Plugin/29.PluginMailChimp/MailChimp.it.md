---
title: "Plugin Mail Chimp"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b>729. </b>"
---

## link esterni

```
https://github.com/daamien/mailchimp_fdw
```

---

## Riferimenti

*link pubblico          : 
*link idempeire italia  : 
*link jar               : 
*versione idempiere     : idempiere 3.1
*versione zk supportata : 

---

## Descrizione Plugin

---

## Funzionalità supportate

---

## Installazione Plugin

Installare nella console felix il jar reperibile su [https://bitbucket.org/consulnet/idempiere-download idempiere-download]

---

## Parametrizzazione Plugin

---

## Istruzioni Plugin

---

## Documentazione Tecnica Plugin

### Modifiche all'AD

#### Tables / Windows esistenti

#### Nuove Tables /Windows

---

## Funzionalità Future

---

## Errori e bug

---

## Struttura dati

```
http://kb.mailchimp.com/accounts/management/about-api-keys
http://developer.mailchimp.com/documentation/mailchimp/?utm_source=apidocs&utm_medium=internal_ad&utm_campaign=api_v3
https://docs.treasuredata.com/articles/result-into-mailchimp
https://blog.iadvise.eu/2013/11/25/connecting-to-salesforce-and-mailchimp-using-talend/
```

---

## Struttura dei dati in iDempiere

* Area di Interesse  [ R_InterestArea ]
  * Sottoscrizioni   [R_InterestArea ]
  * Contatti         [Contatti]
  * Column : Name,Email

NEW COLUMN on ARea di Interesse  LIT_NEWSLETTER_ID

TABELLA :LIT_NEWSLETTER

```
LIT_NEWSLETTER_ID TIPOSERVIZIO   NOMELISTA       
1000000           MAILCHIMP      LISTAIDEMPIERE
```

## Struttura dei dati in MailChimp

Metodi : 

```
csv
json
https://drive.google.com/open?id=0B_cHtOEQolgGVHdFMkpIM29kZHM 
Progetto Talend



1) isMasterDAte  - > RInterestAre
2) Eamil from    ->  RintereArea

3) Adlicnet : mailchimp auth
4) adclient : mail ci auto dc

Processo su Toolbar interest area


```


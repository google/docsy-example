---
title: "Configuratore di Prodotto"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b>724. </b>"
---

## Progetto Product Configurator

---

## Riferimenti

* link pubblico          : non applicabile
* link idempiere italia  : https://bitbucket.org/consulnet/idempiere-ita-plugin - it.cnet.impl.LIT_ProductConfigurator
* link jar               : /opt/repos/idempiere-download/plugin-italia/LIT_ProductConfigurator/
* versione idempiere     : idempiere 3.1
* versione zk supportata : ??

---

## IMPORTANTE (Settare immagine bianca)

Copiare l'immagine Solid_white.png (presente /opt/repos/idempiere-ita-plugin/it.cnet.impl.LIT_ProductConfigurator/theme/default/images/) nella seguente directory:

```
/var/www/html/
```

---

## Parametrizzazione Plugin

'''TODO'''  Sistemare i campi BOM Product e Rule Product su maschera BOM Rule....

'''TODO'''  '''IMPORTANTE:'''

* modifica lunghezza campo tabella:

Table: M_Product_BOM - Column: BOMType Lunghezza:2

* valori(value) nella Reference per il BOMType

''gruppo alternative'' = mettere SOLO numeri

''gruppo optional''    = prefisso "'''O'''" + numero consecutivo. Es: "'''O'''1" - "'''O'''2" - etc....

### Tabelle da sincronizzare


{|style="border: 1px solid #789DB3; border-collapse: collapse; align:center; width:100%;"
|-
! style="background:#9aa3f9;align:left"|
! style="background:#9aa3f9;align:left"|
! style="background:#9aa3f9;align:left"|
! style="background:#9aa3f9;align:left"|
! style="background:#9aa3f9;align:left"|
|-
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|Giacenza
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|Si
! style="border: 1px solid #789DB3;"|BP Addresses
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|Ordine
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|Si
! style="border: 1px solid #789DB3;"|BP Addresses
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|Immagini ?
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
|-
|}

TABELLA PRODOTTO

## Documentazione Tecnica Plugin

### Gestione flag IsPhantom e IsSold (Prodotto)

Nel configuratore alcuni prodotti possono avere un diverso utilizzo. A cosa servono questi due flag? Vediamo:

Prodotti Normali --> prodotti aggiunti alla Configurazione e accodati all'ordine

```
IsPhantom=N 
IsSold=Y
```

NoSelection  --> prodotti aggiunti alla Configurazione e NON accodati all'ordine (servono solamente per passare da Tab in Tab)

```
IsPhantom=Y 
IsSold=N
```

Extra  --> prodotti NON aggiunti alla Configurazione e accodati all'ordine (sono prodotti Extra configurazione) --> CAMPO MODIFICABILE A LIVELLO DI "DESCRIZIONE"

```
IsPhantom=Y 
IsSold=Y
```

### Gestione flag IsLIT_PP_MPS (Prodotto)

Dal configuratore possiamo associare ad un prodotto una riga del Master Plan. Per abilitare questo campo basta che nel prodotto impostiamo IsLIT_PP_MPS='Y'

## Errori e bug

'''DOMANDA:''' ''come posso cancellare l'attributeSetInstance(ID) precedentemente salvata nella maschera(tabella)?''

'''RISPOSTA:''' metodo "macchinoso", ma efficace  ===> mettere a 'NULL' o cancello il campo-prodotto associato all'attributeSetInstance(ID) e subito dopo schiacciare sul bottone del campo dell'attributeSetInstance(ID), che non apre ovviamente la dialog ma imposta il valore a '0'; salvare il record o prima reimpostare solo prodotto e salvare.


TIPO DOCUMENTO per sequenza num : "PRD CONFIG"

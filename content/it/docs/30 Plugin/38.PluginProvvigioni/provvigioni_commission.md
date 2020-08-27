---
title: "promotions"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 25
pre: "<b>738. </b>"
---

# Plugin: Provvigioni / Commission

---

## Descrizione Plugin

```
TRADUZIONE 
Commissioni -> Provvigioni  PRO0
Msk Provvigioni :select su BP deve essere solo agenti (rappresentatnti)
```

```
Aggiunge 2 processi
CalCommForOrder - it.cnet.idempiere.commissions.process.CommissionCalcForOrder
CalcAllCommissions - it.cnet.idempiere.commissions.process.CalculateAllCommissions
```

```
COSA NEGATIVA : deve generare per ogni agente (???) ci vorrebbe un generara tutti gli agenti
```

```
FARE REPORT PROVVIGIONI a) revisione report con dettaglio prodotti  B) creare report con riepilogo Documento (no dettaglio prodotti)
```

Plugin commissioni

[![Provvigioni.png](http://192.168.178.102/images/a/a3/Provvigioni.png)](http://192.168.178.102/index.php/File:Provvigioni.png)

[![PluginCommisions Videata1.png](http://192.168.178.102/images/thumb/5/5d/PluginCommisions_Videata1.png/600px-PluginCommisions_Videata1.png)](http://192.168.178.102/index.php/File:PluginCommisions_Videata1.png)

---

## Funzionalità supportate

---

## Installazione Plugin

Installare nella console felix il jar reperibile su [idempiere-download](https://bitbucket.org/consulnet/idempiere-download)

---

## Parametrizzazione Plugin

[![PluginCommisions Param.png](http://192.168.178.102/images/thumb/2/29/PluginCommisions_Param.png/600px-PluginCommisions_Param.png)](http://192.168.178.102/index.php/File:PluginCommisions_Param.png)

---

## Istruzioni Plugin

---

## Documentazione Tecnica Plugin

### Modifiche all'AD

#### Tables / Windows esistenti

```
----------------------
| C_CommissionDetail |
----------------------
| nome column        | 
----------------------
| AmnLineCommission  | 
----------------------
| AmtMultiplier      | 
----------------------
| AmtSubtract        |
----------------------
| QtyMultiplier      |
----------------------
| QtySubtractor      |  
----------------------
```

```
-----------------------------------------
| Commission Run TAB> Commission Detail |
-----------------------------------------
| nome campo          | 
-----------------------
| Multiplier Amount   | 
-----------------------
| Subtract Amount     | 
-----------------------
| Multiplier Quantity | 
-----------------------
| Subtract Quantity   | 
-----------------------
| Line Commission     | 
-----------------------
```

```
--------------------------------------
| Sales Order TAB> Commission Detail |
--------------------------------------
| nome processo             | 
-----------------------------
| Calc All Commission       | 
-----------------------------
| Calc Commission for Order | 
-----------------------------
```

#### Nuove Tables /Windows

---

## Funzionalità Future

commission - aggiungere bottone processo calcolo provv su sales order

---

## Errori e bug

---

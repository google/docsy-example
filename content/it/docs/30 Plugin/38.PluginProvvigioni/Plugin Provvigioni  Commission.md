---
title: "Plugin Provvigioni"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 15
pre: "<b>738. </b>"
---

# Plugin Provvigioni / Commission

---

  Contents  [[hide](http://192.168.178.102/index.php/Plugin_Provvigioni_/_Commission#)]   [1 Descrizione Plugin](http://192.168.178.102/index.php/Plugin_Provvigioni_/_Commission#Descrizione_Plugin) [2 Funzionalità supportate](http://192.168.178.102/index.php/Plugin_Provvigioni_/_Commission#Funzionalit.C3.A0_supportate) [3 Installazione Plugin](http://192.168.178.102/index.php/Plugin_Provvigioni_/_Commission#Installazione_Plugin) [4 Parametrizzazione Plugin](http://192.168.178.102/index.php/Plugin_Provvigioni_/_Commission#Parametrizzazione_Plugin) [5 Istruzioni Plugin](http://192.168.178.102/index.php/Plugin_Provvigioni_/_Commission#Istruzioni_Plugin) [6 Documentazione Tecnica Plugin](http://192.168.178.102/index.php/Plugin_Provvigioni_/_Commission#Documentazione_Tecnica_Plugin)  [6.1 Modifiche all'AD](http://192.168.178.102/index.php/Plugin_Provvigioni_/_Commission#Modifiche_all.27AD)  [6.1.1 Tables / Windows esistenti](http://192.168.178.102/index.php/Plugin_Provvigioni_/_Commission#Tables_.2F_Windows_esistenti) [6.1.2 Nuove Tables /Windows](http://192.168.178.102/index.php/Plugin_Provvigioni_/_Commission#Nuove_Tables_.2FWindows)     [7 Funzionalità Future](http://192.168.178.102/index.php/Plugin_Provvigioni_/_Commission#Funzionalit.C3.A0_Future) [8 Errori e bug](http://192.168.178.102/index.php/Plugin_Provvigioni_/_Commission#Errori_e_bug)  

## Descrizione Plugin

---

```
TRADUZIONE 
Commissioni -> Provvigioni  PRO0
Msk Provvigioni :select su BP deve essere solo agenti (rappresentatnti)

Aggiunge 2 processi
CalCommForOrder - it.cnet.idempiere.commissions.process.CommissionCalcForOrder
CalcAllCommissions - it.cnet.idempiere.commissions.process.CalculateAllCommissions

COSA NEGATIVA : deve generare per ogni agente (???) ci vorrebbe un generara tutti gli agenti

FARE REPORT PROVVIGIONI a) revisione report con dettaglio prodotti  B) creare report con riepilogo Documento (no dettaglio prodotti)
```


 Plugin commissioni


 [![Provvigioni.png](http://192.168.178.102/images/a/a3/Provvigioni.png)](http://192.168.178.102/index.php/File:Provvigioni.png)

[![PluginCommisions Videata1.png](http://192.168.178.102/images/thumb/5/5d/PluginCommisions_Videata1.png/600px-PluginCommisions_Videata1.png)](http://192.168.178.102/index.php/File:PluginCommisions_Videata1.png)

## Funzionalità supportate

---

## Installazione Plugin

***

Installare nella console felix il jar reperibile su [idempiere-download](https://bitbucket.org/consulnet/idempiere-download)

## Parametrizzazione Plugin

---

[![PluginCommisions Param.png](http://192.168.178.102/images/thumb/2/29/PluginCommisions_Param.png/600px-PluginCommisions_Param.png)](http://192.168.178.102/index.php/File:PluginCommisions_Param.png)

## Istruzioni Plugin

---

## Documentazione Tecnica Plugin

***

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

## Funzionalità Future

***

commission - aggiungere bottone processo calcolo provv su sales order

## Errori e bug

---

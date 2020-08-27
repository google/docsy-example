---
title: "Plugin Sepa"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 81
pre: "<b>8.1 </b>"
---

## Link esterni

Link wiki idempiere 

[Link/SEPA.xml](http://Link/image/SEPA.xml)








---

## Riferimenti

*link pubblico          : http://wiki.idempiere.org/en/Plugin:_SEPA
*link idempiere italia  : https://bitbucket.org/consulnet/plugin-standard.de.aulersipel.sepapaymentexport
*link jar               : 
*versione idempiere     : idempiere 3.1
*versione zk supportata : 

---

## Descrizione Plugin

```
SEPA Credit Transfer (SCT), evoluzione del servizio di bonifico domestico; 
SEPA Direct Debit (SDD), evoluzione del servizio di addebito diretto domestico RID.
```

3. Codice CUC (Codice Univoco CBI) (stringa 8 caratteri, nullabile): vedi identificativo del creditore 

Per il corretto funzionamento, bisogna avere una banca di default impostata nel Client

[{{< figure src="/image/SEPA_1.png"  width="850"  >}}](/image/SEPA_1.png)


'''Window "Bank>Account":''' in questa tab bisogna dichiarare la classe java per la gestione della creazione del documento SEPA; nel campo'''<pre style="color: green">

```
Payment Export Class
```

</pre>''' dichiarare il nome della classe del plug-in e cioè '''de.aulersipel.util.SEPAPaymentExport_idIta'''. Inoltre bisogna creare un Bank Account Document per farlo eseguire nella maniera corretta il pagamento e generazione del file SEPA; nella creazione impostare il giusto Payment Rule che si vuole applicare ---- Es. "Direct Debit"
<br\>
Prima di avviare l'esportazione del file SEPA, bisogna assicurarsi che il BPartner, a cui fare il pagamento, abbia un bank account impostato. Vedere maschera Business Partner > Bank Account
<br\>

[{{< figure src="/image/SEPA_4.png"  width="850"  >}}](/image/SEPA_4.png)
![image](1200px-SEPA_4.png)<br\>
<br\>

[{{< figure src="/image/SEPA_2.png"  width="850"  >}}](/image/SEPA_2.png)
![image](1200px-SEPA_2.png)<br>
'''Window "Payment Print/Export":''' in questa maschera bisogna dichiarare selezionare il pagamento che si vuole effettuare e la generazione del file SEPA
<br>

[{{< figure src="/image/SEPA_3.png"  width="850"  >}}](/image/SEPA_3.png)
![image](1200px-SEPA_3.png)<br>
'''Window "Payment Selection":''' in questa maschera bisogna si può visualizzare e gestire i pagamenti da effettuare

```
SELECT C_PaySelection.C_PaySelection_ID, 
       NULL,
       NVL(C_PaySelection.Name,'-1'),
       C_PaySelection.IsActive 
FROM C_PaySelection WHERE   
C_PaySelection.C_PaySelection_ID=? AND 
C_PaySelection.AD_Client_ID IN (0,1000008) AND  
(C_PaySelection.C_PaySelection_ID IS NULL OR   C_PaySelection.C_PaySelection_ID )
```



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

Per controllo file xml SEPA, utilizzare il seguente link http://www.cbiservice.com/correttoresepa.php

---

## Modifiche all'AD

### Tables / Windows esistenti

### Nuove Tables /Windows

---

## Funzionalità Future

---

## Errori e bug

---

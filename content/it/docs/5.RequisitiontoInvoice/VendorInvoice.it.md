---
title: "Fattura Fornitore"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 340
pre: "<b></b>"
---

## Fattura di Acquisto [FDA00]
[{{< figure src="/image/FatturaAcquisto0.png"  width="850"  >}}](/image/FatturaAcquisto0.png)
## Info completa fatture di acquisto 
[{{< figure src="/image/FatturaAcquisto0.png"  width="850"  >}}](/image/FatturaAcquisto0.png)
## Info crea fattura acquisto da entrata merci [ICFAE00]
[{{< figure src="/image/FatturaAcquisto0.png"  width="850"  >}}](/image/FatturaAcquisto0.png)
## Fatturazione Batch [FB00]
[{{< figure src="/image/FatturazioneBatch0.png"  width="850"  >}}](/image/FatturazioneBatch0.png)
## Controllo Bolla Fattura [CBF00]
[{{< figure src="/image/FatturazioneBatch0.png"  width="850"  >}}](/image/FatturazioneBatch0.png)
## Fattura Abbinata [FABB00]
[{{< figure src="/image/FatturaAbbinata0.png"  width="850"  >}}](/image/FatturaAbbinata0.png)


## Video - Fattura di Acquisto
### Video - 5. Requisition-to-Invoice - Registration Purchase invoice / Reg. Fattura di Acquisto Servizi [V037]
{{<youtube e2ltX28UWVI>}}

### Video - 5. Requisition-to-Invoice - Invoice (Vendor) / Fattura di Acquisto 22% [V038]
{{<youtube HMTjJbjdwSU>}}

### Video - 5. Requisition-to-Invoice - Invoice Vat Squaring / Fattura con squadratura IVA [V039]
{{<youtube Zc0R3grA_hU>}}

### Video - 5. Requisition-to-Invoice - Invoice (Vendor) / Fattura Acquisto Extra UE [V040]
{{<youtube 6I8s-b7bBxw>}}

### Video - 5 Requisition to Invoice - Invoice Purchase Italy / Fattura Acquisto Italia art 17c 6 [V041]
{{<youtube P6bQRczRT8M>}}

### Video - 5. Requisition-to-Invoice - Invoice (Vendor) / Fattura acquisto iva indetraibile [V042]
{{<youtube ZrisrpXcPzs>}}

### Video - 5 Requisition to Invoice - Credit Note Vendor / Nota Accredito Fornitore [V043]
{{<youtube GRRD9T9uOJc>}}

### Video - 5. Requisition-to-Invoice - Invoice (Customer) / Fattura Vendita Art17c6noIva [V050]
{{<youtube gbc3QngnC4I>}}

### Video - 5. Requisition-to-Invoice - Landed Cost part 2 / Imputazione Costi di Trasporto e Acc [V186]
{{<youtube TC2ppwV_CaA>}}

### Video - 5. Requisition-to-Invoice - Landed Cost  / Imputazione Costi di Trasporto e Accessori  [V185]
{{<youtube 1QoQAHlW-vo>}}

### Video - 5. Accounting - Plot Notice Open / Partite Aperte con Avvisi di Parcella [V145]
{{<youtube 4c5H767L6-k>}}

### Video - 5. Requisition-to-Invoice - Vendor Invoice Vat Error / Fattura Acquisto con errore iva [V151]
{{<youtube BhsXb5d3TeQ>}}


#  Bolletta Doganale  
## Video - Bolletta Doganale  
### Video - 5. Requisition to Invoice - Custom Bill / Bolletta doganale [V035]
{{<youtube DCyHXWdt6CA>}}

### Video - 5. Requisition-to-Invoice - Shipper Invoice / Bolletta Doganale Fattura trasportatore [V036]
{{<youtube 7ziN0JZzhuU>}}

### Video - 5. Requisition-to-Invoice - Payment BIl / Bolletta Pagam Spediz Saldo [V068]
{{<youtube Hcou77p8_l8>}}



## Nota di Accredito Fornitore
##  1. Fase d'import file xml

Nell'importazione su tabella I_Invoice (maschera "Importazione Fattura Fornitore XML"), quando leggo il tag relativo all'aliquota IVA, si cerca d'impostare già da subito il C_Tax_ID presente a sistema.
Qui di seguito il codice di riferimento:

```java
MTax tax = new Query(ctx, MTax.Table_Name, "IsDefault='Y' AND Parent_Tax_ID IS NULL AND SOPOType='B' AND Rate=?", null)
.setClient_ID()
.setOnlyActiveRecords(true)
.setParameters(lineaFattura.getAliquotaIVA())
.first();

if(tax!=null)
	i_invoice.setC_Tax_ID(tax.getC_Tax_ID());
else
i_invoice.setTaxIndicator(lineaFattura.getAliquotaIVA().toString());
```

Il filtro di ricerca si basa su 
*"IsDefault='Y' AND Parent_Tax_ID IS NULL AND SOPOType='B' AND Rate=?"*


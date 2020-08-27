---
title: "Schema Contabile [SC00]"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 30
pre: "<b>8.2 </b>"
---
# Contabilità Conti di Default
## INDICE
### [Schema Contabile - General Ledger](#Schema Contabile - General Ledger)

### [Generale](#Generale)

### [Default Account - Gruppo Business Partner](#Default Account - Gruppo Business Partner)

### [Prodotti](#Prodotti)

### [Warehouse](#Warehouse)

### [Tax Account](#Tax Account)

### [Progetti](#Progetti)

### Schema Contabile - General Ledger

![](/opt/md/images/contidefault1.png)

INTERCOMPANYDUETO_ACCT - DEBITI V/IMPRESE COLLEGATE

PPVOFFSET_ACCT

COMMITMENTOFFSET_ACCT CONTI D'ORDINE

LIT_B_RIBA_GENERIC_ACCT

![](/opt/md/images/contidefault2.png)

SUSPENCEBALANCING_ACCT

CURRENCYBALANCING_ACCT

INTERCOMPANYDUEFROM_ACCT

COMMITMENTOFSALES_ACCT

### Generale

![](/opt/md/images/contidefault3.png)

UNREALIZEDGAIN_ACCT    ????

REALIZEDGAIN_ACCT       5.2.04.01 CONTO UTILI SU CAMBI

### Default Account - Gruppo Business Partner

![](/opt/md/images/contidefault4.png)

![](/opt/md/images/contidefault5.png)

UNREALIZEDLOSS_ACCT     ????

REALIZELOSS_ACCT   5.2.04.02  PERDITE SU CAMBI

![](/opt/md/images/contidefault6.png)

NOTINVOICEDRECEIPTS_ACCT  -  2.3.7.02 DEBITI PER FATTURE DA RIC.

PAYDISCOUNT_EXP_ACCT  -  5.1.01.18 CONTO SCONTO PAGAMENTO ANTIC.

WRITEOFF_ACCT STORNO   ???? ABBUONI SU ACQUISTI

C_RECEIVABLE_ACCT  -  1.6.01.01  CLIENTI C/FATTURE

C_PREPAYMENT_ACCT  -  ANTICIPI DA CLIENTI

(CREARE 3 GRUPPI BP che PUNTI A CREDITI FORNITORI/CLIENTI : ITALIA - CEE - EXTRACEE).

![](/opt/md/images/contidefault7.png)

PAYDISCOUNT_REV_ACCT  -  4.1.05.06 RICAVI SCONTO PAG. ANTICIPATO

V_LIABILITY_ACCT  -  2.3.07.01 FORNITORI C/FATTURE

V_ PREPAYMENT_ACCT  -  1.7.02.09 ANTICIPI A FORNITORI

### Prodotti

### ![](/opt/md/images/contidefault8.png)

P_ASSET_ACCT

P_COSTADJUSTMENT_ACCT

P_COGS_ACCT  -  COSTO DEL VENDUTO

P_PURCHASEPRICEVARIANCE

P_TRADEDISCOUNTREC_ACCT

P_RATEVARIANCE_ACCT

![](/opt/md/images/contidefault9.png)

P_EXPENSE_ACCT  5.1.01.14 MATERIE PRIME PER LA PRODUZIONE

P_INVENTORYCLEARING_ACCT  

P_REVENUE_ACCT    4.1.01.01  RICAVI DELLE VENDITE

P_INVOICEPRICEVARIANCE_ACCT

P_TRADEDISCOUNTGRANT_ACCT

P_AVARAGECOSTVARIANCE_ACCT

### Warehouse

![](/opt/md/images/contidefault10.png)

W_DIFFERENCES_ACCT

![](/opt/md/images/contidefault11.png)

Bank Account

![](/opt/md/images/contidefault12.png)

B_ASSET_ACCT

B_PAYMENTSELECT_ACCT

B_INTERESTEXP_ACCT

LIT_B_RIBA_BANK_ACCT  

![](/opt/md/images/contidefault13.png)

B_INTRANSIT_ACCT

B_UNALLOCATEDCASH_ACCT

B_INTERESTREV_ACCT

### Tax Account

![](/opt/md/images/contidefault14.png)

T_DUE_ACCT  

T_EXPENSE_ACCT

![](/opt/md/images/contidefault.15.png)

T_CREDIT_ACCT

![](/opt/md/images/contidefault.16.png)  

CH_EXPENSE_ACCT

### Progetti

![](/opt/md/images/contidefault17.png)

PJ_ASSET_ACCT  1.2.04.03 PROGETTI

![](/opt/md/images/contidefault18.png)

PJ_WIP_ACCT

![](/opt/md/images/contidefault19.png)

---

Comunity Wiki Page http://wiki.idempiere.org/en/Default_Accounts_Usage
Comunity Wiki Page http://wiki.idempiere.org/en/IDempiere_Accounting

Conti di Default

### **Conti Generali** 

[[File:AccountSchemaGeneral.png]]

 UNREALIZEDGAIN_ACCT
 UNREALIZEDLOSS_ACCT
 REALIZEDGAIN_ACCT
 REALIZEDLOSS_ACCT

### Conti Business Partner 

[{{< figure src="/image/AccountSchemaBP_1.png"  width="850"  >}}](/image/AccountSchemaBP_1.png)


```
NOTINVOICEDRECEIPTS_ACCT
PAYDISCOUNT_EXP_ACCT
WRITEOFF_ACCT
C_RECEIVABLE_ACCT
C_PREPAYMENT_ACCT 
PAYDISCOUNT_REV_ACCT
V_LIABILITY_ACCT
V_PREPAYMENT_ACCT
```

### Conti Prodotto 

[{{< figure src="/image/AccountSchemaProduct_3.png"  width="850"  >}}](/image/AccountSchemaProduct_3.png)



```
P_ASSET_ACCT
P_COSTADJUSTMENT_ACCT
P_COGS_ACCT
P_PURCHASEPRICEVARIANCE_ACCT
P_TRADEDISCOUNTREC_ACCT
P_RATEVARIANCE_ACCT
P_LANDEDCOSTCLEARING_ACCT
P_EXPENSE_ACCT
P_INVENTORYCLEARING_ACCT
P_REVENUE_ACCT
P_INVOICEPRICEVARIANCE_ACCT
P_TRADEDISCOUNTGRANT_ACCT 
P_AVERAGECOSTVARIANCE_ACCT
```

### Conti Magazzino 

[{{< figure src="/image/AccountSchemaWarehouse_4.png"  width="850"  >}}](/image/AccountSchemaWarehouse_4.png)



 W_DIFFERENCES_ACCT

#### Conti Banca

[{{< figure src="/image/AccountSchemaBank_2.png"  width="850"  >}}](/image/AccountSchemaBank_2.png)


 B_ASSET_ACCT
 B_PAYMENT_SELECT_ACCT
 B_INTERESTEXP_ACCT
 LIT_B_RIBABANK_ACCT

 B_INTRANSIT_ACCT
 B_UNALLOCATEDCASH_ACCT
 B_INTERESTREV_ACCT

### Conti Imposte

[{{< figure src="/image/AccountSchemaTax_5.png"  width="850"  >}}](/image/AccountSchemaTax_5.png)



 T_DUE_ACCT
 T_EXPENSE_ACCT
 T_CREDIT_ACCT

### Conti Addebiti

[{{< figure src="/image/AccountSchemaCharge_6.png"  width="850"  >}}](/image/AccountSchemaCharge_6.png)



 CH_EXPENSE_ACCT

### Conti Progetti

[{{< figure src="/image/AccountSchemaProject_7.png"  width="850"  >}}](/image/AccountSchemaProject_7.png)



 PJ_ASSET_ACCT
 PJ_WIP_ACCT





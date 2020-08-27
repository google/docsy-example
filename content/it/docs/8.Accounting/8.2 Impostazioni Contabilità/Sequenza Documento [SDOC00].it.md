---
title: "Sequenza Documento [SDOC00]"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 75
pre: "<b>8.2 </b>"
---

```
http://wiki.idempiere.org/en/NF1.0_Document_Sequence_Improved
```

## Ordine di Acquisto / Purchase Order

### Ordine di Acquisto / Purchase Order

```
Prefix --> @AD_Org_ID<AD_Org.Value>@/@DateAcct<yyyy>@/
Suffix --> /A 
Organization level --> YES
Org Column  --> AD_Org_ID
Starting from --> 1
Restart sequence every Year  --> Yes
Date Column  -->  DateOrdered
```

### Offerta di Vendita / Sales Order

### Offerta Standard / Standard Order

```
Prefix --> @AD_Org_ID<AD_Org.Value>@/@DateAcct<yyyy>@/
Suffix --> /OFF 
Organization level --> YES
Org Column  --> AD_Org_ID
Starting from --> 1
Restart sequence every Year  --> Yes
Date Column  -->  DateOrdered

Esempio CONS/2016/0077/OFF
```

### Offerta vincolante / Binding Offer

```
Prefix --> @AD_Org_ID<AD_Org.Value>@/@DateAcct<yyyy>@/
Suffix --> /OPR 
Organization level --> YES
Org Column  --> AD_Org_ID
Starting from --> 1
Restart sequence every Year  --> Yes
Date Column  -->  DateOrdered
```

### Offerta vincolante / Non Binding Order

```
Prefix --> @AD_Org_ID<AD_Org.Value>@/@DateAcct<yyyy>@/
Suffix --> /OPN
Organization level --> YES
Org Column  --> AD_Org_ID
Starting from --> 1
Restart sequence every Year  --> Yes
Date Column  -->  DateOrdered
```

### Ordine POS/ POS Order

```
Prefix --> @AD_Org_ID<AD_Org.Value>@/@DateAcct<yyyy>@/
Suffix --> /OPOS
Organization level --> YES
Org Column  --> AD_Org_ID
Starting from --> 1
Restart sequence every Year  --> Yes
Date Column  -->  DateOrdered
```

### Prepay Order

```
Prefix --> @AD_Org_ID<AD_Org.Value>@/@DateAcct<yyyy>@/
Suffix --> /OPA
Organization level --> YES
Org Column  --> AD_Org_ID
Starting from --> 1
Restart sequence every Year  --> Yes
Date Column  -->  DateOrdered
```

### Credit Order

```
 Prefix --> @AD_Org_ID<AD_Org.Value>@/@DateAcct<yyyy>@/
 Suffix --> /OFT
 Organization level --> YES
 Org Column  --> AD_Org_ID
 Starting from --> 1
 Restart sequence every Year  --> Yes
 Date Column  -->  DateOrdered
```

### Warehouse Order

```
Prefix --> @AD_Org_ID<AD_Org.Value>@/@DateAcct<yyyy>@/
Suffix --> /OMA
Organization level --> YES
Org Column  --> AD_Org_ID
Starting from --> 1
Restart sequence every Year  --> Yes
Date Column  -->  DateOrdered
```

## Fattura Fornitore / Invoice Vendor

### Fattura Fornitore / AP Invoice

```
Document is number controlled FALSE
```

### Nota di Addebito / AP CreditMemo

```
Document is number controlled FALSE
```

## Fattura Cliente / Invoice Customer

### Fattura Cliente / AR Invoice

```
Prefix --> @AD_Org_ID<AD_Org.Value>@/@DateAcct<yyyy>@/
Suffix --> /FT
Organization level --> YES
Org Column  --> AD_Org_ID
Starting from --> 1
Restart sequence every Year  --> Yes
Date Column  -->  DateInvoiced
```

### Nota di Accredito / AR Credit Memo

```
Prefix --> @AD_Org_ID<AD_Org.Value>@/@DateAcct<yyyy>@/
Suffix --> /NA 
Organization level --> YES
Org Column  --> AD_Org_ID
Starting from --> 1
Restart sequence every Year  --> Yes
Date Column  -->  DateInvoiced
```

## Documento di Trasporto / Shipment (Customer)

### MM Shipment

```
Prefix --> @AD_Org_ID<AD_Org.Value>@/@DateAcct<yyyy>@/
Suffix --> /DDT
Organization level --> YES
Org Column  --> AD_Org_ID
Starting from --> 1
Restart sequence every Year  --> Yes
Date Column  -->  MovementDate

Esempio  CONS/2016/0301/DDT
```

### MM Shipment Indirect

```
Prefix --> @AD_Org_ID<AD_Org.Value>@/@DateAcct<yyyy>@/
Suffix --> /DDTI
Organization level --> YES
Org Column  --> AD_Org_ID
Starting from --> 1
Restart sequence every Year  --> Yes
Date Column  -->  MovementDate
```

## Entrata Merci / Material Receipt

## MM Receipt

```
 Prefix --> @AD_Org_ID<AD_Org.Value>@/@DateAcct<yyyy>@/
 Suffix --> /OMA
 Organization level --> YES
 Org Column  --> AD_Org_ID
 Starting from --> 1
 Restart sequence every Year  --> Yes
 Date Column  -->  DateOrderedDocument is number controlled FALSE
```


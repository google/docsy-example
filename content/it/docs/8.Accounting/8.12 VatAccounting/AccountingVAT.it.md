---
title: "Contabilità Iva"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 20
pre: "<b>8.12 </b>"
---


##  Contabilita' - Gestione IVA 

---

link

```
http://ec.europa.eu/taxation_customs/taxation/vat/topics/invoicing_en.htm 
http://ec.europa.eu/growth/single-market/public-procurement/e-procurement/e-invoicing/index_en.htm
http://eur-lex.europa.eu/legal-content/IT/TXT/HTML/?uri=CELEX:32006L0112&from=EN
IVA Contabilita' http://www.revenue.ie/en/tax/vat/guide/accounting.html
IVA Indeducibile http://www.revenue.ie/en/tax/vat/guide/vat-deductible.html#section11
Tabella IVA CEE
http://ec.europa.eu/taxation_customs/resources/documents/taxation/vat/how_vat_works/rates/vat_rates_en.pdf 
```

Iva Aliquote standar

```
4%
5%
22%
```

 **Esenzione Art 10** 

```
Operazioni esenti [art. 10 decreto IVA]
```

```
Sono le cessioni e prestazioni di servizi che non sono sogette a tributi per scelte politiche: 
```

```
Queste operazioni: 
4. Comportano l'obbligo di fatturarle e registrarle 
5. Consentono la detrazione solo parziale dell'IVA sugli acquisti 
```

```
Esempi :

- Servizi di concessione crediti
- Assunzioni di impegni di pagamento
- Dilazioni di pagamento
- Operazioni di assicurazione
- Operazioni di riscossione tributi
- Esercizio del lotto e di scommesse
```

```
 iDempiere : 
```

###  **VENDITE VERSO UE** 

```
Materiali - Non imponibile art 41
```

```
 Servizi - Non imponibile art 40
```

###  **Triangolazione**  

```
Cessione nei confronti di un operatore ue, ma consegna in stato extra ue
FROM : ITALY (Organization)   TO : UE (SPAGNA)  SHIPTO :EXTRA UE (USA )  (ShipTo)
- caso 1 ) 
se il trasporto o la spedizione dei beni fuori dal territorio della CEE, nonché le operazioni doganali sono a cura del cedente ITALY 
L’operazione costituisce una cessione all’esportazione con emissione di fattura 
«non imponibile IVA ai sensi dell’art. 8, primo comma, lett a D.P.R. 633/72»
NB LETTERA A*caso 2 )  (Caso particolare) se il trasporto o la spedizione dei beni fuori dal territorio della CEE nonché le operazioni doganali sono  a cura del cessionario non  residente (SPAGNA) «non imponibile IVA ai sensi dell’art. 8, primo comma, lett b D.P.R. 633/72» NB LETTERA caso 2 )  
se il trasporto o la spedizione dei beni fuori dal territorio della CEE nonché le operazioni doganali sono  a cura cliente (USA)
Applicazione dell'iva (?)
```

### **VENDITE VERSO EXTRA UE** 

```
Materiali - Non imponibile art 8
```

```
Servizi - Non imponibile art 9
```

```
Triangolazione 
FROM : ITALY TO : EXTRA CEE (norvegia )SHIP TO : CEE (svezia)
```

```
La cessione si concretizza quindi come una operazione interna. Il fornitore italiano
 (IT) deve emettere nei confronti del cliente norvegese (NO) fattura con IVA
```

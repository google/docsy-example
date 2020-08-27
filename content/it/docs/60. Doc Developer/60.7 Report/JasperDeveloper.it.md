---
title: "Jasper Report How To"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 500
pre: "<b> </b>"
---

Jasper How To Bible

WHEN EXPRESSION

$F{lit_servicecard_contract_isopen}.equals("Y")

new Boolean($F{c_invoice_withholdingamt}.doubleValue() > 0)



Amount textfield pattern "+new java.text.DecimalFormat("¤ #,##0.00").format($F{amount})

"nr" + " " + $F{t_invoice_documentno} + " " + "del" + " " + (new  SimpleDateFormat("dd/MM/yyyy").format($F{t_invoice_dateinvoiced})) + " "  + "per l'importo di" + " " + new java.text.DecimalFormat("¤  #,##0.00").format($F{t_invoice_linenetamt})

Date Format pattern new SimpleDateFormat("dd/MM/yyyy").format($F{yourdatefield})

# How to Jasper Reports

---

```
http://wiki.idempiere.org/en/Report_View
```

---

## link doc

```
https://www.tutorialspoint.com/jasper_reports/jasper_creating_charts.htm

http://www.adempiere.com/Using_Jasper_Report_Form_in_place_of_Standard_Forms

http://wiki.idempiere.org/en/Making_fonts_available_to_your_JasperReports
link utility convert pdf to jpg http://pdf2jpg.net/convert.php#.VoQO3LyChQo

http://wiki.idempiere.org/en/Category:JasperReports

http://wiki.idempiere.org/en/Multi-Lingual_Jasper

http://www.adempiere.com/JasperReports_with_Window_Sql-Clauses

http://wiki.idempiere.org/en/JasperReports_redesign

http://wiki.idempiere.org/en/JasperReportsFreiBier

http://wiki.idempiere.org/en/Creating_reports_using_JasperReports

http://wiki.idempiere.org/en/Finding_resources_in_JasperReports

http://www.adempiere.com/Using_Jasper_Report_Form_in_place_of_Standard_Forms 

http://www.adempiere.com/HOWTO_Use_Jasper_On_Financial_Reports

http://www.adempiere.com/Talk:ADempiere/Compiere_JasperReports_Integration_HowTo 
fonts available http://wiki.idempiere.org/en/Making_fonts_available_to_your_JasperReports

http://www.adempiere.com/JasperReports_Tips_und_Tricks#Parameter_in_Reporten

http://www.oodlestechnologies.com/blogs/Using-Jasper-Reports-Part-5--(Adding--dynamic-path-to-images-in-jasper)
```

### Adding Fonts

```
http://wiki.idempiere.org/en/Making_fonts_available_to_your_JasperReports

http://qualogy.sr/adding-fonts-to-jasper-reports-integration/

http://stackoverflow.com/questions/8985497/use-custom-fonts-when-creating-pdf-using-ireport

https://community.jaspersoft.com/wiki/ireport-fonts
```

### Run Store Procedure

```
http://brianburridge.com/2006/06/04/how-to-call-stored-procedures-from-jasper-reports/
```

---

## Where Expression

```
BigDecimal 
$F{c_orderline_qtyentered}.doubleValue() == 99
```

 $F{MYDECIMAL1}.doubleValue() + $F{MYDECIMAL2}.doubleValue()</td></tr></tbody></table>

```
new Boolean($P!(var_name).toString.equals("5")) 
```

```
$F{status_Current}.StringValue() ='Canceled'? Boolean.TRUE : Boolean.FALSE
```

```
new Boolean($F{myField} != null)
```

```
!$F{Myfield}.isEmpty()
```

```
http://stackoverflow.com/questions/5178006/print-when-expression-ireport-more-than-one-condition

(($F{ca} > 8) && ($F{ca} < 12) ? "near 10" : (($F{name}.charAt(0) == 'A') ? "A": "Not A" 
```

Testati ambiente idempiere

```
$F{c_order_isdropship}.equals("Y")
($F{c_invoice_docstatus}.equals("CO")?" "+$F{c_doctype_trl_printname}:$F{c_doctype_trl_name})
```

## Altri esempi

{DATECREATED} >= {DATESTART} and {DATECREATED} < DATEADD("d", 1, {DATEEND})

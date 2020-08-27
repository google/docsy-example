---
title: "Plugin Ritenute"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 83
pre: "<b>8.1.3 </b>"
---


```
http://www.wizardsrl.it/images/stories/Documenti/AdHocRevolution/Moduli/Ritenute.pdf
http://wiki.idempiere.org/es/LCO_Instrucciones_Instalacion#Correr_cuatro_procesos_finales
```

---

## Descrizione Plugin

Il plugin deve fare la somma delle righe di fattura con i codici prodotto che siano GS4$ 
(Che la Regola della categoria di ritenutea abbia il campo TAXPAYERTYPEN NOT NULL ) 

DOVE SI APPLICA IL PROCESSO 

In Fattura   (su calcolo ritenuta di acconto  ) 
Processo di Creazione Fattura 
Aggiornamento: il processo si applica nel momento della creazione e preparazione/completamento di un ordine

---

## Funzionalità supportate 

---

## Installazione Plugin 

Installare nella console di felix i jar reperibili da [https://bitbucket.org/consulnet/idempiere-download idempiere-download]

---

##  Parametrizzazione Plugin 

---


## Istruzioni Plugin 

Creazione come nuovo prodotto della Gestione separata del 4%, senza prezzo

[{{< figure src="/image/PluginWitholding_1.png"  width="850"  >}}](/image/PluginWitholding_1.png)


Poi, impostare una nuova categoria di ritenuta

[{{< figure src="/image/PluginWitholding_2.png"  width="850"  >}}](/image/PluginWitholding_2.png)


Creare un nuovo tipo di ritenuta

[{{< figure src="/image/PluginWitholding_3.png"  width="850"  >}}](/image/PluginWitholding_3.png)


Nella sotto-tab della configurazione delle regole di ritenuta, impostare i flag attivi “Is Use Withholding Category” e “ Is Use Org Tax Payer Type ”


[{{< figure src="/image/PluginWitholding_4.png"  width="850"  >}}](/image/PluginWitholding_4.png)

Alla sotto-tab successiva, nelle regole della ritenuta bisogna impostare la nuova categoria di ritenuta creata, il tipo contribuente (Tax Payer Type Organization) e il calcolo della ritenuta

[{{< figure src="/image/PluginWitholding_5.png"  width="850"  >}}](/image/PluginWitholding_5.png)


N.B. : il processo non prenderà in considerazione la gestione del 4% se il campo tipo contribuente (Tax Payer Type Organization) non è valorizzato...

Punto 1: per impostare il tipo contribuente (Tax Payer Type Organization), bisogna crearlo nella sua apposita maschera “Tax Payer Type” e impostarlo nelle info dell’Organizzazione, machera “Organization > Organization Info”

[{{< figure src="/image/PluginWitholding_6.png"  width="850"  >}}](/image/PluginWitholding_6.png)


[{{< figure src="/image/PluginWitholding_7.png"  width="850"  >}}](/image/PluginWitholding_7.png)


Punto 2: per il calcolo della ritenuta, bisogna impostare 

- il tipo base calcolo (Base Type) a livello di linea di fattura, 

- la tassa di ritenuta: bisogna creare una categoria di tassa (Tax Category) che sia di ritenuta 

[{{< figure src="/image/PluginWitholding_8.png"  width="850"  >}}](/image/PluginWitholding_8.png)


e poi la vera e propria tassa (Tax Rate), con il riferimento al categoria di tassa tipo ritenuta

[{{< figure src="/image/PluginWitholding_9.png"  width="850"  >}}](/image/PluginWitholding_9.png)

```
- selezionare il prodotto della gestione separata (Product GS1), quello creato apposta per gestione 
   separata del 4%, e infine impostare il tasso di riferimento (Rate Product_GS1) al 4%
```

[{{< figure src="/image/PluginWitholding_10.png"  width="850"  >}}](/image/PluginWitholding_10.png)



Una volta fatta questa gestione, creare un ordine e nelle linee d’ordine inserire i prodotti che abbiano la categoria di ritenuta impostata x la gestione separata del 4%, come ad’esempio la consulenza


[{{< figure src="/image/PluginWitholding_11.png"  width="850"  >}}](/image/PluginWitholding_11.png)

[{{< figure src="/image/PluginWitholding_12.png"  width="850"  >}}](/image/PluginWitholding_12.png)


'''ATTENZIONE!!!''' Perchè il plugin possa funzionare dobbiamo andare nel '''"Tipo Documento"''' (Ad esempio AR Invoice, ecc...) dell nostro Ordine ed impostare il flag "Generate Withholding" --> Auto 

Alla fine della compilazione dell’ordine, azionare sul bottone “Azione Documento” (Document Action) e scegliere ‘Prepara’ / ‘Completa’ per far apparire la riga con il calcolo della gestione separata del 4%

## Documentazione Tecnica Plugin 

CLASSI JAVA DI RIFERIMENTO

it.cnet.idempiere.separateAccount.model.EventHandler_cnet
it.cnet.idempiere.separateAccount.CalcSeparateAccount

###  Modifiche all'AD 

#### Tables / Windows esistenti

-----------------------
```
| LCO_WithholdingCalc 					|

| nome column        					|

| Product_GS1_ID      					|

| Product_GS2_ID      					|

| Rate_GS1            					|

| Rate_GS2           		  		  	|

| Withholding Type > Withholding Calc 	|

| nome field                  			|

| Product_GS1_ID              			|

| Product_GS2_ID              			|

| Rate Product_GS1            			|

| Rate Product_GS2            			|
```

#### Nuove Tables /Windows

---

## Funzionalità Future

---

## Errori e bug

http://wiki.idempiere.org/es/LCO_Instrucciones_Instalacion#Correr_cuatro_procesos_finales

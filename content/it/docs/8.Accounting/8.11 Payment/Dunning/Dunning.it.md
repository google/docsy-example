 ---
title: "Sollecito Cliente"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 811
pre: "<b>8.11 </b>"
---

8 Accounting PagamentoSetup sollecito https://youtu.be/yXocTEwFRQU

8.Accounting-Pagamento-SollecitoCliente 1   https://youtu.be/wAenMynsbSo

8.Accounting-Pagamento-SollecitoCliente 1   https://youtu.be/x62kjFm-7pw

8 Accounting Pagamento SollecitoCliente    AB   https://youtu.be/1Cwv2Guwfmk

```
riferimento http://www.adempiere.com/Dunning_Setup
```

# Gestione Solleciti

Indice

## [Processo gestione sollecito](#Processo gestione sollecito)

## [Gestione in Idempiere e parametrizzazione](#Gestione in Idempiere e parametrizzazione)

## [Procedura] (#Procedura)



## Processo gestione sollecito

A livello amministrativo è molto importante che si segua una procedura costante ed univoca nella gestione dei crediti non incassati entro le scadenze comunicate. Questo perchè in sede di bilancio si effettueranno delle analisi sui crediti in essere alla data di chiusura del bilancio stesso che dovranno essere compatibili:

a) con la legislazione civile e fiscale per la determinazione di utile ed imposte e tasse,

b) non meno importante e precedente al primo punto la riscossione dei propri crediti.



## Gestione in Idempiere e parametrizzazione

Al fine di eseguire la procedura per l'emissione dei solleciti la prima cosa da farsi è il corretto inserimento dei dati nel Business Partner e nello specifico la compilazione dei campi relativi al tipo di sollecito e del contatto per l'invio del sollecito stesso come da Screnshoot seguente:



![](/home/idempiere/md/Documentazione iDempiere Utente/Manuale iDempiere/11.Contabilità e Controllo di Gestione/Gestione Sollecito 0003.png)

Chiaramente sarà necessario optare per una tipologia di sollecito precedentemente inserita in base a quanto desiderato, generalmente per rendere automatica e più veloce la preocedura per elaborare detti si può ad es. generare due/tre livelli di richieste regolarizzazione crediti scaduti ai BP che hanno partite aperte in essere. Ad esempio si può inserire come da videata seguente un "sollecito" generico che preveda tre livelli con tre stadi con relativi documenti e testi da inviare di diversa entità qualora non venga nel frattempo chiuso il debito da parte del fornitore stesso. 

![ ](/image/Dunning-0002.png)

ovviamente si potrà inserire altre tipologie di richesta crediti qualora ad. esempio si proceda a stadi di richiesta crediti più drastici ad es. tramite legali. Ad ogni modo si potranno inserire (come anche per qualsiasi tipo di sollecito dei testi ripetitivi e anche allegare eventualmente estratto conto con le partite aperte del singolo cliente).

![](/home/idempiere/md/Documentazione iDempiere Utente/Manuale iDempiere/06.Contabilità /Solleciti/Gestione Solleciti 0003.png)

## Procedura

Una volta proceduto a configurare correttamente i vari BP si procede ad estrarre i dati che interessano andando a lanciare il processo Elaborazione sollecito ELS00.

![](/home/idempiere/md/Documentazione iDempiere Utente/Manuale iDempiere/06.Contabilità /Solleciti/Gestione Solleciti 0004.png)



Dunning is the process of collecting money from customers.  As a process, it generally starts with polite requests, perhaps verbally, followed by e-mails and letters that might escalate to legal threats before the account is written off and passed to a collections agent.

An example of a company policy on Dunning might be as follows:

1. For invoices over their due date by less than 15 days, a polite phone call to inquire and request payment.

2. For returned checks - enter a negative payment.  Find the original payment and reset the payment allocation. Allocate/cancel the original payment and the returned check.  This will leave the invoice unpaid.  Call the customer and politely request payment.

3. For invoices over 30 days, a letter requesting immediate payment.

4. For invoices over 60 days, a letter threatening that the amounts will be passed to a collections agent.

5. For invoices over 90 days, write off the amount owing and pass the invoice to the collections agent.  This is a manual process.

ADempiere offers some features for dunning. You can define multiple dunning types each with several levels which are linked to business partners or business partner groups. A dunning run collects the due unpaid invoices that should be dunned and the 'print dunning letters' process prints all dunning letters of a dunning run.  The instructions below set up dunning with two levels.

---

## Setup

* Login as client admin.
* Go to Partner Relations -> Business Partner Rules -> Dunning.
* Create a new entry (Default Dunning) and check at least the 'Default' checkbox.
  ![image](/image/Dunning.png)
* Create a new dunning level (First Reminder). Make sure to select a 'Dunning Print Format and be careful with the 'Days between dunning' field at your first dunning level:

If you uncheck the 'Show all due' and 'Show not due' flags and set the 'Days between dunning' greater then '0' the system will never generate dunning letters because the method DunningRunCreate.addInvoices() performs this check where DaysAfterLast will allways be '0' for not yet dunned invoices:

if (DaysBetweenDunning != 0 && DaysAfterLast < DaysBetweenDunning && !m_level.isShowAllDue () && !m_level.isShowNotDue ()) 
continue;

![image](/image/Dunninglevel_01.png)
* Create a second dunning level (Second Reminder).

![image](/image//Dunninglevel_02.png)

## Set the dunning type for your business partners

* Go to Partner Relations -> Business Partner Rules -> Business Partner.
* Select a customer.
* Open the 'Customer' tabulator and select the new created dunning type from the 'Dunning' drop down.
  To set the default dunning type for all customers for the first client <nowiki>(AD_Client_ID=1000000)</nowiki> you can run this sql statement:

 UPDATE C_BPartner SET C_Dunning_ID=
 (SELECT MAX(C_Dunning_ID) FROM C_Dunning WHERE IsDefault='Y' AND AD_Client_ID=1000000)
  WHERE IsCustomer='Y' AND AD_Client_ID=1000000;

---

## Create the dunning runs

* Go to Open Items -> Dunning Run and create a new entry for each of your dunning levels (First Reminder and Second Reminder).
  ![image](/image/Dunningrun_01.png)
* Select the dunning run entry for the first dunning level, enter a dunning date and push the 'Create dunning run' button. 
* Press the 'OK' button, this will create the dunning entries and lines.
![image](/image/Dunningrun_02.png)

![image](/image/Dunningrun_03.png)

![image](/image/Dunningprint.png)
* Zoom to a dunned invoice. You will notice that the collection status is set to 'Dunning' and the dunning level is set to 'First Reminder'.
* Before we can proceed with the dunning run for the second dunning level (Second Reminder) we first have to print the dunning letters of the first dunning run. We have to do this because the dunning print process sets the 'processed' flag for the printed dunning lines and that is the only indicator for the system that a certain invoice already has been dunned. 
  It is not possible to reuse dunning runs (e.g. every week) because the information about the dunning status of an invoice is taken from the existing dunning runs. If you delete the entries of a dunning run the system doesn't know anymore that the invoice has been dunned!

---

## Print the dunning letters

* Go to Open Items -> Print Dunning Letters.
* Select a dunning run from the dropdown list.
* Press the 'Start' button. The dunning letters are printed and the 'processed' flag is set for the dunning run and it's entries. You now can proceed with the second dunning level.

 

# Libero Manufacturing

---

## Link Esterni

---

### Non idempiere

```
https://frepple.com/
https://docs.oracle.com/cd/A60725_05/html/comnls/us/po/poov01.htm
MAster Scheduling  https://www.slideshare.net/mehrdad66/master-scheduling-10132757
Purchase Order Type https://docs.oracle.com/cd/A60725_05/html/comnls/us/po/poov01.htm
https://www.youtube.com/watch?v=geDTPFB2JEQ
https://www.youtube.com/watch?v=pr7wj7LqPFA
https://www.lokad.com/it/calcolare-le-scorte-di-sicurezza-con-la-previsione-vendite
http://www.infologis.biz/wp-content/uploads/2009/12/Sistemi-MRP.pdf
https://operations101.files.wordpress.com/2009/02/08_mps_mrp.pdf
http://exceltemplates.net/inventory/mrp-template/
http://www.dia.uniroma3.it/~pacciare/CORSI/MSP/MRP.pdf
https://www.youtube.com/watch?v=-94BQLmaSqY
Open Sales Order http://www.erpgreat.com/sap-sd/explain-the-meaning-of-an-open-sales-order.htm
https://www.youtube.com/watch?v=Mpt_2VInnig&feature=share&list=PLHbAOqfgE-VC9EE4xj5uevz9WR7OuB6_k
http://www.inventorysolutions.org/def_mps.htm https://docs.oracle.com/cd/E26228_01/doc.93/e21775/ch_ov_prod_cost_mfg_acc.htm#WEAMA111
http://www.accountingformanagement.org/weighted-average-costing-method-of-inventory-valuation/
http://www.sap123.com/a/41/
http://www.webandmacros.net/mrp-example.htm
http://production-scheduling.com/material-planning-tool-10-minutes/
https://www.me.utexas.edu/~jensen/ORMM/omie/computation/unit/mrp_add/mrp_formulas.html
https://www.gardainformatica.it/blog/consulenza/pianificazione-produzione-frepple-integrazione-gestionale
http://www.chuckboecking.com/introduction-adempiere-idempiere-manufacturing/
```

<http://accountingexplained.com/financial/inventories/avco-method>

### iDempiere

```
http://wiki.adempiere.net/Libero_Manual
http://wiki.adempiere.net/images/b/b4/UserManualPartC-en.pdf
http://www.adempiere.com/Ecosoft/Customization_for_Bicycle_Manufacturer_Case_Study
http://www.adempiere.com/Libero
http://wiki.adempiere.net/Libero_FAQs
http://www.adempiere.com/Libero_Manufacturing_Official_Extension#Activity_Control
http://www.adempiere.com/Sponsored_Development:_Libero_Project_Management
http://www.adempiere.com/Sponsored_Development:_Libero_Distribution_Resource_Planning
http://www.chuckboecking.com/introduction-adempiere-idempiere-manufacturing/
http://www.chuckboecking.com/make-order-demonstration-adempiere-open-source-erp/
http://www.chuckboecking.com/light-manufacturing-demonstration-using-adempiere-idempiere/
http://wiki.adempiere.net/A_Step_by_Step_Guide_to_Libero_Manufacturing
http://wiki.adempiere.net/Sponsored_Development:_Libero_Distribution_Resource_Planning
```

<http://wiki.adempiere.net/Sponsored_Development:_Libero_Manufacturing_Work_Shop>

```
https://drive.google.com/open?id=0B3alx2W3koD6Z0tUMGM1TWVuaXc
https://drive.google.com/open?id=0B3alx2W3koD6VS0xMDhfY0NMQWM
https://drive.google.com/file/d/0B3alx2W3koD6akktX2NESnRNUm8/view?usp=sharing
Mrp https://drive.google.com/file/d/0B3alx2W3koD6aWNsWGdET1VINVU/view?usp=sharing
Mrp Excel https://drive.google.com/file/d/0B3alx2W3koD6UG9fY0gwZnIzVXM/view?usp=sharing
Mrp https://drive.google.com/file/d/0B3alx2W3koD6YTk4T0Z1Mkcxelk/view?usp=sharing
```

<http://my.liuc.it/MatSup/2007/F78651/MRP.pdf>

---

## Dati ambiente sviluppo/test/demo

```
Application 172.16.30.1:8087
Dati test
Prodotto AAAFertilizer#50
  Bag50        qty 1,0
  Fertilizer   qty 50
NB : isPurchased ( or Manufactured) 
? Come gestiosco "both"
```

---

## Test ambiente locale Eclipse

```
Application: localhost:8080
Dati test: prodotto (BOM) --> Name: Lawn Fertilizer
           Settaggio su maschera 'Bill of Materials Formula' (Table: PP_Product_BOM) --> record Name: Lawn Fertilizer
                                                                                                prodotto: Lawn Fertilizer
```

Per far in modo che il Sales Order si completi, bisogna impostare sul prodotto BOM della maschera '**Bill of Materials Formula'** il 'BOM Type' a Make-To-Order

---

## Errori :

- Processo : Create Doc Type to Manufacturing (1 time)

```
 Let create the document type to manufacturing
This process only need run one time by client
** Failed to create new process instance for org.eevolution.process.CreateDocType
```

---

## MODIFICHE PLUGIN LIBERO MANUFACTURING

1) Nella Window Product la Distinta deve essere validata (Verified  deve essere flaggato). Questo purtroppo funziona solo se imposto la Bill  of Materials Standar e non quella del plugin di Libero.

2) Zoom che non indirizzano nella winow giusta. Ad esempio Window "Product Planning Data" --> Tab "Data Planning",

```
 - il campo Resource deve indirizzare nella maschera "Manufacruring Resource" e non Resource
 - il campo Workflow deve indirizzare nella maschera "Manufacruring Workflows" e non Workflow
```

3) devo saltare tra "Manufacruring Workflows" e window Workflow.  Alcuni campi della Manufacruring Workflows aprono la window Workflow,  questo non va bene perchè se ad esempio devo inserire il campo NextNode  (presente nella testata della Manufacturing Workflows) non posso farlo.  MI lascia farlo solamente se mi trovo nela window "Workflow"


 4) Window Manufacturing Resource --> i campi "DailyCapacity" e  "PercentUtilization" sono invisibili. Impostarli visibili: UPDATE  AD_Field SET IsDisplayed='Y' WHERE AD_Tab_ID IN(53287, 53302)


 5)Recuperare SpecialForm:

```
- BOM & Formula Info
- Manufacturing Workflow Editor
- Planned Order Approval
- Generate Movement Manual
- Material Receipt Distribution Order
```

6) Errore nel processo:

```
- Multi Level BOM & Formula Detail
```

---

## Creazione SALES ORDER (Primi Passi)

Vediamo come creare l'ordine di una semplice Distinta Base.  ATTENZIONE!! è fondamentale seguire determinati passi altrimenti al  completamento dell'ordine potrebbe scatenarsi un errore di questo  genere: Grand Total...SaveError

Supponiamo di avere una Distinta Base di questo genere:

[![DistintaBase.png](http://192.168.178.102/images/thumb/f/ff/DistintaBase.png/600px-DistintaBase.png)](http://192.168.178.102/index.php/File:DistintaBase.png)

## Window PRODUCT

Creiamo i nostri prodotti:

```
- Bicicletta   (flag Bill of Material)
- Sella
- Manubrio
- Ruote
- Telaio       (flag Bill of Material)
- Tubi
- Giunti
```

[![LiberoMan.png](http://192.168.178.102/images/thumb/2/21/LiberoMan.png/1075px-LiberoMan.png)](http://192.168.178.102/index.php/File:LiberoMan.png)

IMPORTANTE: In questo caso la Bicicletta è un prodotto finito, una  distina costituita da più oggetti e quindi il campo "Purchased" dovrebbe  essere impostato a Purchased='N' proprio perchè non è stato acquistato  da un fornitore (lo abbiamo costruito noi). Avrò acquistato le materie  prime per generare la bicicletta, ovvero Giunti, Ruote, Sella, Manubrio,  ecc... (queste ovviamente dovreanno avere il campo Purchased='Y' con la  relativa sottoTab Purchasing)

---

## Window BILL of MATERIAL & FORMULA

Inseriamo le componenti delle nostre Distinte "Bicicletta" e "Telaio"  (maschera Bill of Material & Formula). I seguenti campi funzionano  in questo modo:

"BOM Type":

```
Current Active --> al completamento del Sales Order NON viene generato il Manufacturing Order (vedi MRP Info - compare solamente il Sales Order)
Make-To-Order --> al completamento del Sales Order viene generato anche il Manufacturing Order (vedi MRP Info - compare il Sales Order Complete e il Manufacturing Order in stato Draft)
Make-To-Kit --> al completamento del Sales Order viene generato anche il Manufacturing Order (vedi MRP Info - compare il Sales Order Complete e il Manufacturing Order in stato Draft)
```

"BOM Use":

```
Manufacturing
```

Vediamo l'impostazione delle distinta Bicicletta (dato che faremo l'ordine di questo Prodotto)

[![LiberoManufacturing.png](http://192.168.178.102/images/thumb/6/61/LiberoManufacturing.png/1200px-LiberoManufacturing.png)](http://192.168.178.102/index.php/File:LiberoManufacturing.png)

**ATTENZIONE**: Dobbiamo Validare le due Distinte (Bicicletta e  Telaio) nella window Product altrimenti l'ordine non funzionerà.  Purtroppo la validazione fa riferimento alla maschera "Bill of Material"  presente di default (non quella del plugin Libero Manufactoring).  Quindi come fare? O facciamo un Update sul campo "Verified" oppure  crieamo delle Bill of Material nella maschera di default (anche a caso)  per poi validare con il pulsante "Verify BOM Structure"

---

## Window SALES ORDER

Impostiamo il nostro Ordine di Vendita. Inseriamo nella Linea dell'Ordine il nostro prodotto con distinta "BICICLETTA"

[![LiberoManufacturing2.png](http://192.168.178.102/images/thumb/d/db/LiberoManufacturing2.png/1200px-LiberoManufacturing2.png)](http://192.168.178.102/index.php/File:LiberoManufacturing2.png)

ATTENZIONE!! Se COMPLETIAMO il documento si scatenerà l'errore di  "Grand Total...SaveError". Questo perchè non abbiamo finito, dobbiamo:

```
- andare nel processo "Create Product Planning" e creare i nostri Data Planning
- andare nella window "Product Planning Data" ed impostare il Data Planning per il nostro prodotto ordinato "BICICLETTA" (impostare Organization=org uguale all'ordine di Vendita, vedi immagine sopra)
- andare nella window "Manufacturing Resource" ed impostare il tipo di risorsa  (impostare Organization=org uguale all'ordine di Vendita, vedi immagine sopra)
- andare nella window "Manufacturing Workflows"
```

---

## Window PRODUCT PLANNING DATA

Oltre ai dati caricati nella window del Prodotto, in cui sono  definite le caratteristiche di ciascun prodotto, nella finestra di  pianificazione del prodotto (PRODUCT PLANNING DATA ) vengono immesse le  informazioni sul prodotto che serviranno di base per eseguire gli  algoritmi della pianificazione dei requisiti di materiale, insieme a  PMP, gli ordini aperti E inventari.

Andiamo nella window "Product Planning Data" e selezioniamo il nostro  prodotto Bicicletta. Nella Tab "Data Planning" è IMPORTANTE inserire  (obbligatorio):

```
 Organization:  uguale a quella della Sales Order precedentemente descritta
 Resource: creare una Resource che abbia la Warehouse come l'organization precedente (andare nella window Manufacturing Resource e creare un Manufactoring Resource Type:Plant)
 BOM Formula: se stessa
 Workflow: importantissimo e fondamentale creare un workflow che abbia dei campi specifici (in modo che il nostro ordine non generi un errore)
```

Vediamo un'esempio del nostro Data Planning completo nell'immagine seguente:

[![LiberoManufacturing6.png](http://192.168.178.102/images/d/d3/LiberoManufacturing6.png)](http://192.168.178.102/index.php/File:LiberoManufacturing6.png)

Nel campo "Promised Delivery Time" è necessario immettere il numero  medio di giorni per ricevere il prodotto nel magazzino dal momento che  approvi la richiesta (Requisition) o l'ordine di Produzione fino a  quando non ricevi il materiale nel magazzino. Se il prodotto viene  acquistato, è necessario registrare i giorni calendari necessari poiché  si effettua il PO fino a quando non si riceve il materiale nel  magazzino. Se il prodotto è manufactured nel tuo stabilimento, devi  registrare il numero di giorni lavorativi da quando rilasciate la MO  fino a quando non ricevi il materiale nel magazzino.

Come possiamo vedere dall'immagine sopra, fondamentale è creare:

```
1) Resource (window Manufactoring Resource)
2) Workflow (window Manufacruting Workflows)
```

Vediamo come:

### 1) Window Manufacturing Resource

Creiamo una Resource. FONDAMENTALE impostare il seguente campo:

```
Manufacturing Resource Type=Plant (significa Stabilimento,capannone)
```

[![LiberoManufacturing3.png](http://192.168.178.102/images/thumb/1/1e/LiberoManufacturing3.png/1200px-LiberoManufacturing3.png)](http://192.168.178.102/index.php/File:LiberoManufacturing3.png)

Crea un Resource Type con unità di misura tipo EACH

**ATTENZIONE!!** Nel caso avessimo un Manufacturing Resource Type =  WorkCenter dobbiamo avere un Resource Type con unità di misura che NON  sia EACH

### 2) Window Manufacturing Workflows

Il flusso di lavoro di produzione è uno strumento che consente di  definire le attività necessarie per la fabbricazione di un prodotto  tenendo conto della sequenza del processo, del tempo necessario per il  nodo (operazione) e del punto in cui dovrebbe essere eseguito.

(ATTENZIONE, la window "Manufacturing Workflow" e la window  "Workflow" sono pressochè identiche, alcuni setaggi vanno impostati su  una, altri sull'altra).

Nella la window "Manufacturing Workflow" importantissimo settare il campo:

```
Workflow Type:Manufacturing
Start Node:....... (Attenzione, questo campo fa riferimento alla window Workflow, quindi inserirlo da quella window)
```

Vediamo l'immagine seguente:

[![LiberoManufacturing5.png](http://192.168.178.102/images/thumb/e/e4/LiberoManufacturing5.png/1200px-LiberoManufacturing5.png)](http://192.168.178.102/index.php/File:LiberoManufacturing5.png)

*(Ho fatto un test inserendo un Resource nella Testata e l'ordine non andava)*


 Nella Tab "Activity" della window "Manufacturing Workflow" importantissimo settare il campo:

```
Resource:NomeResource
```

Vediamo l'immagine seguente

[![LiberoManufacturing4.png](http://192.168.178.102/images/thumb/a/a4/LiberoManufacturing4.png/1200px-LiberoManufacturing4.png)](http://192.168.178.102/index.php/File:LiberoManufacturing4.png)

VALIDARE IL WORKFLOW

BENE ADESSO IL NOSTRO ORDINE POTRA' ESSERE COMPLETATO CORRETTAMENTE

---

## CALCULATE MATERIAL PLAN (solo se BOM Type=Current Active)

Viene visualizzato un modulo che chiede di accedere  all'Organizzazione per la quale si vuole fare un piano materiale e la  versione di questo piano. Si possono avere diverse versioni in modo da  poter decidere la versione più conveniente che si desidera utilizzare.

[![CMP.png](http://192.168.178.102/images/thumb/b/b3/CMP.png/800px-CMP.png)](http://192.168.178.102/index.php/File:CMP.png)

---

## Create Record MRP

Questo processo ricrea le richieste, gli ordini approvati e aperti  per un prodotto. Generalmente, questo processo viene eseguito solo  durante l'implementazione del MRP (esempio,: lanciando questo processo  mi vengono eliminate tutte le Requisition. Riutilizzo il processo:  "Calculate Material Plan" per rigenerare le richieste)

[![MRPCreate.png](http://192.168.178.102/images/thumb/0/0a/MRPCreate.png/1000px-MRPCreate.png)](http://192.168.178.102/index.php/File:MRPCreate.png)

## MRP Info

[![MRP Info.png](http://192.168.178.102/images/thumb/e/ee/MRP_Info.png/1000px-MRP_Info.png)](http://192.168.178.102/index.php/File:MRP_Info.png)

[![MRP Info1.png](http://192.168.178.102/images/thumb/d/d6/MRP_Info1.png/1000px-MRP_Info1.png)](http://192.168.178.102/index.php/File:MRP_Info1.png)

Come possiamo vedere dalle immagini, ho fatto l'ordine di una  Bicicletta. LA Bicicletta ha una componente di 3 Tubi (valore impostato  nella Componente della Bill of Material della Bici). La mia giacenza a  magazzino del tubo è di 0 quindi dovrò acquistare 3 tubi per poter  quindi creare la mia bicicletta (On Han Qty = -3). Devo fare quindi una  Richiesta di almeno 3 Tubi (Requisition)

---

## Requisition (Complete Document)

---

## Create PO From Requisition (and Complete PO)

---

## Material Recipt

---

## Complete Manufacturing Order

---

## Order Receipt Issue

L'ultimo passo nel processo di fabbricazione con un Ordine di  Produzione è di ricevere il prodotto finito nel magazzino. La finestra  mostra, nella parte superiore, informazioni statiche attorno al prodotto  e alla risorsa produttiva in cui deve essere fatta, anche una sintesi  delle quantità da controllare nel MO come le quantità originali e  consegnate e la quantità da consegnare per il MO. Se il processo di  produzione richiede la produzione in batch, i Qty Batches mostrano il  numero di batch che il piano di negozio deve fare e la Qty Batch Size  contiene le dimensioni di ogni lotto da produrre. Se si desidera  rilasciare i componenti MO prima di ricevere il prodotto finito è  necessario selezionare la casella di controllo Is Delivery, questo caso è  consigliato quando si ha un tempo di consegna medio-lungo e si desidera  avere le quantità di inventario il più esatta possibile in ogni momento  . Se si dispone di un breve tempo di consegna e si desidera salvare il  tempo impiegato, è necessario selezionare la casella di controllo Is  Backflush e riceverai il prodotto finito contemporaneamente  all'emissione automatica delle componenti

[![Issue.png](http://192.168.178.102/images/thumb/3/3c/Issue.png/1000px-Issue.png)](http://192.168.178.102/index.php/File:Issue.png)

Se tutto procede a Buon fine il nostro Manufacturing Order viene  impostato da Completed a CLOSED (CHIUSO) e vengono creati i Cost  Collector (vedi window Cost Collector da Manufacturing Order)

**ERRORI POSSIBILI** Ecco alcuni errori che posso essere Generati:

```
- Warehouse/Organization non trovata: significa che dobbiamo fare login come Warehouse
- Errore di Not Supported UOM: Significa che nel Workflow Manufacturing --> tab Activity, abbiamo impostato un Manufacturing Resource di tipo Work Center (il Resource Type di tale maschera deve avere un UOM diverso da EACH)
                               Vedi foto sotto:
```

[![IssueErrorUOM.png](http://192.168.178.102/images/4/40/IssueErrorUOM.png)](http://192.168.178.102/index.php/File:IssueErrorUOM.png)

---

## Print Release Order

[![PrintReleaseOrder.png](http://192.168.178.102/images/thumb/b/bb/PrintReleaseOrder.png/1000px-PrintReleaseOrder.png)](http://192.168.178.102/index.php/File:PrintReleaseOrder.png)

Una volta che i piani di produzione progettati dal MRP sono stati  approvati, è stata raggiunta la data di liberazione ed è stato  verificato che i componenti necessari esistono, gli ordini vengono  emessi all'impianto per la sua fabbricazione. Se si desidera stampare la  documentazione del magazzino e del negozio, è necessario selezionare la  casella di controllo appropriata:

```
- Print Pick List -->   Se si seleziona la casella di controllo "Is Print Pick List", viene visualizzato un Report con i componenti e le quantità necessarie per aiutare l'operatore 
                        del magazzino a rilasciare il materiale nel negozio. 
- Print Pack & Tool List --> viene visualizzato un report con i componenti necessari e contiene il materiale con un tipo di componente di imballaggio e strumenti registrati nella finestra BOM.
- Print Workflow --> È possibile stampare questo rapporto con il segno di spunta nella casella di controllo "Is Print Workflow", mostrerà al personale del negozio le fasi necessarie per la fabbricazione
                     del prodotto. Questo Report contiene il luogo in cui deve essere prodotto il prodotto, i tempi standard, gli strumenti ei dispositivi necessari. Se si desidera stampare questo Report,
                     selezionare la casella di controllo Stampa flusso di lavoro.
```

[![PrintReleaseOrder1.png](http://192.168.178.102/images/thumb/d/d7/PrintReleaseOrder1.png/1000px-PrintReleaseOrder1.png)](http://192.168.178.102/index.php/File:PrintReleaseOrder1.png)

---

## CONTO LAVORO PASSIVO

Vediamo un esempio:

---

### STEP 1 - Creare Manufacturing Workflow di Conto Lavoro

Creiamo un Manufacturing Workflow associando un prodotto  "Assemblaggio" (prodotto di tipo servizio) al Business Partner "Rossi  SRL". Vedi immagini:

PRODOTTO

[![ContoLavoro1.png](http://192.168.178.102/images/thumb/d/d6/ContoLavoro1.png/1000px-ContoLavoro1.png)](http://192.168.178.102/index.php/File:ContoLavoro1.png)


 MANUFACTURING WORKFLOW

[![ContoLavoro2.png](http://192.168.178.102/images/thumb/2/29/ContoLavoro2.png/1000px-ContoLavoro2.png)](http://192.168.178.102/index.php/File:ContoLavoro2.png)

### STEP 2 - Creaiamo Distinta Base e subito dopo Product Planning Data

Vedi immagine:

[![ContoLavoro3.png](http://192.168.178.102/images/thumb/e/e8/ContoLavoro3.png/1000px-ContoLavoro3.png)](http://192.168.178.102/index.php/File:ContoLavoro3.png)

### STEP 3 - Creaiamo Sales Order della mia Distinta e Completo l'ordine - Viene generato Ordine di Produzione

[![ContoLavoro4.png](http://192.168.178.102/images/thumb/9/9f/ContoLavoro4.png/1000px-ContoLavoro4.png)](http://192.168.178.102/index.php/File:ContoLavoro4.png)

Automaticamente, al completamento dell'ordine viene generato il  Manufactring Order (in questo caso delle mie 5 macchine MPK50+(CONF))

### STEP 4 - Completo l'Ordine di Produzione - Genero l'Ordine di Acquisto da window "Activity Control Report"

Dopo aver Completato l'Ordine di Produzione apro la maschera  "Activity Control Report" ed inserisco i dati dell'OP appena completato (solo se c'è il flag isMilestone='N' sul workflow altrimenti viene generato a mano).

[![ContoLavoro5.png](http://192.168.178.102/images/thumb/d/de/ContoLavoro5.png/1000px-ContoLavoro5.png)](http://192.168.178.102/index.php/File:ContoLavoro5.png)

Al Completamento del Documento viene generato automaticamente  l'Ordine di Acquisto del mio Conto Lavoro - prodotto "Assemblaggio" al  BP: Rossi SRL (e non l'ODA della mia macchina MPK50+(CONF) )

[![ContoLavoro6.png](http://192.168.178.102/images/thumb/6/66/ContoLavoro6.png/1000px-ContoLavoro6.png)](http://192.168.178.102/index.php/File:ContoLavoro6.png)

---
title: "Aliquote Iva"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 20
pre: "<b>8.12 </b>"
---
## PRESUPPOSTI

## articoli e prodotti sottostanno al regime IVA ed ai tre presupposti cardine della normativa IVA italiana:

### Requistito oggettivo
#### si applica a cessioni di beni

#### si applica a prestazioni di servizi
### Requisito soggetivo
#### si applica el contesto dell'esercizio di arti o profession
### Requistito della territorialità
#### si applica a transazioni effettuate nel territorio e confronti soggeti italiani


## Classificazione delle operazioni 

### Operazioni imponibili
#### se e quando rispondono a tutti e tre i requisiti indicati
### Operazioni non imponibili
#### in mancanza di uno o più requisiti indicati
### Operazioni esenti 
#### pur assolvendo ai requistiti sono esentate ad esempio per ragioni sociali
### Operazioni escluse
#### in quanto non ritenute rilevanti dalla normativa

FUNZIONAMENTO IN IDEMPIERE

1. IVA SU VENDITE

### 1.1 Iva su Vendita Italia su Italia

La gestione IVA prevista da iDempiere è :

a) da codice prodotto:

1 alliquota 4%

2 aliquota 5%

3 aliquota 10%

4 aliquota 22%

b) o da codice servizio in caso di prestazioni o materiali non codificati:

1  prodotto servizio 22%

2 prodotti servizio esenti:
 Esente Articolo 10 : definiscono operazioni esenti dall’imposta

1. prestazioni concernenti negoziazione di crediti e gestione degli stessi
2. assicurazioni riassicurazioni e vitalizio
3. operazioni in valute estere e di negoziazione cambio
4. operazioni relative ad azioni obbligazioni 
5. operazioni di versamento imposte
6. operazioni relative a lotto e lotterie nazionali
7. operazioni nell’esercizio del giuoco e scommesse
8. operazioni di affitto e relative cessioni
9. cessioni fabbricati
10. cessioni fabbricati strumentali
11. operazioni di mandato e intermediazione
12. cessione oro da investimento

a)lingotti

b)monete d’oro

​      13) cessioni campioni gratuiti a enti pubblici/associazioni

​      14) cessioni gratuite a popolazioni colpite da calamità

​      15) prestazioni trasporto urbano

​      16) trasporto con ambulanze

​      17) prestazioni servizi postali

​      18) diagnosi sanitarie

​      19) prestazioni per ricoveri 

​      20) prestazioni educative     

​            altre.

Impostazione iDempiere

Categoria : Cat.Esente Articolo 10   Aliquota : Esente articolo 10

Modo di Utilizzo : da indicare a mano nella scelta del prodotto/servizio  in fattura/ordine

Esempio :  compro prodotti farmaceuitici / 


3 prodotti servizio esclusi:

 Escluso Articolo 15 : definisce le esclusioni dalla base imponibile IVA

1. somme dovute a titolo di interessi moratori 
2. valore dei beni ceduti a titolo di sconto, premio o abbuono
3. somme dovute a titolo rimborsi anticipazioni fatte in nome e per conto
4. imballaggi di cui è pattuita espressamente la resa
5. somme dovute a titolo di rivalsa IVA

Impostazione iDempiere

Categoria : Cat.Escluso Articolo 15   Aliquota : Escluso articolo 15

Modo di Utilizzo : da indicare a mano nella scelta del prodotto/servizio  in fattura/ordine

Opzione : E’ possibile codificare un prodotto/servizio con questa categoria

Esempio : Spese documentate anticipate   -  Costo : 3.2.02.00.28 - Rimborso per spese anticipate   

ACQUISTO/VENDITA FARE CODICE PRODOTTO S.RIMBORSO PER SPESE   3.2.02.00.28 

ACQUISTO - FARE CODICE PRODOTTO  IMPOSTA DI BOLLO  3.2.09.00.01 - Imposta di bollo

Escluso Articolo  2 : definisce le cessioni di beni o le loro esclusioni dalla base imponibili

​            ESCLUSIONI

1. cessioni di denaro o crediti in denaro (vendita di denaro) 
2. cessioni o conferimenti di rami di azienda  
3. cessioni di terreni non edificabili  
4. cessioni di campioni gratuiti di modico valore appositamente contrassegnati.

Impostazione iDempiere

Categoria : Cat.Escluso Articolo 2   Aliquota : Escluso articolo 2

Modo di Utilizzo : da indicare a mano nella scelta del prodotto/servizio  in fattura/ordine

Opzione : E’ possibile codificare un prodotto/servizio con questa categoria

Esempio : Cessione campioni gratuiti  VENDITA - Ho il prodotto STOFFA IVA 22% modifico a mano e metto ESCLUSO ART 2.

Escluso Articolo 26 : definiscono le variazioni dell’imponibile o dell’imposta

1. rettifica di inesattezze di fatturazione
2. rettifiche a revoca per mancati pagamenti e procedure concorsuali o accordi ristrutturazione debiti
3. rettifiche inesattezze fatturazione posteriori all’anno   (esempio : nota di accredito relativa a fattura di vendita emesso oltre la liquidazione annuale)
4. altre.

Impostazione iDempiere

Categoria : Cat.Escluso Articolo 26   Aliquota : Escluso articolo 26

Modo di Utilizzo : da indicare a mano nella scelta del prodotto/servizio  in fattura/ordine

??? SCRITTURA ???  VIDEO  ???
 Non Imponibile art.74 : disposizioni relative a particolari settori. In deroga l’imposta è dovuta in caso (4% quotidiani ad es.):

1. commercio sali e tabacchi   
2. commercio fiammiferi
3. commercio giornali quotidiani
4. gestori di telefoni posti a disposizione del pubblico
5. vendita documenti di viaggio relativi a trasporti pubblici

si applica il meccanismo dell’inversione contabile invece ai casi definiti dallo stesso 

articolo 74 quater nel caso di 

​            cessioni di rottami, cascami e avanzi metalli ferrosi, carta da macero, stracci, ossa,          

​            pelli, pallets     

1. ghise gregge
2. leghe ferro
3. prodotti ferrosi
4. graniglie di ghisa ferro acciaio.

Impostazione iDempiere

Categoria : Cat.Escluso Articolo 74   Aliquota : Escluso articolo 74

Modo di Utilizzo : da indicare a mano nella scelta del prodotto/servizio  in fattura/ordine

Esempio :  Vendita Pallet se usati  reverse charge . Vendita non espone nessuna iva . In Acquisto con doppia imposizione + e - 

CATEGORIA UNICA DUE ALIQUOTE   VENDITA E ACQUISTO

Fuori Campo IVA: generico per adeguare ad ambito esclusione IVA.

Impostazione iDempiere

Categoria : Modo di Utilizzo : da indicare a mano nella scelta del prodotto/servizio  in fattura/ordine

Esempio :  Vendita Pallet se usati  reverse charge . Vendita non espone nessuna iva . In Acquisto con doppia imposizione + e - 

CATEGORIA UNICA DUE ALIQUOTE   VENDITA E ACQUISTO

Fuori campo IVA Art. 26  bis 

Fatture di acquisto agenzie interinali

Impostazione iDempiere

Categoria : Modo di Utilizzo : da indicare a mano nella scelta del prodotto/servizio  in fattura/ordine

Esempio :  Vendita Pallet se usati  reverse charge . Vendita non espone nessuna iva . In Acquisto con doppia imposizione + e - 

CATEGORIA UNICA DUE ALIQUOTE   VENDITA E ACQUISTO

FARE PRODOTTOSERVIZIO    COSTO  ???        

​	

Fuori campo IVA Art. 36 

​	

IVA 22% ind. 100%

solo su acquitsto

IVA 22% ind. 50%

IVA 22% ind. 60%

Non imponibile Art. 9

Prestazione  di trasporto

Impostazione iDempiere

Categoria : Modo di Utilizzo : da indicare a mano nella scelta del prodotto/servizio  in fattura/ordine



### 1.2 Iva su Vendita da Italia verso Cee



### 1.3 Iva su Vendita da Italia verso Extra Cee



## 2.Iva su Acquisto







​            




IVA 22% R.C. Ex art.17 c.6

Esempio : spese di pulizia  - subappalto edile

2 figli  + 22  -22 

Imposta Acquisti

Italia su Italia

 Non soggetto Art.1 co. 100 L.2008

Prestazione contribuenti minimalo

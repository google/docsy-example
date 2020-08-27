---
title: "Plugin Extra Pos"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b>723. </b>"
---

EXTRA POS -  15) LIT_isLoginRoleInvisible in table AD_User, per gestione Warehouse…. 

STEP 1 - cose bloccanti /importanti 

    1) sistemare il pannello a dx in alto ==OK==
    2) inserire le immagini per le icone del + e del - ==OK== 
    3) disabilitare la tastiera  + abilitare da s.o. ==OK== 
    4) icona stp - deve stampare lo stesso printformat ==OK== 
    5) Problema di refresh su caricamento history
    6) Task Processo - > Processo di accodamento dei prodotti (andrea)
    7)  Doctype : lit_ispos    come filtro nell’elenco dei doc visibili ==OK==
	gestione filtri sul POS ==OK==
    8)  Doctype : colore di sfondo .   add campo “color” nel doctype  ==OK== 
    9)  la  window ad_print_form : add   LIT_POS_PrintFOrmat_ID x3 :fattura ‘invoice’, scontrino ‘orderSO’, comanda ‘orderPO’ ==OK==
      11) Direct Print  - no anteprima ma stampa su sto  (andrea) ==OK==
      12) scrollbar sui prodotti  ==OK==
     13) Immagine Prodotto selezionato  - da Prodotto http  se non c’è da POSKEY ==OK==
	PS: fare attenzione mettere UN SOLO prodotto nella gerarchia dei 
POS-KEY, altrimenti da problemi nella visualizzazione nel pannello dell’Info
Product
     14)  Immagine Prodotti da griglia.  OK DA POSKEY + PRODOTTO http ==OK==
	PS: fare attenzione mettere UN SOLO prodotto nella gerarchia dei 
POS-KEY, altrimenti da problemi nella visualizzazione nel pannello dell’Info
Product
     15) rimane qty 2==OK==
     16) togliere gli zeri dalla qty ==OK==

CLONARE LA MASCHERA

STEP 2 - da fare solo nella maschera clonata per Scarico Magazzino

    a) puntare  alla nuova tabella   Testata e righe 
    b) eliminare riferimento a BP
    c) 

STEP 3 - da fare solo nella maschera POS

    10) Inserimento Partita Iva -> creazione del BP    [step 2 ]
    11)  14) creare DD_Order su complete del Purchase order dei prodotti che sono in gruppo prodotto di tipo LIT_isDDOrder (table: M_Product_Category)




    
    ---
title: "Plugin Pos"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: ""
---


**PLUGIN WPOS**

  Contents  [[hide](http://192.168.178.102/index.php/Plugin_i-POS#)]   [1 Prerequisiti Installazione Plugin](http://192.168.178.102/index.php/Plugin_i-POS#Prerequisiti_Installazione_Plugin) [2 Parametrizzazione Plugin](http://192.168.178.102/index.php/Plugin_i-POS#Parametrizzazione_Plugin)  [2.1 POS Terminal](http://192.168.178.102/index.php/Plugin_i-POS#POS_Terminal) [2.2 POS Key Layout e lit_c_poskey_v](http://192.168.178.102/index.php/Plugin_i-POS#POS_Key_Layout_e_lit_c_poskey_v) [2.3 Aggancio POS alla FORM](http://192.168.178.102/index.php/Plugin_i-POS#Aggancio_POS_alla_FORM) [2.4 Maschera POS](http://192.168.178.102/index.php/Plugin_i-POS#Maschera_POS) [2.5 Quick Entry - Informazioni aggiuntive](http://192.168.178.102/index.php/Plugin_i-POS#Quick_Entry_-_Informazioni_aggiuntive)    

## Prerequisiti Installazione Plugin



```
1) Scaricare l'Application FRAGMENT
2) Installare il 2packSystemFragment
3) Installare i plugin Fragment "idIta.modification.org.adempiere.base" e "idIta.modification.org.adempiere.ui.zk"
4) Plugin dipendenti dal WPOS da installare it.cnet.impl.editorNatIDNumber, it.cnet.idempiere.utilPDF, org.libero.manufacturing
5) Installare il plugin del WPOS reperibile qui --> /opt/repos/idempiere-download/plugin-standard/WPOS/org.idempiere.wpos_1.0.0.201712120931(ID_Consulting)
6) Installare i due 2pack sempre reperibili all'interno della directory  /opt/repos/idempiere-download/plugin-standard/WPOS/
```

## Parametrizzazione Plugin

---

### POS Terminal

Vediamo come parametrizzare il POS Terminal:

[![POS1.png](http://192.168.178.102/images/thumb/3/33/POS1.png/1200px-POS1.png)](http://192.168.178.102/index.php/File:POS1.png)



### POS Key Layout e lit_c_poskey_v

Viene utilizzata una vista per la parametrizzazione del POS Key Layout (lit_c_poskey_v). L'utilizzo della vista è flessibile.

[![POS2.png](http://192.168.178.102/images/thumb/f/fa/POS2.png/1055px-POS2.png)](http://192.168.178.102/index.php/File:POS2.png)

Posso adesso modificare la vista in base ai parametri e filtri che  desidero, nello specifico è importante tenere in considerazione il campo  ID del POS Key Layout.

[![POS3.png](http://192.168.178.102/images/thumb/1/17/POS3.png/1000px-POS3.png)](http://192.168.178.102/index.php/File:POS3.png)



### Aggancio POS alla FORM

Per poter aprire il POS il nome della FORM dele essere lo stesso di quello del POS Terminal

[![POS4.png](http://192.168.178.102/images/thumb/3/35/POS4.png/1000px-POS4.png)](http://192.168.178.102/index.php/File:POS4.png)



### Maschera POS

Ricorda, per poter aprire la maschera del POS devi essere loggato con l'utente e l'organizzazione specificata nel POS Terminal

[![POS5.png](http://192.168.178.102/images/thumb/9/91/POS5.png/1000px-POS5.png)](http://192.168.178.102/index.php/File:POS5.png)

### Quick Entry - Informazioni aggiuntive

Come impostare le INFO aggiuntive nel POS (sia nella testata che sulle righe)

![POS6.png](http://192.168.178.102/images/thumb/3/36/POS6.png/1000px-POS6.png)




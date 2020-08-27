---
title: "Plugin Import Listino Prodotti"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b>720. </b>"
---

## FUNZIONALITA' PLUGIN (Lato Cliente)

### Obiettivo

Un Cliente chiede di un rasaerba .Cerco i rasaerba gestiti (codifica in id) e :

a) trovo il rasaerba desiderato  8888888 in idempiere ma non avendone a magazzino e quindi dovendo fare un oda vorrei avere dal sistema l'informazione 
se ho altri fornitori dello stesso prodotto (88888888) a un miglior presso 

```
A) lo trovo . voglio caricare il listino per quelo forntiore ( tab acquisti )
```

b) non lo trovo ... lo cerco su un catologo .. vedo che il codice è 88888888 e mi compare a sitema l'eleco dei fornitori che hanno quelo codice

```
a) caglio
b) tony 
c) Floriano
```


Caglio 40.000 codici

```
Codice Fornitore  Descrizione                  Prezzo    Barcode   Fornitore 
12345 tagliaerba black & decker 1521 150W      150 euro  88888888  Caglio
...
...
..
..
Tony 80.000 
45454 Rasaerba Balck %decker 1521/bwrt         145 eruo  88888888 Tony 
...
..
..
.. 
5555 r b&d                                    132 eruo  8888888 Floriano
```

---

## Gestione Prodotto a Scatole/Pacchi

Il plugin GeneralImporting gestisce l'importazione dalla LIT_I_Product (window LIT Import Product) alla M_Product.

Supponiamo di avere caricato nella LIT_I_Product una scatola di Latte (che contiene 6 bottiglie di latte) ed avere il Listino Prezzi della scatola. Quando andiamo a caricare questo Prodotto vogliamo però caricare nella M_Product il listino di una singola bottiglia di latte. Il plugin che cosa fa? Prezzo della Scatola divio il numero delle bottiglie situate all'interno della scatola.

Se nel campo "Order Pack Qty" abbiamo un numero maggiore di 1 (esempio 3) allora il plugin GeneralImporting mi creerà un listino prezzi di questo tipo: List Price/Order Pack Qty. Facciamo un esempio: se il List Price=8.00 e il campo "Order Pack Qty"=3 allora verrà creato un listino di 8.00/3= 2,66 euro (arrotondato in base alle impostazioni del listino - CAMPO "Price Precision" nella window "Price List")

---

## STEP IMPORTAZIONE PRODOTTI (Parte Tecnica)

### Step 1: Copia File sul Server

Creato con Talend processo "CopyFileToServer" che mi consente di prendere un file 'FileProdotti.xlsx' (nel nostro caso risede all'interno della directory /opt/ShareFolder/Ferramenta/import/) e lo copia sul server dove risiede il mio pacchetto idempiere (directory del server: /opt/ShareFolder/Ferramenta/import/). Ovviamente posso modificare le directory di provenienza e destinazione dal Talend.

All'interno del FileProdotti.xlsx' possiamo caricare i prodotti che poi verranno caricati nella maschera "LIT Import Product" (Il Template del file 'FileProdotti.xlsx' lo possiamo recuperare all'interno della seguente directory: /opt/repos/idempiere-download/task_EDI/Ferramenta/)

### Step 2: Carico i prodotti nella LIT Import Product

Dopo aver caricato il "FileProdotti.xslx" sul server possiamo lanciare il comando di importazione dei prodotti su idempiere. Anche qui è stato creato un processo Talend "FerramentaImportProduct" (presente all'interno della seguente directory: /opt/repos/idempiere-download/task_EDI/Ferramenta/) il quale preleva tutti i prodotti all'interno del file xslx e gli carica nella tabella LIT_I_Product (window LIT Import Product).

Il processo può essere lanciato:

```
- manualmente lanciando il job da linux (./nomedeljob.sh)
- manualmente all'interno di idempiere (lanciando il processo all'interno della window       "Run Task Client")
- automaticamente da scheduler
```

Come viene agganciato il processo in idempiere?
Innanzitutto viene creato il Task (vedi immagine sotto) ed inserito come path il file Talend di importazione (Attenzione: Ricorda di avere installato il Plugin InitialClientSetup)

![image](/image/ImportListinoProdotti-Task.png)


Dopodichè richiamiamo il Task creato in una Rule (vedi immagine sotto)

![image](/image/ImportListinoProdotti-Rule.png)

Questa Rule verrà agganciata al Processo (vedi immagine sotto)

![image](900px-Rule1.png)

Infine, entro nel mio Client e aggancio il processo alla mia maschera Run Task Client (ovviamente posso creare un solo processo da menu oppure fare una schedulazione automatica)

![image](/image/ImportListinoProdotti-Rule2.png)

### Step 3: Caricamento prodotti nella M_Product (Funzionamento del plugin GeneralImporting)

Dopo aver lanciato il processo di importazione posso visualizzare i miei prodotti all'interno della maschera "LIT Import Product"

![image](/image/ImportListinoProdotti.jpg)

I campi riquadrati di rosso devono essere obbligatori per consentire che il successivo passaggio avvenga correttamente, ovvero l'importazione definitiva dei prodotti nella M_Product.

Il plugin GeneralImporting gestisce l'importazione dalla LIT_I_Product alla M_Product con il relativo calcolo dei prezzi e inserimento del listino. 

Se nel campo "Order Pack Qty" abbiamo un numero maggiore di 1 (esempio 3) allora il plugin GeneralImporting mi creerà un listino prezzi di questo tipo: List Price/Order Pack Qty. Facciamo un esempio: se il List Price=8.00 e il campo "Order Pack Qty"=3 allora verrà creato un listino di 8.00/3= 2,66 euro (arrotondato in base alle impostazioni del listino)

E' stata creata una infoWindow "LIT Import External Product Info" che mi consente di selezionare i prodotti presenti nella LIT_I_Product ed importarli nella M_Product (vedi immagine sottostante)

![image](/image/ImportListinoProdotti-2.png)

Seleziono i prodotti che mi interessano e premo nel pulsante in basso

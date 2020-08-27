---
title: "Plugin Ecommerce"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 15
pre: "<b>735. </b>"
---

## Video - Woocommerce 3 Sincronizzazione Prodotti [V107]
{{<youtube ctJ5IuEPUDc>}}


Woocommerce 1 Configurazione su WordPress V105 https://youtu.be/QUp_TGAX6zw

Woocommerce 2 Configurazione iDempiere V106 https://youtu.be/3H4chEGXrCg

Woocommerce 3 Sincronizzazione Prodotti V107  https://youtu.be/ctJ5IuEPUDc



## link esterni

```
http://www.wpbeginner.com/plugins/20-best-free-woocommerce-plugins-for-wordpress/
https://docs.woocommerce.com/document/webhooks/
https://codecanyon.net/item/woocommerce-point-of-sale-pos/7869665
```

## Riferimenti

* link pubblico          : non applicabile
* link idempiere italia  : https://bitbucket.org/consulnet/idempiere-ita-plugin - it.cnet.impl.LIT_ECommerce
* link jar               : /opt/repos/idempiere-download/plugin-italia/LIT_ECommerce/
* versione idempiere     : idempiere 3.1
* versione zk supportata : na

```
https://bitbucket.org/netgrid/java-woocommerce-client/commits/branch/master
```

## Descrizione Plugin

Questo plugin sincronizza 

### 1) Prodotti

```   
Sincronizzazione Bidirezionale
```

### 2) Listini

### 3) Ordini di vendita

tra iDempiere e Woocommerce (e-commerce di wordpress) 

Per i prodotti e per i prezzi la sincronizzazione è bidirezionale.

## Funzionalità supportate

Prodotti 
- sincronizzazione da idempiere verso woocommerce
- sincronizzazione da woocommnerce verso idempiere

Listini
- sincronizzazione da idempiere verso woocommerce
- sincronizzazione da woocommerce verso idempiere

Magazzino
- sincronizzazione da idempiere verso woocommerce

Ordini di Vendita
- sincronizzazione da woocommerce verso idempiere

---

## Installazione Plugin

Installare nella console felix il jar reperibile su [https://bitbucket.org/consulnet/idempiere-download idempiere-download]

---

## Parametrizzazione Plugin

---

## Istruzioni Plugin

---

## Documentazione Tecnica Plugin

### Modifiche all'AD

#### Tables / Windows esistenti

#### Nuove Tables /Windows

---

## Funzionalità Future

``` 
?? Categoria [ ]  (SIncronizaio )
?? Virtuale 
?? Tag
?? Immagine (1 solo per adessso )
```

---

## Errori e bug

** Manca come inserire un prodotto in idempiere per sincronizzarlo - 2- cosa sincronizza 

- value - name -description - immagine ? prezzo SKU  ???

** descrivere le casistiche di modifica -- da idemipere vs woocomerce-- cosa viene gestito (tutto ?) 
** descrivere i vari processi di idmepiere di sincronizzazione : cosa fanno ? 

```
-- sincronizza ...
   --- sdfsdf
```


Il plug-in permette la sincronizzazione dei dati di prodotti e ordini su piattaforma Woocommerce.

```
Riferimenti e link
http://woothemes.github.io/woocommerce-rest-api-docs/?shell#products
```

**TODO**: parametrizzare in ambiente iDempiere i dati relativi alla connessione a Woocommerce.....

**TODO**: impostata la categoria di tassa al 22%

## Configurazione Ambiente idempiere-ecommerce

Installazione plug-in iDempiere it.cnet.impl.LIT_ECommerce.jar

Lo *.zip "2PackClient_Woocommerce_connect.zip", è da installare tramite packin a livello client e sono dati che fanno riferimento alla connessione con credenziali a woocommerce installato su wordpress + un M_PriceList_ID di esempio, da cambiare a seconda delle impostazione del Client.... Ovviamente sono di base, cambiare i dati in base alla installazione di woocommerce....

![image](/image/WoocommSysConfig_1.png)

Parametri di "Configuratore di Sistema " da controllare

```
Nome   : LIT_Host_Woocommerce  
Chiave : shop2.idempiereitalia.com   ( indicare il sito web ove installato woocommerce )
```

``` 
Nome   : LIT_Key_Woocommerce
Chiave : ...49392d
```

```
Nome   : LIT_Secret_Woocommerce
Chiave : ..264238a0
```

```
Nome   : LIT_Woocommerce_PriceList_ID
Chiave : (.....M_PriceList_ID, esempio = 1000007....)
```

### Creazione sito wordpress e installazione plugin woocommerce

**Per creare sito wordPress su one.com:** 

accedere al pannello di controllo come amministratore, scegliere il dominio associato (es. idempiereitalia.com) e infine cliccare su icona "Wordpress"

alla maschera successiva cliccare su "Nuova Installazione"

maschera successiva, "Ubicazione blog": immettere un nome per sito Wordpress (es. shop.idempiereitalia.com); cliccare poi su "Installa"

una volta installato, il nuovo sito Wordpress risulta nella lista delle installazioni create; cliccare su link "WP admin" per completare l'installazione

scegliere lingua e dopo copiare da parte l'utente e password per poter accedere sul pannello di controllo del sito Wordpress creato; infine cliccare "Installa WordPress"

**Settaggi di base per wordPress e installazione di plug-in Woocommerce:**

dalla pagina principale, in fondo a destra cliccare sul link "Accedi", per accedere al pannello di controllo e installare il tema per il sito e l'extension di Woocommerce

dalla dashboard, menu sinistra, selezionare "Aspetto > Temi": sceglierne uno.....

una volta installato il tema, nel menu della dashboard, selezionare "Plugin", poi cliccare su "Aggiungi nuovo" e installare il plugin "Woocommerce -- di WooThemes"

infine attivare il plugin installato

**Attivazione plugin Woocommerce e relativi settaggi:**

seguire gli step per l'installazione base di woocommerce

secondo step: Per la corretta lettura di tutti i prodotti presenti a catalogo via REST/Json, bisogna impostare il limite max degli articoli recenti; da console di Wordpress --> Impostazioni > Lettura (Impostazioni di lettura) e alla voce "''Le pagine del blog visualizzano al massimo''" impostare nel campo il numero degli articoli (es. 1000)

![image](/image/WoocommerceImpostazioni.png)

terzo step: attivare le API Rest di woocommerce. Console di Wordpress --> Woocommerce > Impostazioni > Tab 'API' e selezionare "Chiavi/App" e cliccare su pulsante "Aggiungi Chiave"; scegliere utente e permessi "Leggi/Scrivi" e infine "Genera chiavi API" ---> copiare e mettere da parte la Chiave Consumer e Segreto Consumer che servono come credenziali per l'accesso a woocommerce via Rest....

![image](/image/WoocommerceImpostazioniAPI.png)

quarto step: da console di Wordpress --> Impostazioni > Permalink = (1)alla voce "Impostazioni comuni" selezionare 'Numerico'; (2)alla voce "Permalink dei prodotti" selezionare 'Base personalizzata' e nel campo aggiungere il nome della pagina relativa al negozio....per esempio se l'indirizzo è http://shop.idempiereitalia.com/negozio, allora mettere nel campo '''''/negozio''''' ..... Dopo aver impostato il tutto, cliccare su salva modifiche


Per importare gli ordini su iDempiere

*Parametri di connessione su System Configurator* (livello client....importante !!!):

**key** = "ck_d0cd4bd5975c14dec7868703f2a9c88e9208e80c"; //shop.idempiereitalia

**secret** = "cs_1f63c8fd5786136044359b369d5f92b8f415da37";  //shop.idempiereitalia

**hostWoocom** = "shop.idempiereitalia.com";

*Parametri impostati a codice*:

**internalShopProducts** = "wc-api/v2/products";

**postProducts** = "wc-api/v2/products/bulk";

**internalShopOrders** = "wc-api/v2/orders";

**postOrders** = "wc-api/v2/orders/bulk";

```
Installazione iDempiere
NO CONTABILITA’
tabelle iva
anagrafica business partner
prodotti  + stampa etichette barcode
offerte di vendita  - 1 modulo di stampa 
ordini di acquisto -  1 modulo di stampa 
entrata merci
spedizioni
NO fatture fornitori 
Fatture di Vendita
Movimenti di Magazzino 
Vendita al banco !!  a) ottimizzare  offerta ins barcode  b ) unicenta …. 
Resi a clienti
Resi a fornitore
Listini  e sconti 
( extra ) caricamento listini
( extra ) caricamenti dei ddt in automatico
```

---

## Descrizione processi di sincronizzazione

**IMPORTANTE:**  **<span style="color:red">per il corretto funzionamento di questi processi SI DEVE SELEZIONARE a login Client anche l'Organizzazione e la relativa Warehouse, se no da errore nella sincronizzazione....</span>**
#'''''Sincronizzazione prodotti iDempiere <->WooCommerce:''''' al momento della connessione al negozio WooCommerce, viene prelevata l'intera lista dei prodotti presenti su negozio tramite JSON e la lista completa viene salvata in una tabella in ambiente iDempiere ---> nome tabella: LIT_WooProducts. Con questa tabella, confrontando con la tabella M_Product, si verifica se sono stati aggiunti nuovi prodotti o aggiornati sul negozio; se questo si verifica, viene aggiunto/aggiornato il prodotto su iDempiere.<br>Questo avviene anche da iDempiere verso WooCommerce: in base a questo criterio di ricerca su db --> <span style="color:green">TABELLA: M_Product [IsSelfService='Y' AND SKU IS NOT NULL AND NOT EXISTS (SELECT * FROM LIT_WooProducts od WHERE M_Product.SKU =  od.LIT_Sku AND od.AD_Client_ID=?)]</span> ...viene recuperata la lista dei prodotti non presenti su WooCommerce; mentre in base a quest altro criterio di ricerca su db --> <span style="color:green">TABELLA: M_Product [IsSelfService='Y' AND SKU IS NOT NULL AND Updated> (SELECT LIT_UpdatedAt FROM LIT_WooProducts mw WHERE M_Product.SKU =  mw.LIT_Sku AND mw.AD_Client_ID=?)]</span> ...viene recuperata la lista dei prodotti aggiornati su iDempiere
#'''''Sincronizzazione ordini iDempiere <->WooCommerce:'''''

---

## Tabelle da sincronizzare

{|style="border: 1px solid #789DB3; border-collapse: collapse; align:center; width:100%;"
|-
! style="background:#9aa3f9;align:left"|Nome Table Ecommerce
! style="background:#9aa3f9;align:left"|-> iDempiere
! style="background:#9aa3f9;align:left"|<- ECommerce
! style="background:#9aa3f9;align:left"|Nome Table iDempiere
! style="background:#9aa3f9;align:left"|Note
|-
! style="border: 1px solid #789DB3;"|Customer
! style="border: 1px solid #789DB3;"|Si  (step 2  per il btb)
! style="border: 1px solid #789DB3;"|Si  (step 1)
! style="border: 1px solid #789DB3;"|Business Partner
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|Addresses
! style="border: 1px solid #789DB3;"|Si
! style="border: 1px solid #789DB3;"|Si
! style="border: 1px solid #789DB3;"|BP Addresses
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|Product Base
! style="border: 1px solid #789DB3;"|Si
! style="border: 1px solid #789DB3;"|Si
! style="border: 1px solid #789DB3;"|BP Addresses
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|Price
! style="border: 1px solid #789DB3;"|Si
! style="border: 1px solid #789DB3;"|Si
! style="border: 1px solid #789DB3;"|BP Addresses
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|Giacenza
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|Si
! style="border: 1px solid #789DB3;"|BP Addresses
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|Ordine
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|Si
! style="border: 1px solid #789DB3;"|BP Addresses
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|Immagini ?
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
|-
|}

---

## TABELLA PRODOTTO

{|style="border: 1px solid #789DB3; border-collapse: collapse; align:center; width:100%;"
|-
! style="background:#9aa3f9;align:left"|Nome Campo
! style="background:#9aa3f9;align:left"|ECommerce
! style="background:#9aa3f9;align:left"|iDempiere 
! style="background:#9aa3f9;align:left"|Nome Table iDempiere
! style="background:#9aa3f9;align:left"|Note
|-
! style="border: 1px solid #789DB3;"|Title
! style="border: 1px solid #789DB3;"|Title
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|id
! style="border: 1px solid #789DB3;"|id
! style="border: 1px solid #789DB3;"|...
! style="border: 1px solid #789DB3;"|...
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|id
! style="border: 1px solid #789DB3;"|id
! style="border: 1px solid #789DB3;"|...
! style="border: 1px solid #789DB3;"|...
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|Created
! style="border: 1px solid #789DB3;"|Created
! style="border: 1px solid #789DB3;"|Created
! style="border: 1px solid #789DB3;"|BP Addresses
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|Price
! style="border: 1px solid #789DB3;"|Si
! style="border: 1px solid #789DB3;"|Si
! style="border: 1px solid #789DB3;"|BP Addresses
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|Giacenza
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|Si
! style="border: 1px solid #789DB3;"|BP Addresses
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|Ordine
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|Si
! style="border: 1px solid #789DB3;"|BP Addresses
! style="border: 1px solid #789DB3;"|
|-
! style="border: 1px solid #789DB3;"|Immagini ?
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
! style="border: 1px solid #789DB3;"|
|-
|}
<br>


<br>

---

## Processo di Sincronizzazione

```
Premessa : Creare una tabella in idempiere copia di quelle di woocommerce 
Tabelle previste :
LIT_WooProduct
LIT_WooCustomer
```

```
Processo sync Product 
a) processo di sincronizzazione tra woocommerce e la tabella interna LIT_WooProduct 
     Cancellare il contenuto della tabell LIT_WooProduct (tenere conto del AD_Client_ID )
     [delete from lit_wooproduct where ad_client_id=?]
     Leggo con le API REST woocommerce e carico la tabella interna LIT_WooProduct _OK_
     Salvo il file json in una cartella per avere uno storico (da abilitare oppure no)
b) Faccio una select per ottenere i Product NOT IN LIT_WooProduct and                        M_Product.selfservice=true  
   (codici inseriti in idempiere non presenti in woocommerce che devono essere aggiornati)
   -> Eseguo una API REST di CREATE PRODUCT su WooCommerce '''_OK_'''
c) Faccio una select per ottenere i Product modificate                                m_product.updated>lit_wooProduct.updated  
      -> Eseguo una API REST di UPDATE PRODUCT su WooCommerce 
  d) Faccio una select per ottenre i Product NOT IN M_Product  ma present in LIT_WooCommerce 
      (codice inseriti in woocommerce e non presenti in idempiere )
      creo il codice in idempiere prendendo i dati dalla LIT_WooCommerce '''_OK_'''
  e) Faccio un select per ottere i    lit_wooProduct.update> m_product.update   (Aggiornati su woocommerce)
      faccio un update in idmpeiere prendento i dati dalla LIT_WooCommerce


```


 Processo sync Customer

 Processo Ordine eseguito su Woocommerce
 ->alla fine del processo ricevo un email
 -> cattura questa email e faccio partire il processo lato idempiere che fa :
    -leggo  i nuovi ordini 
    - processo quello che devo processare in idempiere
    - chiamo woocommerce per cambiare lo stato dell'ordine

---

## Mapping Product

{
   "product": {
   "title": "Premium Quality",
   "id": 546,
   "created_at": "2015-01-22T19:46:16Z",
   "updated_at": "2015-01-22T19:46:16Z",
   "type": "simple",
   "status": "publish",
   "downloadable": false,
   "virtual": false,
   "permalink": "https://example.com/product/premium-quality/",
   "sku": "",
   "price": "21.99",
   "regular_price": "21.99",
   "sale_price": null,
   "price_html": "<span class=\"amount\">&#36;&nbsp;21.99</span>",
   "taxable": true,
   "tax_status": "taxable",
   "tax_class": "",
   "managing_stock": false,
   "stock_quantity": 0,
   "in_stock": true,
   "backorders_allowed": false,
   "backordered": false,
   "sold_individually": false,
   "purchaseable": true,
   "featured": false,
   "visible": true,
   "catalog_visibility": "visible",
   "on_sale": false,
   "weight": null,
   "dimensions": {
     "length": "",
     "width": "",
     "height": "",
     "unit": "cm"
    },
    "shipping_required": true,
    "shipping_taxable": true,
    "shipping_class": "",
    "shipping_class_id": null,
    "description": "<p&gt;Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Vestibulum tortor quam, 
     feugiat vitae, ultricies eget, tempor sit amet, ante. Donec eu libero sit amet quam egestas semper. Aenean ultricies mi vitae est. Mauris 
     placerat eleifend leo.</p&gt;\n",
    "short_description": "<p&gt;Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p&gt;\n",
    "reviews_allowed": true,
    "average_rating": "0.00",
    "rating_count": 0,
    "related_ids": [
      37,
      47,
      31,
      19,
      22
    ],
    "upsell_ids": [],
    "cross_sell_ids": [],
    "parent_id": 0,
    "categories": [
      "Clothing",
      "T-shirts"
    ],
    "tags": [],
    "images": [
      {
        "id": 547,
        "created_at": "2015-01-22T19:46:16Z",
        "updated_at": "2015-01-22T19:46:16Z",
        "src": "http://example.com/wp-content/uploads/2015/01/premium-quality-front.jpg",
        "title": "",
        "alt": "",
        "position": 0
      },
      {
        "id": 548,
        "created_at": "2015-01-22T19:46:17Z",
        "updated_at": "2015-01-22T19:46:17Z",
        "src": "http://example.com/wp-content/uploads/2015/01/premium-quality-back.jpg",
        "title": "",
        "alt": "",
        "position": 1
      }
    ],
    "featured_src": "http://example.com/wp-content/uploads/2015/01/premium-quality-front.jpg",
    "attributes": [],
    "downloads": [],
    "download_limit": 0,
    "download_expiry": 0,
    "download_type": "",
    "purchase_note": "",
    "total_sales": 0,
    "variations": [],
    "parent": [],
    "grouped_products": [],
    "menu_order": 0
  }
}

Woocommerce

WOOCOMMERCE

Peso 
Dimensione x,y,z



-- iDempiere
?? tax    OK COSI PER ADESSO DA RIVEDERE  (default categoria default) 
?? tipo articolo 
  da Woocommerce Se “gestito a Magazzino” -> ITEM altrimenti SERVICE
  da idempiere se ITEM -> Gestinoa a MAgazzino  else no gestione a maga
da woocommerce     Se “gestito a Magazzino”   fare un inventario a qta stock (## STEP 2 )  (    Quale Magazzino ??   )

da idempiere se item . leggere da m_storageonhand  qtyonhand e caricarlo come stock 

STUTUS :DISPONIBILE

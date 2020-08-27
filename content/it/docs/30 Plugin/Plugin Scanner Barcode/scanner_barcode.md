# Plugin ScannerBarcode Save&New

---

Jump to: [navigation](http://192.168.178.102/index.php/Plugin_ScannerBarcode_Save%26New#column-one), [search](http://192.168.178.102/index.php/Plugin_ScannerBarcode_Save%26New#searchInput)

- link 2pack  : /opt/repos/idempiere-download/plugin-italia/ScannerBarcode_Save&New/2packScannerBarcode_Save&New.zip

---

## Descrizione Plugin

Plugin per semplificare l'inseriemnto dei Prodotti da Barcode

Callout che mi consentono di salvare ed andare su una riga successiva.

Inserendo nel mio campo LIT_Barcode il mio Barcode ho 4 casistiche:

```
1) Se il codice Barcode=Prodotto  --> allora automaticamente verrà copiato nel campo  M_Product il codice, salverà e andrà sulla riga successiva
2) Se il codice Barcode=Numero Quantità --> automaticamente verrà copiato nel campo  QtyEntered il numero e il focus si sposterà sul Prodotto
3) Se il codice Barcode presenta dei caratteri che non sono nè codici cè quantità -> mi fuoriesce una popup di avvertimento ERRORE
4) Se il codice Barcode=".Undo"  --> Ignora l'ultima modifica e torna indietro
```

Vedi le immagini seguenti:

[![Barcode1.png](http://192.168.178.102/images/thumb/1/1b/Barcode1.png/800px-Barcode1.png)](http://192.168.178.102/index.php/File:Barcode1.png)


 [![Barcode2.png](http://192.168.178.102/images/thumb/4/49/Barcode2.png/800px-Barcode2.png)](http://192.168.178.102/index.php/File:Barcode2.png)


 [![Barcode3.png](http://192.168.178.102/images/thumb/e/e7/Barcode3.png/800px-Barcode3.png)](http://192.168.178.102/index.php/File:Barcode3.png)

---

## Parametrizzazione

NOTA BENE: Column presente nella C_OrderLine (Ricordarsi di Creare la Fields)

```
1) Agganciare la collout "@script:beanshell:Save&New" nella column M_Product_ID
1) La collout "@script:beanshell:BarcodeSave&New" è già agganciata nella column LIT_Barcode
```

 

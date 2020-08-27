---
title: "Setup Risorsa"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 37
pre: "<b></b>"
---

## Listino Prezzi
[{{< figure src="/image/Listino0.png"  width="850"  >}}](/image/Listino0.png)

## Riferimenti


- link 2pack /opt/repos/idempiere-download/plugin-italia/ScontoTestata/2packSystemScontoTestata.zip

## Descrizione 2pack

---

Nuova funzionalità che consente di applicare gli sconti multiriga inserendoli da testata. Due differenti gestioni:

```
-applicare sconto a tutti i prodotti
-applicare sconto SOLO a prodotti con Discount = 0.0
```

Vediamo un esempio nella maschera delle Sales Order.

Inseriamo lo sconto che vogliamo applicare, e premiamo sul Pulsante "Apply Discount"

![Sonto1.png](/image/PrezziScontoTestata1.png)

 Per applicare lo sconto su qualsiasi riga dobbiamo deselezionare il campo "Applica solo ai prodotti con Sconto=0.0"

![Sonto2.png](/image/PrezziScontoTestata2.png)


 Ecco il risultato:

![Sonto4.png](/image/PrezziScontoTestata4.png)

 Oppure applichiamo lo sconto solamente ai prodotti con Discount=0.0  (selezioniamo il campo "Applica solo ai prodotti con Sconto=0.0")

![Sonto3.png](/image/PrezziScontoTestata3.png)

 Ecco il risultato:

![Sonto5.png](http://192.168.178.102/images/PrezziScontoTestata5.png)


 Inoltre, ad ogni inserimento di un prodotto nelle righe, viene impostato  il valore di Sconto impostato in Testata (solo se lo Sconto in testata è  diverso da 0)

Vediamo un esempio:

![Sonto6.png](/image/PrezziScontoTestata6.png)

Come possiamo vedere dall'immagine qui sopra, quando inseriamo un  nuovo prodotto, esso assumerà lo Sconto impostato dalla testata  dell'ordine (ATTENZIONE: questo solo se il campo Sconto testata è  diverso da 0.0, altrimenti se = 0.0 assumerà lo sconto di default  impostato dal prodotto)

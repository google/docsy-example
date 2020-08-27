---
title: "Ordine di Distribuzione"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 73
pre: "<b></b>"
---

# Ordine di Distribuzione 


Jump to: [navigation](http://192.168.178.102/index.php/Ordine_di_Distribuzione#column-one), [search](http://192.168.178.102/index.php/Ordine_di_Distribuzione#searchInput)

---

## Distribution Order

Presente nel plugin di **Libero Manufacturing**

---

## Generare l'Ordine di Distribuzione da Replenish Report

Vogliamo spostare il materiale da Magazzino Principale "*Magazzino Centrale Distr.*" a --> "*Magazzino Destinazione*" (1 o più magazzini di destinazione)

Vediamo i passaggi:


1) Nel Business Partner dobbiamo linkare l'organizzazione (Processo Link  Organization) di dove sono situati i miei magazzini (in questo esempio  colleghiamo il BP:Trade SRL all'organizzazione Trade). Quindi, quando  generiamo l'Ordine di Distribuzione dal "Replenish Report" viene  automaticamente inserito il Business Partner "Trade SRL"

![ODD.png](/image/DistributionOrder-ODD.png)



2) Andiamo ad impostare i nostri magazzini di Destinazione (che  possono essere esempio dei punti vendita). Vediamo un esempio di come  deve essere parametrizzato il magazzino di destinazione:

![ODD1.png](/image//image/DistributionOrder-ODD1.png)



3) Andiamo nella Tab Replenish del Prodotto ed inseriamo il Magazzino  di Destinazione (altrimenti l'Ordine di Distribuzione non verrà creato)

![ODD2.png](/image/DistributionOrder-ODD2.png)



4) Andiamo nel Replenish Report e creiamo il nostro Ordine di  Distribuzione (impostiamo come Magazzino il Magazzino di Destinazione)

![ODD3.png](/image/DistributionOrder-ODD3.png)


5)Bene, adesso il nostro Ordine di Distribuzione è stato creato. Quello che dobbiamo fare è:

```
-andiamo nell'Ordine di Distribuzione appena generato e confermiamo la Quantità nelle Linee (campo Confirmed Quantity inizialmente impostato a 0), inseriamo una quantità <> 0
-completiamo di documento
```

![ODD4.png](/image/DistributionOrder-ODD4.png)

**ATTENZIONE**: vogliamo o no tener conto della Giacenza del magazzino Centrale?

```
- Delivery Rule --> Availability (Nel nostro esempio: il prodotto "Havana" ha una giacenza nel magazzino di 300 unità, nel caso non ci fosse ricorda di fare un PHYSICAL INVENTORY)
- Delivery Rule --> Force(*)  (Non tiene conto della giacenza nel magazzino centrale e quindi lo forza sia che sia 0, sia che sia negativo)
```

*modificata classe Java  "org.libero.process.MovementGenerate" (da riga 561 a 578 ) -->  aggiunto if (!force) in modo che venga generato l'Inventory Move anche  se non c'è giacenza a magazzino (dimenticato e scopiazzato dalla classe  InOutGenerate del core)*



6)Dopo aver completato l'Ordine di Distribuzione possiamo adesso  generare il "Documento di Trasporto - Magazzino" (Inventory Move).  Andiamo nel processo Generate Movement e creiamo il nostro DDT. Settare  il Magazzino Centrale nel Warehouse.

![ODD5.png](/image/DistributionOrder-ODD5.png)



7) Bene, in nostro Documento di Trasporto-Magazzino (Inventory Move) è stato generato. Completiamo

![ODD7.png](/image/DistributionOrder-ODD7.png)


8) Se adesso andiamo nelle transazioni del nostro prodotto "Havana"  possiamo vedere lo spostamento che è stato effettuato da un magazzino  all'altro

![ODD6.png](/image/DistributionOrder-ODD6.png)

---

## Info Window - Generate Movement Inventory Move

Abbiamo Aggiunto al Plugin di Libero Manufacturing una Info Window che Genera Movimenti(DDT-Magazzino)

In questa Info Window possiamo selezionare gli Ordini di  Distribuzione Completati e che si possono movimentare (a differenza del  processo Generate Movement precedentemente descritto che lo fa per tutti  gli ordini di Distribuzione del Magazzino Selezionato)

![ODD8.png](/image/DistributionOrder-ODD8.png)



---
title: "Conto Lavoro Passivo"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 50
pre: "<b>10.3. </b>"
---

[![ContoLavoro.png](http://192.168.178.102/images/thumb/3/36/ContoLavoro.png/600px-ContoLavoro.png)](http://192.168.178.102/index.php/File:ContoLavoro.png) Un Ordine di Conto Lavoro puo essere :

```
- inserito manulmente 
- generato dall'MRP
```

<http://www.wizardsrl.it/images/stories/Documenti/AdHocRevolution/Moduli/Conto_Lavoro.pdf>

Funzionalità richieste wishing : conto lavoro: riferimento DDT invio merce

Situazione :

Prodotto con BOM

```
F001 FINITO   (BOM)INTERNO/ESTERNO
- C001 COMPONENTE01    QTA 5
- C002 COMPONENTE02    QTA 1
- C003 COMPONENTE03    QTA 1
-- C004 COMPONENTE04   QTA 1
-- C005 COMPONENTE05   QTA 2
```

CICLO : MONTAGGIO


 L'Ordine di Conto Lavoro

Inserendo il prodotto F001 Come Acquisto

```
- inviare i componenti al Fornitore .
- ricevere il prodotto finito
- registrare la fatture fornitore per la lavorazione (MONTAGGIO)
```

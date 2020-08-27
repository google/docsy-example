---
title: "Richiesta / Ticket "
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 200
pre: "<b></b>"
---
---



## Richesta / Ticket [TIK00]
[{{< figure src="/image/TicketTIK00.png"  width="850"  >}}](/image/TicketTIK00.png)
## Richiesta Tutto [RICT00]
[{{< figure src="/image/RichiestaTutto0.png"  width="850"  >}}](/image/RichiestaTutto0.png)
## Risoluzione Richiesta [RR01]
[{{< figure src="/image/RisoluzioneRichiesta0.png"  width="850"  >}}](/image/RisoluzioneRichiesta0.png)
## Risposta Standard Richiesta [RSR00]
[{{< figure src="/image/RispostaStandardRichiesta0.png"  width="850"  >}}](/image/RispostaStandardRichiesta0.png)
## Riaprire Richiesta [RR03]
[{{< figure src="/image/RiaprireRichiestaRR03.png"  width="850"  >}}](/image/RiaprireRichiestaRR03.png)
##  Fattura per richiesta [FR00]
[{{< figure src="/image/FatturaRichiestaFR00.png"  width="850"  >}}](/image/FatturaRichiestaFR00.png)

## REQUEST (ALL) - RICHIESTE

```
Visualizza e lavora su tutte le richieste
Questa window "Request (All)" viene utilizzata per visualizzare tutte le richieste disponibili.
La scheda Richiesta definisce qualsiasi richiesta inviata da un Business Partner o internamente.
```

Le richieste sono differenti dalle email

```
- Le email sono private e informative (alcune azioni)
- Le richieste sono pubbliche e oriente all’azione
```

---

## Settaggi Iniziali

Per gestire le richieste è fondamentale inserire i dati Host, Smtp, ecc... nella window "Client" (mittente della mail)

![image](/image/Request4.png)

Vediamo altre informazioni che devono essere necessarie per l'invio della mail (destinatario della mail/notifica)

![image](/image/Request8.png)

## Creazione delle Request

```
1) Creare una Richiesta dalla window "Richiesta" (Request)
2) Creare una Richiesta da quasi documento (es:Sales Order, Purchase Order, Resource 	   	  Attendance,.....)
```


![image](/image/Request1.png)


Creiamo la Richiesta legata a questo Ordine di Vendita e vediamo tutte le informazioni:

![image](/image/Request2.png)


Vediamo adesso la maschera "Tipo di Richiesta"

![image](/image/Request6.png)


Dopo aver creato la Request possiamo vedere che c’è una richiesta aperta legata a quest’ordine

![image](/image/Request5.png)

## Fatturazione delle Request

Andiamo adesso a Fatturare le Richieste.
Per poter fatturare le richieste è importante che:

```
- il login avvenga con organizzazione ≠ * (la fattura viene creata con Organizzazione con   cui accediamo e non può essere *)
- la Richiesta (Request) abbia il flag impostato su Fatturato='Y'
- il Tipo di Richiesta associato alla Richiesta da Fatturare abbia il flag impostato su     Fatturato='Y'
- lo stato della Richiesta sia "CLOSED"
- le righe della richiesta (Tab Aggiornamenti) abbia una o più righe con Quantità           Fatturata ≠ 0
```

Da menuù andiamo nel Processo "Fattura per Richieste" ed inseriamo i dati che ci interessano (unico dato obbligatorio è Tipo Richiesta)

![image](/image/Request7.png)

Dopo aver completato la nostra fattura è stata generata con successo

![image](/image/Request3.png)

# Setup Richiesta
## Configurazione richieste
[{{< figure src="/image/ConfigurazioneRichieste.png"  width="850"  >}}](/image/ConfigurazioneRichieste.png)
## Tipo Richiesta [TR01]
[{{< figure src="/image/TipoRichiesta0.png"  width="850"  >}}](/image/TipoRichiesta0.png)
## Gruppo Richiesta [GR00]
[{{< figure src="/image/GruppoRichiesta0.png"  width="850"  >}}](/image/GruppoRichiesta0.png)
## Categoria Richiesta [CR00]
[{{< figure src="/image/CategoriaRichiesta0.png"  width="850"  >}}](/image/CategoriaRichiesta0.png)
## Stato Richiesta [SR00]
[{{< figure src="/image/StatoRichiesta0.png"  width="850"  >}}](/image/StatoRichiesta0.png)






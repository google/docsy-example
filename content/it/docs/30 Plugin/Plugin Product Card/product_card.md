# Plugin: Product Card

---

## SEND MAIL

---

## Riferimenti

```
http://www.benchmarkemail.com/it/resources/Free-HTML-Email-Templates
```

- link pubblico  :
- link idempeire italia  :
- link jar  :
- versione idempiere  : idempiere 4.1
- versione zk supportata : zk8

---

## Descrizione Plugin

I processi di questo plug-in permettono la gestione di sottoscrizioni di utenti su determinate aree di interesse e il successivo invio della mail.


Installare nella console felix il jar reperibile su [idempiere-download](https://bitbucket.org/consulnet/idempiere-download)

**Nome plug-in:** *it.cnet.impl.LIT_SendMail.jar*

---

## TO DO

```
(vedi chat Telegram idempiere consulting --> 3 gennaio 2017)
Plug_in Send Mail:
1) Togliere il Processo Jasper come obbligatorio (da window Send Mail Parameter
2) IL processo prende il path del Report (errato) —> attachment:jasperxxxx.jasper
```

---

## Parametrizzazione Plugin

Per far funzionare i processi del plug-in, bisogna, come base, settare alcuni dati principali:

1. Creare un tipo di contatto nella maschera ***LIT Tables***, per raggruppare tipi di utenti per una determinata area di interesse
   [![SendMail 1.png](http://192.168.178.102/images/thumb/2/21/SendMail_1.png/880px-SendMail_1.png)](http://192.168.178.102/index.php/File:SendMail_1.png)

2. Settare il tipo contatto agli utenti (Users) di un determinato Bussiness Partner; inoltre verificare che gli utenti abbiano l'Email Address valorizzato
   [![SendMail 2.png](http://192.168.178.102/images/thumb/5/5a/SendMail_2.png/880px-SendMail_2.png)](http://192.168.178.102/index.php/File:SendMail_2.png)

3. Creare una determinata Interest Area per l'invio mail ed Associarla ad ogni utente che si vuole:

   1. definizione di un'area d'interesse (Interest Area)
      [![SendMail 3.png](http://192.168.178.102/images/thumb/0/0c/SendMail_3.png/880px-SendMail_3.png)](http://192.168.178.102/index.php/File:SendMail_3.png)
   2. associazione dell'area d'interesse all'utente
      [![SendMail 4.png](http://192.168.178.102/images/thumb/1/19/SendMail_4.png/880px-SendMail_4.png)](http://192.168.178.102/index.php/File:SendMail_4.png)

4. Molto IMPORTANTE è la maschera

    

   **Send Email Parameter**

   : in questa maschera c'è la parametrizzazione per il corretto funzionamento del plug-in.

   ![SendMail 5.png](http://192.168.178.102/images/thumb/b/bb/SendMail_5.png/880px-SendMail_5.png)

   - ***Table***: nome della tabella da dove reperire il record da stampare sul report
   - ***Column***: principalmente il campo dove reperire i contatti/utenti da registrare nell'Interest Area
   - ***Interest Area***:
   - ***Process***: il jasper report da allegare alla mail
   - ***Contact Type Group***: il tipo contatto da reperire per l'invio mail
   - ***Sales Lead***: se c'è il flag, significa che va a recuperare tutti i contatti/user, indipendentemente se sono associati ad un bpartner o no

5. POIIIII

---

## Istruzioni Plugin

Il Send Mail è suddiviso in 2 fasi:

1. (Processo 1) ***Append mail***: reperire tutti i contatti/users di una determinata Interest Area e associarli ad Interest Area di destinazione invio mail; per fare questo, bisogna creare delle InfoWindow basate su tabelle che si vogliono utilizzare per l'invio delle mail.

[![SendMail 6.png](http://192.168.178.102/images/thumb/6/65/SendMail_6.png/880px-SendMail_6.png)](http://192.168.178.102/index.php/File:SendMail_6.png)
IMPORTANTE: nel SQL From mettere il giusto ID del ContactTypeGroup... (TODO....)

[![SendMail 7.png](http://192.168.178.102/images/thumb/8/87/SendMail_7.png/880px-SendMail_7.png)](http://192.168.178.102/index.php/File:SendMail_7.png)

1. (Processo 2) ***Send mail***: una volta raccolti i contatti che servono, c'è l'invio vero e proprio della mail: costituisce una mail la composizione di un Mail Template + l'invio di un report PDF

---

## Estensione ALERT

In questo plugin è stata aggiunta un estensione agli ALert, ovvero l'invio degli alert in base anche agli userID dichiarati nella SELECT dell'AlertRule

Nella window Alert --> inserire un filtro di invio nell' "Alert Recipient" (Aggiunto campo "User SQL Field") che prenda ad esempio non solo degli utenti fissi ma Sales Representative degli Ordini completati (dichiarati nella SELECT dell'Alert Rule)

Vediamo un esempio:

[![Alert6.png](http://192.168.178.102/images/thumb/4/47/Alert6.png/1100px-Alert6.png)](http://192.168.178.102/index.php/File:Alert6.png)
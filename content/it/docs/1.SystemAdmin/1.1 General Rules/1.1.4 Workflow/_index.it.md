---
title: "Workflow"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 30
pre: "<b>1.1.4 </b>"
---


1 SystemAdmin WorkFlow Video Approvazione Documento V102  https://youtu.be/RBuE-4Tk51U

# **Approvazione Documento**


### ***ESEMPIO APPROVAZIONE DOCUMENTO DI UN UTENTE RESPONSABILE (es ANDREA)***

*Entrare a Livello Client (GardenWorld):*

Andare nella window "**Role**" --> GardenWorld Admin e flaggare  il campo "Approve own Documents" per consentire l'approvazione  dell'Utente (oppure Organization,ecc....)

![ApproveDocuments.png](/image/Workflow-ApproveDocuments.png)
Successivamente entro nella window "**User**" e creo i seguenti utenti:

```
Andrea 
     Business Partner: GardenAdmin BP (importante impostare questo campo per consentire che l'aprovazione venga fatta da questo utente) 
     Tab "User Roles": GardenWorld Admin
Paolo
Luca
.....
```

Entriamo nella maschera "**Workflow Responsible**" ed aggingiamo l'utente "Andrea"- Vedi immagine successiva:

![ApproveDocuments4.png](/image/Workflow-ApproveDocuments4.png)

Adesso, sempre a livello Client, vado sul Workflow "**Process Order**" ed inserisco il Nodo "DocApprove":

![ApproveDocuments1.png](/image/Workflow-ApproveDocuments1.png)

Abbiamo impostato i seguenti campi:

```
Workflow Responsable: Andrea
Action: User Choice
Column:IsApproved
```

Andiamo nella Tab "**Transition**" ed aggiungiamo il "Next Node"--> Doc Complete

![ApproveDocuments2.png](/image/Workflow-ApproveDocuments2.png)

Andiamo nel Nodo "(DocPrepare)" ed aggiungiamo nella Tab "Transition"  il "Next Node" --> DocApprove (oltre al (DocComplete) già presente  di default). Vedi immagine successiva:

![ApproveDocuments3.png](/image/Workflow-ApproveDocuments3.png)

### **TEST**

Bene, adesso possiamo testare il tutto.

Login come "Luca" (oppure un altro utente, che non sia Andrea) ed andiamo nella Window "Sales Order".

Completando l'ordine (pulsante Document Action), andrà in uno stato  di "Suspended" (quindi il documento deve essere approvato dall'utente  Andrea)

Quindi Login con l'utente "Andrea" ed accediamo alla window "**Workflow Activities**":

![ApproveDocuments5.png](/image/Workflow-ApproveDocuments5.png)

Qui possiamo vedere la nostra lista di Documenti che solo l'utente  Andrea potrà approvare. ATTENZIONE: nel campo "Answer" possiamo  selezionare Si o No. Che cosa significa questo? Se premiamo su "Si" il  nostro Ordine verrà completato, se premiamo "No" lo riporteremo in uno  stato "Void" (successivamente potremo completarlo nuovamente accedendo  direttamente dal documento)

![ApproveDocuments6.png](/image/Workflow-ApproveDocuments6.png)

# **EMail Workflow**

---

### ***ESEMPIO NOTIFICA EMAIL DOPO COMPLETAMENTO ORDINE***

*Entrare a Livello Client*

```
Come prima cosa dobbiamo impostare l'indirizzo Mail del Client. Quindi entrare nella maschera "Client" ed impostare i paramenti per la EMail (premere il pulsante Test Email)
```

Impostiamo il Workflow Email:

```
-andare nella maschera "Workflow" e ricercare "Process_Order"
-accedere alla Tab "Node" e creare un nuovo Record (es. Send Mail) che abbia il campo Action --> EMail

```

Settiamo il campo Email Recipient (coloro a cui arriverà la mail). Ad esempio impostando:

```
-"Document Business Partner" --> al completamento dell'ordine il Business Partner riceverà la mail di ordine confermato 
 (ricordarsi di impostare un indirizzo  Emai valido all'interno della maschera Business Partner, Tab Contact(User)).  
-"Document Owner" --> sarà il proprietario del documento a ricevere l'ordine, ovverò il "Sales Rapresentative"((ricordarsi di impostare un indirizzo Emai valido all'interno della maschera User)
-"WF Responsible" --> agli utenti responsabili, oppure organizzazione, ecc... che sono stati indicati nel campo "Workflow Responsable"
-Se non selezioniamo nessuno dei 3 campi elencati nella "EMail Recipient" possiamo inserire direttamente un indirizzo nel campo a dx "EMail Address"
 Solo questo utente riceverà una Email ad ogni completamento di un qualsiasi ordine.
-il campo Mail Template è obbligatorio. Possiamo creare un Template della ricezione mail. Vediamo un 'esempio:

```

Dopo aver creato il nostro Nodo "Send Mail", per far si che funzioni, dobbiamo collegarlo al nodo "DocComplete".

```
Entrare nel Nodo "DocComplete" --> Tab "Transition" ed impostare il campo "Next Node": Send Mail (Possiamo fare anche questo dall'editor grafico presente nella maschera "Workflow Editor")

```

Adesso possiamo creare un nuovo ordine (di acquisto o di vendita). Al  completamento di esso sarà inviata la mail di "Ordine Completato" al  destinatario desiderato

IL destinatario riceve la mail con il messaggio e in allegato il  Report. Per far si che si visualizzi il report nostro (Report NON  Standard del sistema) dobbiamo cambiare le impostazioni nella maschera  "Print Form"

### ***IMOSTAZIONE REPORT (PRINT FORM)***

Entrare nella maschera "Print Form" (a livello Client o a Livello  System in base alle preferenze) e impostare ad esempio il campo "Order  Print Format" con un nuovo Record che abbia il nostro Report. Esso è  importante che abbia il riferimento al Nostro Processo Jasper. Vediamo  qui sotto l'esempio:

![PrintFormat.png](/image/Workflow-PrintFormat.png)

Adesso come allegato mail vedremo il nostro Report

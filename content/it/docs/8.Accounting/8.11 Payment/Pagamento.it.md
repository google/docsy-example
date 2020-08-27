 ---
title: "Pagamento"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 811
pre: "<b>8.11 </b>"
---

8 Accounting Report PagamentiNon AbbinatiR 63+Abbinamento V069  https://youtu.be/DVxs2IVnSmM

8  Accounting Pagamenti Annullamento Abbinamento Pagamento Fattura V064 https://youtu.be/D7alY4Eq3NM

8 Accounting Pagamento Misto persa ultima parte https://youtu.be/5VJfa2UajLA

8 Accounting Pagamento Fattura Fornitore da Fattura V062 https://youtu.be/4xrEL5krZtk

8 Accounting Pagamento Panoramica Generale su RIBA con Insoluto e successiva modifica Modalità di Pa  https://youtu.be/2ltW9ncZqQM

# Pagamenti e Incassi

---

## GESTIONE BANCHE

Nel sistema Idempiere è possibil ecaricare le proprie banche e le banche dei BP WINDOW : Bank / Cash

Deve essere possibile inserire sia banca del cliente/fornitore che la ns banca di appoggio.

Metodi Di pagamento previsti da iDempiere

Reference : _PaymentRule

```
B - Cash              - Rimessa diretta  (Cliente / Fornitore ) [esegue anche pagamento diretto dalla maschera fattura]
    WPaymentFormCash
D - Direct Debit      - RIBA             (Cliente / Fornitore )  
    Non esegue pagamento da fattura - utilizzare il Prepara Pagementi/Payment Schedule ) e Info RIBA
    WPaymentFormDirect
P - On Credit         - A credito - 
    non esegue nessun tipo di pagamento  [se Cash risulta avere problemi negli scadenziari utilizzare on credit e abbinare maschera per pagam
    nto da fattura )
    WPaymentFormOnCredit
S - Check             - Assegno - [richiede nr conto a abi + nr assegno [accetta tutti i numeri]
    WPaymentFormCheck
T - Direct Deposit    - Bonifico  (Cliente / Fornitore) 
    WPaymentFormDirect
M - Mixed POS Payment - Misto
C - Credit Card       - Carta di Credito (Entrambi)
[
01 Contrassegno  Assimilabile a Rimessa diretta 
02 Paypal        Assimilabile a Rimessa diretta 
03 PostePay      Assimilabile a Rimessa diretta 
]   dal 01 al 09 sono tutti Rimessa Diretta cioe apro la masche WpaymentformStandard
```

```
Per gestire l'apertura delle corrispettive maschere di pagamento personalizzate, verrà letto il campo 
"Note" della tabella AD_Ref_List del record corrispondente al paymentRule scelto in maschera: se è presente la  dichiarazione della classe java form-pagamento personalizzata, viene letto in modo dinamico la classe 
dal plug-in e verrà aperta a video, altrimenti verrà aperta la form standard del core di iDempiere.
```

```
[
11 RID           
]   da 11 al 19  non esegue pagamento ??- sara abbinato dal caricamento dei movimenti di banca  
```

### A) CLIENTI

```
Un Cliente puo avere diversi metodi di pagamento :
I.) BONIFICO  -  Nel caso di un bonifico devo specificare la banca propria preferita  
nella scheda Bank account
selezione account usate = direct deposit 
selezione la mia banca    (NELLA INFO BANK vedo anche le altre banche )
II.) RIBA  devo selezionare la sua banca (è sufficiente l’abi e il cab)
```

### B) FORNITORI

```
I. ) BONIFICO - devo inserire la sua banca  completa di IBAN (abi+cc) 
II) nel caso di RIBA devo inserire la mia banca 
```


CONSIDERAZIONI

```
Dopo qualche test si vede che in Idempiere è possibile inserire sia la propria banca sia la banca del BP senza nessun legame con il metodo di    
pagamento.  
Per un cliente e per un fornitore sembrerebbe anche accettabile
Se un BP è sia Cliente sia Fornitore  avremo il limite che sarà possibile specificare un solo metodo di pagamento + termine  sia per ciclo 
attivo che per quello passivo.   (E’ un problema ????? )
Controlli non presenti che si potrebbero integrar
e :
- CLIENTE che ha bonifico è non e stata specifica la ns banca/conto
- CLIENTE cha ha RIBA e non è stato specificata la sua banca
- FORNITORE CON BONIFICO che non ha “la riga del conto correnti in Bank cash
```

```
TEST PRATICO OPERATIVO 
Fattura di Vendita a Cliente Ormet
a) il cliente ormet ha i seguenti metodi di pagamento bonifico 30 gg fm 
b) tipo documento  Fattura (invoice indirect ) 
campo modalita di pagamento : TOGLIERE la dinamic validation che impedisce la visualizzazione in alcuni casi dei termini di pagamento 
Metodi di pagamento  ad_reference=195
```

MAD : MODIFICA APPLICATION DICTIONARY WINDOW : Invoice Customer Logica di visualizzazione (valore originale) : @PaymentRule@='P' | @PaymentRule@='D' Logica di visuazlizzazione (nuovo valore ) ; @PaymentRule@!'S' & @PaymentRule@!'K' |


[![Payment .png](Payment.png)](Paymentpng)

---
title: "Business Partner"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 180
pre: "<b> </b>"
---
## Business Partner [BP00]
[{{< figure src="/image/BusinessPartnerBP00.png"  width="850"  >}}](/image/BusinessPartnerBP00.png)
## Lettera Intento Cliente/Fornitore [LI16]
[{{< figure src="/image/LetteraIntentoClienteFornitore0.png"  width="850"  >}}](/image/LetteraIntentoClienteFornitore0.png)
## Relazione tra Partner [RTP00]
[{{< figure src="/image/RelazioneTraPartner0.png"  width="850"  >}}](/image/RelazioneTraPartner0.png)
## Termini di Pagamento [TP01]
[{{< figure src="/image/TerminiPagamentoTP00.png"  width="850"  >}}](/image/TerminiPagamentoTP00.png)
## Riconoscimento Ricavo [RR00]
[{{< figure src="/image/RiconoscimentoRicavo0.png"  width="850"  >}}](/image/RiconoscimentoRicavo0.png)

# Report Business Partner
## Report Lettera Informazioni Bancarie [RP.311]
[{{< figure src="/image/InformazioniBancarieRP311.png"  width="850"  >}}](/image/InformazioniBancarieRP311.png)
## Report Importo Aperto Business Partner [R.03]
[{{< figure src="/image/ImportoApertoBusinessPartnerR03.png"  width="850"  >}}](/image/ImportoApertoBusinessPartnerR03.png)
## Report Dettagli Business Partner [R.02]
[{{< figure src="/image/DettagliBusinessPartnerR02.png"  width="850"  >}}](/image/DettagliBusinessPartnerR02.png)
## Report Lettera Informazioni Bancarie [RP.311]
[{{< figure src="/image/LetteraInformazioniBancarieRP311.png"  width="850"  >}}](/image/LetteraInformazioniBancarieRP311.png)

# Setup Business Partner
## Gruppo Business Partner [BPG00]
[{{< figure src="/image/GruppoBP0.png"  width="850"  >}}](/image/GruppoBP0.png)
## Categoria BP [CBP01]
[{{< figure src="/image/CategoriaBP0.png"  width="850"  >}}](/image/CategoriaBP0.png)
## Configura e verifica l'organizzazione dei Business Partner [OBP00]
[{{< figure src="/image/OrganizzazioneBP_OBP00.png"  width="850"  >}}](/image/OrganizzazioneBP_OBP00.png)
## Scollega Business Partner da organizzazione [SBPO00]
[{{< figure src="/image/ScollegaBusinessPartnerSBPO00.png"  width="850"  >}}](/image/ScollegaBusinessPartnerSBPO00.png)

## Pianificazione Fatturazione [PF00]
[{{< figure src="/image/PianificazioneFatturazione0.png"  width="850"  >}}](/image/PianificazioneFatturazione0.png)
## Termini della Fattura [TDF12]
[{{< figure src="/image/TerminiDellaFattura0.png"  width="850"  >}}](/image/TerminiDellaFattura0.png)
## Periodo di Pagamento Escluso [PDPE00] 
[{{< figure src="/image/PeriodoPagamentoEscluso0.png"  width="850"  >}}](/image/PeriodoPagamentoEscluso0.png)

# Setup Contatti
## Categoria Posizione [CP01]
[{{< figure src="/image/CategoriaPosizione0.png"  width="850"  >}}](/image/CategoriaPosizione0.png)
## Titolo e Qualifica [TQ01]
[{{< figure src="/image/TitoloQualifica0.png"  width="850"  >}}](/image/TitoloQualifica0.png)
## Posizione e Contatto [POS00]
La maschera server per gestire le posizione lavorative.
[{{< figure src="/image/Position1.png"  width="850"  >}}](/image/Position1.png)

# Controlli Business Partner
## Valida e aggiorna saldi Business Partner [VASB00]
[{{< figure src="/image/ValidaAggiornaSaldiBusinessPartnerVASB00.png"  width="850"  >}}](/image/ValidaAggiornaSaldiBusinessPartnerVASB00.png)
## Informazione P.IVA Business Partner [BPPI14]
[{{< figure src="/image/InformazioneP.IVABP0.png"  width="850"  >}}](/image/InformazioneP.IVABP0.png)
## Informazione C.F Business Partner [BPCF14]
[{{< figure src="/image/InformazioneC.FBP0.png"  width="850"  >}}](/image/InformazioneC.FBP0.png)
## Controllo e/o aggiornamento P.IVA [CPI14]
[{{< figure src="/image/ContrAggPIVA_CPI14.png"  width="850"  >}}](/image/ContrAggPIVA_CPI14.png)


## "Stato del Credito"

#La gestione del Limite di credito non è attiva se lo stato del credito è: No Credit Check (Nessun Controllo Credito), Credit Stop(Credito al Limite)  o se il limite di credito è 0.

Il limite di credito indica l'importo totale consentito "in conto" nella valuta contabile principale. Se il limite di credito è 0, non viene eseguito alcun controllo (significa che è impostato su illimitato). La gestione del credito si basa sull'ammontare totale aperto, che include le attività del fornitore.

Lo stato del credito viene impostato automaticamente su Credit Hold (Credito Sospeso) se il Saldo Aperto (comprese le attività del fornitore) è superiore al Limite di credito.
È impostato su Credit Watch (Credito sotto Attenzione) se superiore al 90% del limite di credito e Credit OK (Credito Verificato) altrimenti.



Vediamo i 5 tipi di Stato del Credito:         

-  Credit Hold (Credito Sospeso)  --> il sistema imposta Credit Hold: il sistema lo cancellerà quando il BP tornerà in buono stato.
-  Credit Stop (Credito al Limite) --> Gli utenti impostano Credit Stop: il sistema non si cancellerà quando il BP tornerà in buono stato.
-  Credit OK (Credito Verificato)
-  Credit Watch (Credito sotto Attenzione) --> il sistema calcola in base al rapporto di credito del Gruppo BP. Il sistema si cancellerà quando il BP tornerà in buono stato.
-  No Credit Check (Nessun Controllo Credito) --> non viene utilizzata la gestione del credito dal sistema.

## Video Business Partener
### Video - Basic Data - Business Partner / Business Partner Dati di base [V133]
{{<youtube RW2FLh5Ug-k>}}

### Video - Basic Data - Business Partner Private / Crea Business Partner   Privato [V143]
{{<youtube KTAMXr0x3rk>}}

### Video - Basic Data - Business Partner Bank / Crea banca del Business Partner [V136]
{{<youtube lNruAgIZjAQ>}}

### Video - BasicData Business Partner Dati Base 2 [V134]
{{<youtube bbCyXv4nw-U>}}

### Video - BasicData Gruppo Business Partner [V137]
{{<youtube p54E_B4XUdo>}}

### Video - BasicData Creare business partner   veloce [V112]
{{<youtube eLywUq0pNRg>}}

### Video - Basic Data - Business Partner  / Business Partner Stato del Credito [V138]
{{<youtube Mu46ayW42e4>}}

## Video Business Partner Rappresentante

### Video - Basic Data - Business Partner / Business partner rappresentante [V160]
{{<youtube nk3wvNJW3rQ>}}

### Video - BasicData Business partner rappresentante [V088]
{{<youtube OGhb-AYWJZs>}}

## Video Controllo Business Partner
### Video - BasicData - Process control VAT / Processo Controllo Partita Iva [V027]
{{<youtube C7wc5HcsEhg>}}


## Descrizione Plugin

```
http://www.soldioggi.it/come-funziona-la-dichiarazione-di-intento-6524.html
http://www.anteprime.ilsole24ore.com/Articolo/esportatori-abituali-dichiarazioni-d-intento
```

---

## Funzionalità supportate

---

## Installazione Plugin

Installare nella console felix il jar reperibile su [idempiere-download](https://bitbucket.org/consulnet/idempiere-download)

---

## Parametrizzazione Plugin

---

## Istruzioni Plugin

![LetterIntent 1.png](/image/LetteraIntento_1.png)

Il processo si avvia al momento che viene completata la fattura, cioè all’azione sul pulsante “Document Action -- Complete...”

![LetterIntent 2.png](/image/LetteraIntento_2.png)

Il processo della gestione delle lettere d’intento:

- va a ricercare nella tabella C_BP_Partner_LetterIntent (maschera Business Partner Letter Intent) se è presente una lettera d’intento inerente al Business Partener impostato su fattura; la ricerca si basa su:
  - *Business Partner (c_bpartener_id);*
  - *Data di validità: se la data di fattura è compresa nelle date di validità lettere d’intento;*
  - *se impostato su fattura, per ordine di vendita (c_order_id)*



- Una volta trovata la lettera d’intento corrispondente, si ricerca la tassa di esenzione, tramite la seguente query:

> ```
> final String sql = "SELECT t.C_Tax_ID "<br />
>                 + "FROM C_Tax t"<br />
>                 + " INNER JOIN AD_Org o ON (t.AD_Client_ID=o.AD_Client_ID) "<br />
>                 + "WHERE t.IsTaxExempt='Y' AND o.AD_Org_ID=? "<br />
>                 + "ORDER BY t.Rate DESC";<br />
> int C_Tax_ID = DB.getSQLValueEx(trxName, sql, AD_Org_ID);
> ```



![LetterIntent 3.png.png](/image//LetteraIntento_3.png.png)

Una volta completata la fattura, il totale viene conteggiato senza tasse e il ‘residual amount’ sulla maschera “Business Partner Letter Intent” viene aggiornato….

### Classi java utilizzate

- `it.cnet.idempiere.lettIntent.model.EventHandler_cnet`
- `it.cnet.idempiere.lettIntent.model.MBPLetterIntent`
- `it.cnet.idempiere.lettIntent.model.Invoice_ExemptTax`

---

### Modifiche DB

- *Table* - C_Invoice

  *Column* - C_BP_Partner_LetterIntent_ID

---

## IMPORTANTE

Prima di rigenerare un nuovo packout per questo plug-in, è importante settare:

maschera "**TABLE AND COLUMN**" - tabella "**C_BP_Partner_LetterIntent**"

colonna "*bp_letterintent_c_order_id*" --> settare campo **Reference Key** a **NULL**, questo perché crea una problematica di costraint su DB alla prima installazione del plug-in.

Il dato verrà poi inserito tramite riga di packout, in questo modo:

> UPDATE AD_Column
> SET AD_Reference_Value_ID = 290
> WHERE AD_Column_UU='0c42d2b2-1655-4676-81ab-d77903d465bd'

(AD_Reference_Value_ID = 290 [Reference Key 'C_Order'])

---

## Documentazione Tecnica Plugin

<https://drive.google.com/open?id=0B3alx2W3koD6WDdaa1U4aDk5TlU>

### Modifiche all'AD

```
-----------
| nomeSup |
-----------------------------
| nome | tipo | descrizione | 
-----------------------------
```

#### Tables / Windows esistenti

#### Nuove Tables /Windows

---

## Funzionalità Future

---

## Errori e bug

---

## "Termini di Pagamento [TP01]"
---

## Riferimenti 1

- link pubblico  : non applicabile
- link idempeire italia  : <https://bitbucket.org/consulnet/idempiere-ita-plugin>
- link jar  : /opt/repos/idempiere-italia-plugin/it.cnet.impl.payment_term/
- versione idempiere  : idempiere 4.1
- versione zk supportata : na

---

## Descrizione Plugin

![PaymentTerm 1.png](/image/PaymentTerm_1.png)

I termini di pagamento vengono gestiti tramite una determina  schedulazione dei giorni nella sottotab “Schedule” della Window “Payment  Term”. In aggiunta alla schedulazione standard presente, vi è la  possibilità di aggiungere un giorno fisso (Fixed Date) come termine di  pagamento.

- ~~È stata creata un classe java specifica per la gestione dei termini di pagamento~~



  ~~*it.cnet.idempiere.payTerm.model.MPaymentTerm_cnet.java*  Questa classe viene invocata al momento del “Document Action”  > “Prepare”, pulsante di processo presente nelle window “Sales Order”  e “Invoice(...)” e al salvataggio del record relativo all’ordine e  della fattura. N.B: il calcolo dei PaymentTerm su gli ordini è funzionante solo se  nella window “Payment Term” è flaggato il campo ‘After Order’;  altrimenti, prende in considerazione quello di default di iDempiere.  ~~


 [28/07/2017] Modificata direttamente la classe core di iDempiere:  MPaymentTerm.java.(vedi commenti messi come 'idempiereConsulting...); la  modifica riguarda



![PaymentTerm 2.png](/image/PaymentTerm_2.png)

Una volta eseguito il processo di “Prepare”, la sottotab “Payment Schedule” viene aggiornata.


 CAMPO DI APPLICAZIONE :

Documenti /Window dove applicabile : - Ordine di vendita - Fattura di vendita - Ordine di acquisto - Fattura di acquisto


 Data di partenza dl calcolo (alternative )

Data ordine (acquisto /vendita) IF afterorder=true Data fattura IF  afterdelivery=false and afterorder=False Data consegna (After delivery)  IF afterdelivery=true

PROCEDURA Da Ordine di Vendita Se il termine è da data consegna (  After delivery =true ) oppure se il terminde è data data fattura (  afterorder =false ) NEW FIELD

```
   non calcolo niente- non creao nessuna riga di payschedule
```

else (è da data ordine ) afterorder=true NON E’ PREVISTO IN ID

```
  procedo e calcolo le scadenze
```

end

PROCEDURA da Fattura Se il termine è già calcolato (ho delle righe in payschedule )

```
  lasciamo cosi   ( Da verificare marco )
```

se il termine è da data ordine afterorder=true or data fattura (asfterorder=false and

```
  afterdeliveru=false )
 procedo e calcolo con riferimento data FATTURA  (PREVISTO INID )
```

se il termine è da data consegna

```
procedo e calco con riferimento dta consegna    (PREVISTO IN ID )
```

end


 Opzioni da gestire (non gestite in idempiere ) - pagamento fine mese

30 giorni FM = Impostazione : Mese 1 oppure Netdays (30 ) (alternativi )

```
           Calcolo :  aggiungo 1 mese oppure 30 giorni +
                   calcolo fine mese
                            
```

30 giorni FM al 10 successivo =

```
                       Impostazione : Mese 1 oppure Netdays (30  ) (alternativi ) + fixeddate =10
```

Calcolo : aggiungo 1 mese oppure 30 giorni +

```
                                       calcolo fine mese +
              imposto il giorno fixeddate e se minore della data calcolate aggiungo un mese
```


 \- mesi esclusi

Esempi  :

10 giorni dall’ordine (da data ordine) 10 giorni da data fattura 10 giorni da data consegna

30 gg FM (fine mese) DF (data fattura

30/60 gg DC (data consegna ) FM

Metodi di Pagamento / Reference _PaymentRule

```
B - Cash              - Contanti         (Cliente)
D - Direct Debit      - RIBA             (Entrambi)
C - Credit Card       - Carta di Credito (Entrambi)
M - Mixed POS Payment - Misto
P - On Credit         - Diff
S - Check             - Ch
T - Direct Deposit    -
```

---

## Documentazione Tecnica Plugin

1) Creazione classe di taxProvider: it.cnet.impl.payment_term.tax.DefaultTaxProvider
 Modifiche apportate = vedi nota ***IDITA__paymentTerm_12/10/2015_01: custom calcolo tasse fattura con le withholding + reflection per classe MInvoiceTax __###***



**modificaad**

```
ADD su Referemce : F - Bonifico Bancario 
```


 Fornitore :

```
PaymentRulePO :All_Payment Rule - no Cash : AD_Ref_List.Value <> 'B' AND AD_Ref_List.Value <> 'M'
```

**modificaad**

```
DELETE : AD_Ref_List.Value <> 'B' AND AD_Ref_List.Value <> 'M'
PaymentRule : Dynamic Validation : 'All_Payment Rule - No mixed' : AD_Ref_List.Value <> 'M'
```


 **modificaad** DELETE : 'All_Payment Rule - No mixed' : AD_Ref_List.Value <> 'M'

---

## PAYMENT RULE

```
it.cnet.idempiere.payTerm.webui.apps.form.WPaymentFormStandard
```

Agganciata questa classe alla Reference --> _Payment Rule :

```
Direct Deposit (Bonifico Bancario)
RID (RID)
Check (Assegno)
```

Aggiunta la classe nel campo Description, vedi esempio:

![PaymentRule.png](/image/PaymentRule.png)

Se entriamo nella windows Fattura di Vendita e clicchiamo  nell'iconcina presente nel campo --> Modalità di Pagamento: Bonifico  Bancario

![PaymentRule1.png](/image/PaymentRule1.png)
---

## Classi Java utilizzate

- `it.cnet.idempiere.payTerm.model.EventHandler_cnet.java`

---

## Modifiche all'AD

### Tables / Windows esistenti

```
 -----------------
 | C_PaySchedule |
 -------------------
 | nome column     | 
 -------------------
 | FixedDate       |
 -------------------
```

### Nuove Tables /Windows

---

## Funzionalità Future

---

### TO DO

Modificare le righe dei termini di pagamento come segue (Window/Tab “Schedule”)

```
  ...                  | Mese (netMonth) | Giorni Net(c'è) (days) | Giorno del pag |
 -----------------------------------------------------------------------------------
  30 gg                | 1               |                        | FM
 -----------------------------------------------------------------------------------
  45 gg                |                 | 45                     |
 -----------------------------------------------------------------------------------
  30 gg df al 10 ms    | 1               |                        | 10
 -----------------------------------------------------------------------------------
```

chiarimento : giorgno del pagamento . Esempio vale : 10 - Se il  giorno calcolato è 5 allora diventa 10 ma se il giorno calcolato è 20  allora è + 1 mese e 10 STEP 2 : IF cliente ha un periodo escluso AND  scadenza calcolata è all’interno del periodo escluo ALLORA  : nuova  scadenza = +1 mese  : giorno= specificato

C_BP_PaymentTerm_Excluded

c_bpartner_id , …. , datefrom ,dateto, Fixeddate

## Errori e bug

---




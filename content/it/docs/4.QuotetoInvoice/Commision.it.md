---
title: "Provvigioni"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 240
pre: "<b></b>"
---

## Provvigioni [PRV00]
[{{< figure src="/image/Commissioni0.png"  width="850"  >}}](/image/Commissioni0.png)
## Crea Provvigione [CPRV00]
[{{< figure src="/image/CreaProvvigione0.png"  width="850"  >}}](/image/CreaProvvigione0.png)
## Report dettagli provvigioni correnti [R.21]
[{{< figure src="/image/DettagliCommissoniCorrentiR21.png"  width="850"  >}}](/image/DettagliCommissoniCorrentiR21.png)
---

# Video - Provvigioni 
### Video - 4. Quote-to-Invoice - Commission Run / Generazione provvigioni [V156]
{{<youtube U4Su-hNXgnM>}}

### Video - 4. QuotetoInvoice Provvigioni impostazioni rappresentante di vendita [V164]
{{<youtube MyBXpeCkIcU>}}

### Video - 4. QuotetoInvoice Provvigioni  Impostazioni percentuali provvigionali categoria [V163]
{{<youtube Gd0VV0RKTtg>}}

### Video - 4. QuotetoInvoice Generazione provvigioni [V087]
{{<youtube 62rZGgbbOFk>}}

### Video - 4. QuotetoInvoice Generazione fattura provvigioni [V157]
{{<youtube UpbH-DoViSU>}}




## Provvigioni

3 BasicData Business partner rappresentante https://youtu.be/OGhb-AYWJZs
4 8 QuotetoInvoice Provvigioni impostazioni rappresentante di vendita  https://youtu.be/MyBXpeCkIcU
4 8 QuotetoInvoice Generazione fattura provvigioni https://youtu.be/UpbH-DoViSU
4 8 QuotetoInvoice Generazione provvigioni  https://youtu.be/62rZGgbbOFk
4 8 QuotetoInvoice Provvigioni  Impostazioni percentuali provvigionali categoria  https://youtu.be/Gd0VV0RKTtg
## Descrizione Plugin

---

```
TRADUZIONE 
Commissioni -> Provvigioni  PRO0
Msk Provvigioni :select su BP deve essere solo agenti (rappresentatnti)

Aggiunge 2 processi
CalCommForOrder - it.cnet.idempiere.commissions.process.CommissionCalcForOrder
CalcAllCommissions - it.cnet.idempiere.commissions.process.CalculateAllCommissions

COSA NEGATIVA : deve generare per ogni agente (???) ci vorrebbe un generara tutti gli agenti

FARE REPORT PROVVIGIONI a) revisione report con dettaglio prodotti  B) creare report con riepilogo Documento (no dettaglio prodotti)
```


 Plugin commissioni


![Provvigioni.png](/images/Commission.png)

![PluginCommisions Videata1.png](/image/Commision_1.png)]


## Funzionalità supportate

---

## Installazione Plugin

***

Installare nella console felix il jar reperibile su [idempiere-download](https://bitbucket.org/consulnet/idempiere-download)

## Parametrizzazione Plugin

---

![PluginCommisions Param.png](/image/Commision_Param.png)

## Istruzioni Plugin

---

## Documentazione Tecnica Plugin

***

### Modifiche all'AD

#### Tables / Windows esistenti

```
 ----------------------
 | C_CommissionDetail |
 ----------------------
 | nome column        | 
 ----------------------
 | AmnLineCommission  | 
 ----------------------
 | AmtMultiplier      | 
 ----------------------
 | AmtSubtract        |
 ----------------------
 | QtyMultiplier      |
 ----------------------
 | QtySubtractor      |  
 ----------------------
 -----------------------------------------
 | Commission Run TAB> Commission Detail |
 -----------------------------------------
 | nome campo          | 
 -----------------------
 | Multiplier Amount   | 
 -----------------------
 | Subtract Amount     | 
 -----------------------
 | Multiplier Quantity | 
 -----------------------
 | Subtract Quantity   | 
 -----------------------
 | Line Commission     | 
 -----------------------
 --------------------------------------
 | Sales Order TAB> Commission Detail |
 --------------------------------------
 | nome processo             | 
 -----------------------------
 | Calc All Commission       | 
 -----------------------------
 | Calc Commission for Order | 
 -----------------------------
```

## Provvigioni di vendita-enasarco 2018

indice

## [SetUp Agente 2018](#SetUp Agente 2018)

## [SetUp Agente 2019](#SetUp Agente 2019)

## [Procedura Calcolo Provvigioni](#Procedura Calcolo Provvigioni)

## [Indicazioni per il Setup Agenti](#Indicazioni per il Setup Agenti)



## SetUp Agente 2018

E' necessario procedere a :

a) inserire un rappresentante in anagrafica in maniera completa di modo che si agganci per creare la proforma della fattura che genererà il sistema e che verrà inviata al rappresentante stesso per ottenerne la sua definitiva eguale.

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_005.png)

sarà necessario inserire il contatto nei record di dettaglio:

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_006.png)

completando l'anagrafica correttamente con i dati a piena pagina:

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_007.png)

inserire anche indirizzo necessario per creazione proforma fattura da inoltrare eventualmente al rappresentante:

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_008.png) 

b) creare un tipo soggetto a ritenuta enasarco con ritenuta acconto 23% ad esempio (ritenuta acconto rappresentanti).

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_009.png)

c) è necessaria quindi una categoria ritenuta acconto 23% (eventualmente da creare).

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_010.png)

d) si procedarà quindi a setuppare nel seguente modo la relativa ritenuta acconto ed enasarco:

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_001.png)

nella seconda tab impostare la regola ritenuta acconto ed enasarco 

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_002.png)

in modo da avere per enasarco la segnuente impostazione:

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_003.png)

e una impostazione ritenuta acconto come segue:

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_004.png)

con le seguenti regole di calcolo:

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_011.png)

per cui a ritenuta acconto nel seguente modo:

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_012.png)

e ritenuta enasarco nel seguente:

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_013.png)

## SetUp Agente 2019



## Procedura Calcolo Provvigioni

Si parte da dati fattura consolidati quindi fatture contabilizzate (generalmente il calcolo che viene fatto è trimestrale). Il menù dove effettuare la procedura è quello delle provvigioni.

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_018.png)

A questo punto utlilizzeremo il rappresentante correttamente settuppato e utilizzeremo un tipo addebito che avremo creato per indirizzare correttamente in contabilità i dati che si andranno a produrre.

Sarà necessario inserire una configurazione a livello linea commissioni che faccia a nostro caso per il tipo di elaborazione che desideriamo (ad esempio la schermata successiva determinerà una provvigione dello 1% sulle fatture dell' agente in testata in base al solo moltiplicatore importo indicato con 0,01).



## Indicazioni per il Setup Agenti

NB: NEL 2019 L'ALIQUOTA CONTRIBUTIVA SARA' DEL 16,50% SARA' QUINDI DA REIMPOSTARE LA PROCEDURA CON TASSI 8,25 CARICO DITTA E 8,25 AGENTE

SI ALLEGANO INDICAZIONI PER CALCOLI ENASARCO 2019.

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_014.png)

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_015.png)

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_016.png)

![](/opt/md/images/Ritenuta acconto ed enasarco/Setupritenutaenasarco_017.png)

DA VERIFICARE FUNZIONAMENTO PROFORMA



# Omaggi


##                                        TRATTAMENTO IN ACQUISTO



## [Omaggi a Terzi di Beni NON rientranti nell’attività propria dell’impresa](#Omaggi a Terzi di Beni NON rientranti nell’attività propria dell’impresa)

## [Omaggi a Terzi di Beni rientranti nell’attività propria dell’impresa](#Omaggi a Terzi di Beni rientranti nell'attività propria dell'impresa)

## [Omaggi ai Dipendenti](#Omaggi ai Dipendenti)

## [Pranzi e cene degli Auguri nel periodo natalizio](#Pranzi e cene degli Auguri nel periodo natalizio)

## [Omaggi effettuati da Professionisti](#Omaggi effettuati da Professionisti)

## [TABELLA RIEPILOGATIVA CON TRATTAMENTO IN VENDITA](#TABELLA RIEPILOGATIVA CON TRATTAMENTO IN VENDITA)



## Omaggi a Terzi di Beni NON rientranti nell’attività propria dell’impresa

I  costi sostenuti per l’acquisto di Beni, ceduti gratuitamente a terzi,  la cui produzione od il cui scambio NON rientra nell’attività propria  dell’impresa sono:

**<u>integralmente deducibili dal reddito di impresa nel periodo di sostenimento, se di valore unitario non superiore ad euro 50</u>**

- qualificati come **spese di rappresentanza** (C.M. n. 188/E/1998).

In merito alle **spese di rappresentanza** che l’articolo 108, comma 2, del T.U.I.R. così dispone:

“*Le spese di rappresentanza sono deducibili nel periodo d’imposta di sostenimento se rispondenti ai requisiti di **inerenza e congruità**  stabiliti con decreto del Ministro dell’economia e delle finanze, anche  in funzione della natura e della destinazione delle stesse, del volume  dei ricavi dell’attività caratteristica dell’impresa e dell’attività  internazionale dell’impresa. **Sono comunque deducibili le spese relative a beni distribuiti gratuitamente di valore unitario non superiore a euro 50**”.*

Per  la definizione e le condizioni di deducibilità delle spese di  rappresentanza occorre fare riferimento al D.M. 19 novembre 2008, il  quale dispone che:

*“si  considerano inerenti, sempreché effettivamente sostenute e documentate,  le spese per erogazioni a titolo   gratuito   di beni e servizi,  effettuate con finalità promozionali o di pubbliche relazioni e il cui  sostenimento risponda a criteri di ragionevolezza in funzione  dell’obiettivo di generare anche potenzialmente benefici economici per  l’impresa ovvero sia coerente con pratiche commerciali di settore*”.  

Costituiscono, in particolare, spese di rappresentanza a mente del D.M. citato:

**a)  le spese per viaggi turistici in occasione dei quali siano svolte  significative attività promozionali dei beni/servizi la cui produzione o  scambio costituisce oggetto dell’attività caratteristica dell’impresa;**

**b) le spese per feste, ricevimenti ed altri eventi di intrattenimento organizzati in occasione:**

– di ricorrenze aziendali o di festività nazionali o religiose;

– dell’inaugurazione di nuove sedi, uffici o stabilimenti dell’impresa;

– di mostre, fiere, ed eventi simili in cui sono esposti i beni e i servizi prodotti dall’impresa;

**c)  le altre spese per beni e servizi erogati gratuitamente, inclusi i  contributi erogati gratuitamente per convegni, seminari e manifestazioni  simili il cui sostenimento risponda a criteri di inerenza.**

Il Decreto fissa altresì le percentuali di deducibilità.

Le spese di rappresentanza sono deducibili nel periodo d’imposta di sostenimento e sono “*commisurate all’**ammontare dei Ricavi** e proventi della gestione caratteristica dell’impresa risultanti dalla dichiarazione dei redditi relativa allo stesso periodo*”.

I **limiti di deducibilità** di tali spese **da****l 2016** sono i seguenti:

| **LIMITI DEDUCIBILITA’ DAL 2016**                            |                              |
| ------------------------------------------------------------ | ---------------------------- |
| **Scaglioni dei ricavi e proventi della gestione caratteristica** | **Importo %** **sui ricavi** |
| **Fino a 10 milioni di Euro**                                | **1,50%**                    |
| **Oltre i 10 milioni e fino a 50 milioni di Euro**           | **0,60%**                    |
| **Oltre 50 milioni di euro**                                 | **0,40%**                    |
|                                                              |                              |

Con riguardo al **valore di 50,00 euro**  fissato per la deducibilità integrale, si precisa che nel caso in cui  l’omaggio sia composto da più beni (è il caso ad esempio del cesto  natalizio) il valore di 50,00 euro va **riferito al valore complessivo dell’omaggio** e non ai singoli beni che compongono lo stesso. 

Per quanto riguarda l’**I.V.A.**, l’articolo 19 bis1, comma 1, lett. h), del D.P.R. n. 633/1972, prevede:

– la **detraibilità integrale dell’I.V.A.** per gli omaggi, rientranti nelle spese di rappresentanza, di costo unitario **NON superiore ad euro 50,00**;

– l’indetraibilità dell’I.V.A., per gli omaggi di costo unitario superiore ad euro 50,00.

La  successiva cessione gratuita del bene (omaggio), indipendentemente da  valore dell’omaggio, è esclusa dal campo di applicazione dell’I.V.A. per  effetto dell’articolo 2, comma 2, n. 4), del D.P.R. n. 633/1972. 

Proponiamo di seguito in forma tabellare un riepilogo della disciplina sul punto:

|                                                           | **IVA**                                                      | **IRPEF / IRES**                                     |                                                              |
| --------------------------------------------------------- | ------------------------------------------------------------ | ---------------------------------------------------- | ------------------------------------------------------------ |
| **Detrazione IVA**                                        | **Cessione gratuita**                                        | **Deducibilità del Costo dell’Omaggio**              |                                                              |
| **OMAGGI** **A favore di CLIENTI**                        | **SI**   se di costo unitario **pari o inferiore ad euro 50,00** | **Esclusa** da IVA (art. 2, co. 2, n. 4, DPR 633/72) | nel **limite annuo deducibile** (cfr. Tabella sopra);     **per intero** nell’esercizio se di valore unitario **pari o inferiore ad euro 50,00** |
| **NO**   se di costo unitario **superiore ad euro 50,00** |                                                              |                                                      |                                                              |



## Omaggi a Terzi di Beni rientranti nell’attività propria dell’impresa

Gli Omaggi a clienti o fornitori di beni che rientrano in quelli dell’attività propria dell’impresa, “*non costituiscono spese di rappresentanza*” (*cfr.* Circolare Agenzia Entrate n. 188/E/1998). Quindi:

– l’I.V.A. assolta all’atto dell’acquisto è detraibile;

–  la cessione gratuita è imponibile I.V.A. indipendentemente dal costo  unitario dei beni (ex articolo 2, comma 2, n. 4, del D.P.R. n. 633/72).

La  rivalsa dell’I.V.A. addebitata in fattura non è obbligatoria (ex  articolo 18, D.P.R. n. 633/72) e, come spesso accade, l’I.V.A. rimane  quindi a carico del cedente e costituisce costo indeducibile (ex  articolo 99, comma 1, T.U.I.R.). Nella fattura emessa con applicazione  dell’I.V.A., ma senza addebitare la stessa al cliente, si indicherà che  trattasi di “*Omaggio senza rivalsa dell’I.V.A. ex articolo 18, D.P.R. n. 633/72*”.

Alternativamente, si potrà emettere un’autofattura, indicando che trattasi di “*Autofattura per Omaggi*”.

L’autofattura potrà esser singola (per ogni cessione) o globale mensile (per le cessioni effettuate nel mese).

Un’ulteriore  possibilità è quella di tenuta del Registro degli Omaggi ove annotare  l’ammontare complessivo delle cessioni gratuite effettuate in ciascun  giorno, distinte per aliquota.

## Omaggi ai Dipendenti

Nel  caso di Omaggi ai dipendenti dell’impresa, è opportuno iscrivere il  costo di acquisto di tali beni tra i costi di lavoro dipendente (non  nelle spese di rappresentanza).

Le  erogazioni liberali in natura (tra i quali rientrano anche gli Omaggi)  concessi ai singoli dipendenti sono reddito di lavoro dipendente (*benefits*) per gli stessi, **se di importo superiore ad euro 258,23** per ciascun periodo d’imposta.

Nel caso di cessione gratuita a dipendenti di beni che non rientrano nell’attività propria dell’impresa, l’**I.V.A.** è **indetraibile** e la loro cessione gratuita è esclusa dal campo di applicazione dell’IVA (come sopra ricordato).

La  cessione gratuita di Beni la cui produzione o il cui commercio rientra  nell’attività propria dell’impresa segue il medesimo trattamento sopra  indicato per gli omaggi effettuati nei confronti di Terzi.

## Pranzi e cene degli Auguri nel periodo natalizio

I  pranzi o cene degli auguri sono considerati **<u>spese di rappresentanza</u>** nel  caso in cui partecipino clienti o fornitori. In tal caso le cene sono  deducibili nel limite del 75% della spesa sostenuta, con i limiti in  vigore dal 2016 per la deducibilità delle spese di rappresentanza (come  sopra indicato; cfr.).

Nel  caso invece in cui a tali pranzi o cene degli auguri partecipino solo i  dipendenti, la Circolare n. 34 del 2009 considera tali spese  agevolativi nel limite del 75% (trattandosi di spese per alberghi e  ristoranti), deducibili nel limite dello 0,50% delle spese per  prestazioni di lavoro dipendente (ex articolo 100, comma 1, del TUIR). 

L’IVA  sarà indetraibile in entrambi i casi, ovvero sia che alla cena  partecipino clienti o fornitori, che nel caso siano beneficiari della  stessa i dipendenti. 

Ai  fini IRAP infine, la spesa di rappresentanza in esame risulta  deducibile per i contribuenti che applicano in metodo di bilancio,  mentre risulterà indeducibile per coloro che applicano il metodo fiscale  per la determinazione della base imponibile IRAP. Infine, risulta in  ogni caso consigliabile procedere ad identificare nei documenti fiscali i  soggetti che partecipano agli eventi aziendali: anche la Circolare n.  1/2018 della Guardia di Finanza ritiene di dover esprimere una  valutazione in merito alla tipologia di soggetti beneficiari, che  potrebbero ‘mascherare’ elargizioni, liberalità, forme di autoconsumo o  assegnazioni di beni ai soci a titolo gratuito. 

## Omaggi effettuati da Professionisti

Per  gli Omaggi di beni e servizi effettuati da Professionisti, ai fini  delle imposte dirette, le spese di rappresentanza sono deducibili nel **limite dell’1% dei compensi percepiti** nel periodo d’imposta, a prescindere dal valore unitario degli stessi.

Ai fini I.V.A. l’articolo 2, comma 2, n. 4), del D.P.R. n. 633/1972 esclude dalle cessioni imponibili “*quelli  la cui produzione o il cui commercio non rientra nell’attività propria  dell’impresa se di costo unitario non superiore ad euro 50,00*”.  Tale disposizione non trova applicazione per quanto riguarda i  lavoratori autonomi, per i quali costituiranno cessioni imponibili le  cessioni gratuite di beni di costo unitario inferiore ad euro 50,00 con  conseguenti obblighi di fatturazione, registrazione, ecc. degli omaggi.  In alternativa, si potrà **non detrarre l’I.V.A.** sull’acquisto dei beni da omaggiare, rendendo irrilevante ai fini I.V.A. la successiva cessione.

## TABELLA RIEPILOGATIVA CON TRATTAMENTO IN VENDITA

|                                                              |                                                         | IVA                                    |                                                              | IRPEF IRES                                                   |
| ------------------------------------------------------------ | ------------------------------------------------------- | -------------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| TIPO DI BENE CEDUTO IN OMAGGIO                               | **ACQUISTO**                                            | **VENDITA**                            | ADEMPIMENTI                                                  |                                                              |
| Omaggio di beni che non costituiscono oggetto della produzione o del commercio dell'impresa di importo non superiore a € 25.82 (compresi alimenti e bevande) | IVA detraibile art. 19 bis .1 lett.h DPR 633/72         | fuori campo IVA art. 2 n. 2 DPR 633/72 | nessno                                                       | interamente deducibili art. 108 TUIR                         |
| Omaggio di beni che non costituiscono oggetto della produzione o del commercio dell'impresa di importo superiore a € 25.82 (compresi alimenti e bevande) | IVA **non** detraibile art. 19 bis .1 lett.h DPR 633/72 | fuori campo IVA art. 2 n. 2 DPR 633/72 | nessuno                                                      | deducibili nel periodo di sostinementose rispondenti ai requisiti si congruità stab. dal min. delle finanze in funzione di 1 natura e destinazione degli stessi 2 volume dei ricavi dell'attivià caratteristica (vedi 2) 3 attività internazionale dell' impresa |
| Beni ceduti ai dipendenti                                    | IVA **non** detraibile art. 19 co. 2  DPR 633/72        | fuori campo IVA art. 2 n. 4 DPR 633/72 | nessuno                                                      | deducibili nel limite del 5xmille costo del personale art. 95 TUIR |
| Omaggio di beni che  costituiscono oggetto della produzione o del commercio dell'impresa di importo non superiore a € 25.82 (compresi alimenti e bevande) | iva DETRAIBILE                                          | soggetti a IVA art. 2 n. 4 DPR 633/72  | - Fattura con o senza rivalsa Iva                                                 - Autofattura                             - Registrazione Registro degli Omaggi | interamente deducibili fino al limite di € 50,00             |
| Omaggio di beni che  costituiscono oggetto della produzione o del commercio dell'impresa di importo superiore a € 25.82 (compresi alimenti e bevande) | IVA non detraibile                                      | soggetti a IVA art. 2 n. 4 DPR 633/72  | - Fattura con o senza rivalsa Iva                                                 - Autofattura                             - Registrazione Registro degli Omaggi | deducibili nel periodo di sostinementose rispondenti ai requisiti si congruità stab. dal min. delle finanze in funzione di 1 natura e destinazione degli stessi 2 volume dei ricavi dell'attivià caratteristica (vedi 2) 3 attività internazionale dell' impresa |

(vedi 2) 

| **LIMITI DEDUCIBILITA’ DAL 2016**                            |                              |
| ------------------------------------------------------------ | ---------------------------- |
| **Scaglioni dei ricavi e proventi della gestione caratteristica** | **Importo %** **sui ricavi** |
| **Fino a 10 milioni di Euro**                                | **1,50%**                    |
| **Oltre i 10 milioni e fino a 50 milioni di Euro**           | **0,60%**                    |
| **Oltre 50 milioni di euro**                                 | **0,40%**                    |
|                                                              |                              |


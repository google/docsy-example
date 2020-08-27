---
title: "Cespite"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 80
pre: "<b>8.9 </b>"
---

indice

* [Automatic Search]({{%relref "basics/configuration/_index.md#activate-search" %}})
* [Multilingual mode]({{%relref "cont/i18n/_index.md" %}})
* **Unlimited menu levels**
---

## Anagrafica Cespite

### Tabelle ministeriali coefficienti di ammortamento

La gestione dei cespiti proposta da Idempiere non prevede una tabellazione delle varie attività economiche e delle aliquote di ammortamento previste dal Ministero, ciò è demandato al Client. Viene fornita una predisposizione di base con dei "Gruppi Cespiti" già inseriti eventualmente modificabili e/o implementabili in base alle proprie esigenze. (bisognerà fare affidamento alla tabella Ministeriale relativa e alle disposizioni fiscali in esssere. 
Per l'inserimento e/o variazione dei gruppi Cespite si può fare eventualmente riferimento al seguente link.
[Link Decreto Ministeriale Gazzetta Ufficiale](https://www.gazzettaufficiale.it/eli/id/1989/02/02/088A0017/sg)
Le categorie sono riportate anche in "appendice"

### Gruppo Cespite

La maschera di inizio impostazioni del "Cespite" è quella relativa alla definizione del "Gruppo" è la seguente:

[{{< figure src="/image/Cespiti-50.png"  width="850"  >}}](/image/Cespiti-50.png)

Per quanto riguarda la parte corpo del gruppo si può far riferimento alla seguente immagine:

[{{< figure src="/image/Cespiti-51.png"  width="850"  >}}](/image/Cespiti-51.png)

In questa parte si compileranno i dati che determineranno le interrogazioni che si andranno a fare in base alle impostazioni che si inseriranno sui gruppi cespite ad es. se si vuole che l'ammortamento del primo periodo sia calcolato a metà dell'aliquota come fiscalmente permesso. Sono precompilati e da verificare poi i dati contabili che regoleranno le varie operazioni relative.

### Piano dei conti

E' necessario (ove non siano esistenti) l' Inserimento dei conti contabili nell'attivo Patrimoniale relativi alle categorie cespiti da inserire (per il loro valore di acquisto) e nel passivo dei conti che accolgono gli ammortamenti accumulati nei corsi dei vari anni (Fondi ammortamento).

Il piano dei conti di Idempiere già prevede i conti da utilizzare **<u>(si tratta solo di verificare se esistano tutti o se si vuole per motivi interni inserirne altri fermo restando il dover creare anche categorie prodotti e gruppi bene gestito dei punti seguenti)</u>**

---

## Operazioni Cespite

### Importazione Cespite

L'importazione Cespite è generalmente la prima operazione che ci si trova a fare, dovendo caricare il data base storico dei Cespiti aziendali. Tale operazione può essere eseguita "massivamente" da file CSV o attraverso la maschera appunti di Importazione Cespite, le maschere da utilizzare sono le seguenti: 
[{{< figure src="/image/Cespiti-52.png"  width="850"  >}}](/image/Cespiti-52.png)
[{{< figure src="/image/Cespiti-53.png"  width="850"  >}}](/image/Cespiti-53.png)

Chiaramente sarà necessario procedere ad inserire le anagrafiche dei cespiti con i quali si popolerà il Data Base aziendale. Tale operazione si può effettuare anche dalla maschera "Cespite"

[{{< figure src="/image/Cespiti-54.png"  width="850"  >}}](/image/Cespiti-54.png)
Sarà sicuramente più comodo inserire l'anagrafica con "zoom" tasto destro mouse dalla maschera di importazione, (dalla stessa maschera si potranno manutenzionare Gruppo Cespite, Prodotto, Area Stoccaggio). In realtà i dati indispensabili da inserire sono:
Costo del Cespite,
Ammortamento accumulato (sia Civile che fiscale),
Data entrata in funzione (è la data che da il via all'Ammortamento, NB si imputa a 01/01/n se si vuole che l'Ammortamento del primo periodo (anno) sia "pieno" oppure 01/07/n se lo si vuole al 50%.
Chiaramente si partirà da dei dati Storicizzati in maniera definitiva ossia al 31/12/ di un determinato anno fiscale chiuso, e si inseriranno i dati con data 01/01 dell'anno seguente. Inseriti detti dati si avvierà il processo e lo stesso aggiornerà il campo al periodo corrente (numero del mese in ammortamento).

### Acquisto Cespite 

**<u>Inserimento Oda</u>**

Il primo step nella procedura di inserimento di un nuovo bene ammortizzabile è l' inserimento di un ordine di acquisto relativo al bene da cespitare in azienda.
Si inserisce e completa l'ordine.
[{{< figure src="/image/Cespiti-3.png"  width="850"  >}}](/image/Cespiti-3.png)
**<u>Entrata merce</u>**

Si procede con fare l'entrata merce da ordine di acquisto o selezionando direttamente la iconcina elabora sulla barra degli strumenti o da Entrata Merci EM00 e facendo riferimento alle righe ordine in soggetto.
[{{< figure src="/image/Cespiti-5.png"  width="850"  >}}](/image/Cespiti-5.png)
si completa l' entrata (questa operazione fa contemporaneamente una anche una registrazione contabile di "magazzino").
[{{< figure src="/image/Cespiti-6.png"  width="850"  >}}](/image/Cespiti-6.png)
[{{< figure src="/image/Cespiti-7.png"  width="850"  >}}](/image/Cespiti-7.png)
**<u>Generazione della fattura di acquisto</u>**

A questo punto si procede con la generazione della fattura di acquisto preferibilmente dall'iconcina elabora.
[{{< figure src="/image/Cespiti-8.png"  width="850"  >}}](/image/Cespiti-8.png)
Apparirà un processo e selezionandolo avremo la videata della fattura in bozza.
[{{< figure src="/image/Cespiti-9.png"  width="850"  >}}](/image/Cespiti-9.png)

Al completamento apparirà un messaggio con la richiesta di ulteriori dati da inserire relativi appunto al cespite quindi apriamo la riga fattura a pagina intera.
[{{< figure src="/image/Cespiti-13.png"  width="850"  >}}](/image/Cespiti-13.png)
Indichiamo semplicemente che si tratta di un bene di tipo "capital", apparirà anche il gruppo al quale fa parte il cespite in oggetto.
[{{< figure src="/image/Cespiti-12.png"  width="850"  >}}](/image/Cespiti-12.png)

si procede con il completamento della fattura.
[{{< figure src="/image/Cespiti-14.png"  width="850"  >}}](/image/Cespiti-14.png)
[{{< figure src="/image/Cespiti-15.png"  width="850"  >}}](/image/Cespiti-15.png)

la registrazione contabile è la seguente
[{{< figure src="/image/Cespiti-16.png"  width="850"  >}}](/image/Cespiti-16.png)
**<u>Attivazione del Cespite</u>**

lo step successivo è l'attivazione del cespite. Si apre quindi il menù aggiunte cespite ed apparirà (come primo cespite sul quale si opera proprio quello interessato), oppure lo si ricerca.
[{{< figure src="/image/Cespiti-17.png"  width="850"  >}}](/image/Cespiti-17.png)

si attiva il cespite completando la registrazione eventualmente inserendi dati ulteriori (ad esempio se vogliamo far recepire l'ammortamento a metà per il primo periodo indicheremo data registrazione cespite 01.07.n).
[{{< figure src="/image/Cespiti-18.png"  width="850"  >}}](/image/Cespiti-18.png)

Viene prodotta anche una registrazione contabile che si elide in sè (dare avere della categoria).
[{{< figure src="/image/Cespiti-19.png"  width="850"  >}}](/image/Cespiti-19.png)

apriamo ora il menù cespite: nella Tab Ammortamento vediamo il calcolo proposto mensilmente di cui si è popolato il cespite stesso (in base alle impostazioni attribuitegli come gruppo e categoria).
[{{< figure src="/image/Cespiti-20.png"  width="850"  >}}](/image/Cespiti-20.png)
[{{< figure src="/image/Cespiti-20a.png"  width="850"  >}}](/image/Cespiti-20a.png)

### Ammortamento

**<u>Registrazione dell'Ammortamento</u>**

La maschera che si utilizza generalmente a fine anno per registrare gli ammortamenti è la seguente:
[{{< figure src="/image/Cespiti-55.png"  width="850"  >}}](/image/Cespiti-55.png)

Si Selezionano gli ammortamenti da registrare (normalmente sono quelli dell'anno o esercizio contabile/fiscale in corso), generalmente si procede con abilitazione registrazione riepilogativa si avrà così una registrazione in contabilità "raggruppata" per gruppo cespite/contabile.
[{{< figure src="/image/Cespiti-56.png"  width="850"  >}}](/image/Cespiti-56.png)

Sarà comunque possibile successivamente se si dovessero effettuare delle modifiche effettuare un "ri-regista" dei dati che si volessere modificare contabilmente.

### Superammortamento

### Incrementi Manutentivi al Cespite

**<u>Manutenzione straordinaria collegata al Cespite</u>**

**<u>Caso a)Manutenzione straordinaria incrementativa del valore del Cespite</u>**

E' il caso di spese di manutenzione o incrementative di natura straordinaria o che modificano sostanzialmente il valore del cespite stesso e come tali di carattere pluriennale quindi da ammortizzare.
In questo caso si procede come per l'acquisto del cespite primario, quindi:
- Inserimento Ordine di acquisto
- Entrata Merce 
- Fattura di acquisto
- Aggiunta cespite ** **<u>Da Vedere</u>**

In questo momento si andrà a collegare l'acquisto al Cespite originario e come unica indicazione andiamo a inserire la data di registrazione relativa all'immissione in ammortamento (01.01.n oppure 01.07.n se desideriamo avere un ammortamento metà per il periodo di entrata in produzione della manutenzione). 

Inseriamo una fattura per una spesa incrementativa del cespite e/o una manutenzione staordinaria che si intende ammortizzare
[{{< figure src="/image/Cespiti-58.png"  width="850"  >}}](/image/Cespiti-58.png)
Dovremo effettuare una aggiunta Cespite collegando questa registrazione al cespite cui si fa riferimento, quindi Indichiamo in riga fattura il cespite padre. **<u>Si ricorda la necessità di dover effettuare il calcolo dell'ammortamento per il bene iniziale aggiornandolo al mese precedente in modo da effettuare un calcolo corretto degli ammortamenti successivamente generati (regola dell'ammortamento a metà per il primo anno su aggiunta da impostare sull'aggiunta in data inizio ammortamento/entrata produzione 01/01/n o 01/07/n)</u>** 
Nel dettaglio della riga fattura (dopo aver proceduto all'aggiunta cespite) avremo  queste informazioni 
[{{< figure src="/image/Cespiti-59.png"  width="850"  >}}](/image/Cespiti-59.png)
mentre nella tab Aggiunta Cespite del cespite troveremo le informazioni che avremo aggiornato 
[{{< figure src="/image/Cespiti-60.png"  width="850"  >}}](/image/Cespiti-60.png)

**<u>Caso b)Rettifica della Manutenzione straordinaria in negativo (nota di accredito eventuale del fornitore) del valore del Cespite</u>**

- Nota di Accredito a Rettifica fattura del fornitore
- Aggiunta cespite ** **<u>Da Vedere</u>**

Nel caso si debba effetturare una rettifica in diminuzione dell'importo del cespite dovremo procedere con la registrazione di una nota di accredito come di seguito visualizzato
[{{< figure src="/image/Cespiti-61.png"  width="850"  >}}](/image/Cespiti-61.png)
si effettuerà quindi l'Aggiunta Cespite collegando la diminuzioneal cespite relativo e si procederà ai calcoli ammortamenti desiderati.


### Dismissione Cespite

Analizziamo il caso della vendita di un cespite. La dismissione si effettua con fattura di vendita.
[{{< figure src="/image/Cespiti-62.png"  width="850"  >}}](/image/Cespiti-62.png)
indicando in riga fattura il cespite che si vende
[{{< figure src="/image/Cespiti-63.png"  width="850"  >}}](/image/Cespiti-63.png)
si seleziona quindi il "link" ai Cespiti e viene proposta la seguente mashera con i dati del cespite
[{{< figure src="/image/Cespiti-64.png"  width="850"  >}}](/image/Cespiti-64.png)
facendo attenzione che non ci siano quote proposte nel piano di ammortamento del cespite stesso, **<u>che dovranno essere a questo punto cestinate</u>** andiamo a completare la registrazione di dismissione ne avremo una registrazione che stornerà la fattura di vendita e in base al residuo da ammortizzare verrà registrata la plusvalenza oppure la minusvalenza relative. 

### Rivalutazione del Cespite

## Stampe ed Interrogazioni Cespite

### Report di stampa

I Report a supporto della Gestione Cespite sono: 

Report LIBRO CESPITI AMMORTIZZABILI [RP.881]
Report LIBRO CESPITI AMMORTIZZABILI [RP.882]

## Modifiche Report

[Cosa estrae ora il report](#Cosa estrae ora il report) 

Cosa estrae ora il report

![](/home/milena/consulting-nc/Documentazione iDempiere Utente/Manuale iDempiere/8.Contabilità e Controllo di Gestione/11.Contabilità e Controllo di Gestione/12.Cespite/12.01 Setup Ammortamento Cespite/Immagini Cespiti/35.png)

a) prima osservazione se il nome gruppo è molto lungo (60 caratteri?=) elide la percentuale di ammortamento del gruppo

b) non so se perchè seleziono anche anno prima di inserimento del cespite (ho selezionato 2018 mentre il cespite era stato inserito in data 8/10/2019) mi reporta una riga di valori a 0 vedi primo gruppo cespite id 1000034. Se seleziono periodo contabile precedente non dovrebbe reportare niente.

allego ora altro esempio di stampa registro

![](/home/idempiere/md/Documentazione iDempiere Utente/Manuale iDempiere/8.Contabilità e Controllo di Gestione/11.Contabilità e Controllo di Gestione/12.Cespite/12.01 Setup Ammortamento Cespite/Immagini Cespiti/37.png)

c) come si vede effettuamndo una stampa di più anni cumulati la percentuale di ammortamento viene evidenziata in descrizione anno per anno. Sarebbe bello fissare  un totale storico aggiornato del bene il cui valore è composto da due importi (mezzo + antifurto) in un'unica riga. 

![](/home/idempiere/md/Documentazione iDempiere Utente/Manuale iDempiere/8.Contabilità e Controllo di Gestione/11.Contabilità e Controllo di Gestione/12.Cespite/12.01 Setup Ammortamento Cespite/Immagini Cespiti/38.png)

d) altra cosa che manca nella stampa è una totalizzazione per categoria come si evince dalla stampa sopra riportata.

dalla stampa seguente si ha esempio di altri campi che sarebbe opportuo riportare. più gstionali riportano correttamente anche quelli che sono i valori fiscalmente detraibili (generalmente affiancando i dati su due meze pagine, proporrei per ottimizzare spazi di riportare i dati di cui sopra su due righe una sotto l'altra) indicando a inizio riga civile o fiscale.

![](/home/idempiere/md/Documentazione iDempiere Utente/Manuale iDempiere/8.Contabilità e Controllo di Gestione/11.Contabilità e Controllo di Gestione/12.Cespite/12.01 Setup Ammortamento Cespite/Immagini Cespiti/39.png)

## Riferimenti Video

### Video - 8. Accounting - Asset Acquisition / Procedura acquisizione cespite [V155]
{{<youtube LhFW5KKr8KE>}}

### Video - 8. Accounting - Depreciation Service Code Creation / Creaz. codice Servizio Ammortamento [V154]
{{<youtube 5jlSjTNMahI>}}

### Video - 8.Accounting - Asset / Creazione gruppo cespite [V153]
{{<youtube R1OlGZR8W_E>}}

### Video - 8 Accounting Cespiti Inserimento [V091]
{{<youtube Uq3TZCvH-as>}}

## Appendice

## DM 31-12-1988 Cespiti

Ministero delle finanze
D.M. 31-12-1988
Coefficienti di ammortamento del costo dei beni materiali strumentali impiegati nell'esercizio
di attività commerciali, arti e professioni.
Pubblicato nella Gazz. Uff. 2 febbraio 1989, n. 27, S.O.

D.M. 31 dicembre 1988 (1).
Coefficienti di ammortamento del costo dei beni materiali strumentali impiegati nell'esercizio
di attività commerciali, arti e professioni (2) (3).
(1) Pubblicato nella Gazz. Uff. 2 febbraio 1989, n. 27, S.O.
(2) Per la revisione dei coefficenti di ammortamento vedi l'art. 6, D.L. 1° luglio 2009, n. 78.
(3) Emanato dal Ministero delle finanze.

IL MINISTRO DELLE FINANZE
Visto il decreto del Presidente della Repubblica 22 dicembre 1986, n. 917, approvativo del testo
unico delle imposte sui redditi;
Visto l'art. 67 dello stesso testo unico con il quale è stata ammessa la deducibilità delle quote di
ammortamento del costo dei beni materiali strumentali per l'esercizio dell'impresa, in misura non
superiore a quella risultante dall'applicazione al costo dei beni dei coefficienti stabiliti, per categorie
di beni omogenei, in base al normale periodo di deperimento e consumo dei vari settori produttivi,
con decreto del Ministro delle finanze;
Visto l'art. 50 del testo unico medesimo con il quale è stata ammessa la deducibilità di quote annuali
di ammortamento del costo dei beni strumentali per l'esercizio dell'arte o professione, non superiori
a quelle risultanti dall'applicazione al costo dei beni dei coefficienti stabiliti, per categorie di beni
omogenei, con decreto del Ministro delle finanze;
Considerata l'opportunità di procedere alla determinazione dei coefficienti di ammortamento ai fini
sia dell'art. 67 che dell'art. 50 suindicati;
Decreta:
1. È approvata l'allegata tabella dei coefficienti di ammortamento del costo dei beni materiali per
    l'esercizio dell'impresa, ai sensi e per gli effetti di cui all'art. 67 del testo unico delle imposte sui
    redditi, approvato con il decreto del Presidente della Repubblica 22 dicembre 1986, n. 917.
2. La tabella di cui all'articolo precedente è altresì approvata, ai sensi e per gli effetti dell'art. 50 del
    testo unico citato nell'art. 1, per i beni materiali strumentali per l'esercizio dell'arte o professione,
    applicandosi a tali beni i coefficienti di ammortamento previsti per i medesimi beni di
    corrispondenti o similari attività esercitate in forma di impresa.3. La tabella di cui all'articolo 1 si applica per gli ammortamenti dei beni materiali strumentali che
    hanno inizio a decorrere dal primo periodo di imposta successivo al 31 dicembre 1988.
3. Il presente decreto sarà pubblicato nella Gazzetta Ufficiale della Repubblica italiana.

## 1 - Tabella dei coefficienti di ammortamento - Gruppo I INDUSTRIE AGRARIE E BOSCHIVE

**<u>Specie 1 - Affittuari di fondi rustici, condotti a mezzadria con bracciantato o direttamente.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Macchine agricole (compresi i trattori)                      | 9%              |                  |
| Impianti mobili di irrigazione - Carri agricoli e carri botte - Attrezzatura di stalla e varia | 12,50%          |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroni che compresi i computers e i sistemi telefonici elettronici. | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 2 - Industrie agrarie diverse, all'infuori della categoria degli affitti.</u>**

N.B.: Per le industrie agrarie diverse, già considerate in altri gruppi (ad esempio: industrie di conserve vegetali, considerate nel gruppo V) si rimanda ai coefficienti previsti nei rispettivi gruppi. Per le industrie non altrove considerate, come la essiccazione del tabacco (per cièo che eccede il ciclo di lavorazione agricola) e la selezione di semi, valgono i seguenti coefficienti:

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (edifici)                 | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori ed impianti                             | 9%              |                  |
| Attrezzatura varia e minuta                                  | 20%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 3 - Industrie agrarie esercitate da proprietari di fondi.</u>**

N.B.: Per le attività rientranti in questa specie si rimanda ai coefficienti stabiliti per i rispettivi «gruppi» e «specie».

**<u>Specie 4 - Aziende di utilizzazione del bosco (abbattimento e carbonizzazione).</u>**


| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Attrezzature e impianti (comprese le teleferiche)            | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 5 - Esercizio di macchine agricole per conto terzi (incluso il noleggio).</u>**


| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (edifici)                 | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchine destinate al noleggio                               | 9%              |                  |
| Mietitrebbiatrici ed altre macchine operatrici               | 20%             |                  |
| Trattrici e macchine per il movimento terra in agricoltura   | 12,50%          |                  |
| Officina di manutenzione                                     | 6,50%           |                  |
| Attrezzatura varia e minuta                                  | 20%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Automezzi e aerei destinati esclusivamente alla difesa fitosanitaria delle colture | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

## 2 - Tabella dei coefficienti di ammortamento - Gruppo II INDUSTRIE ZOOTECNICHE

**<u>Specie 1 - Armentizia, allevamento cavalli, malghe, monta taurina, equina e suina ed altre industrie zootecniche.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Edifici (compresi quelli per il ricovero degli animali e silos) | 3%              |                  |
| Silos in materiale ferroso                                   | 8%              |                  |
| Silos in materiale plastico                                  | 10%             |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchine per la preparazione degli alimenti, macchinari generici, attrezzatura di stalla e varia | 12,50%          |                  |
| Macchine ed attrezzature di stalla altamente automatizzate   | 20%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |


## 3 - Tabella dei coefficienti di ammortamento - Gruppo III INDUSTRIE DELLA PESCA E DELLA CACCIA

**<u>Specie 1 - Industria della pesca, compresa quella delle spugne e del corallo.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Motopescherecci (completi di equipaggiamento)                | 12,50%          |                  |
| Attrezzatura particolare di pesca a bordo ed a terra (reti, tonnare, griglie, ecc.) | 31,50%          |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 2 - Allevamento di pesci e molluschi in acque marine (valli salse, laghi costieri, stagni litoranei, peschiere, lagune) ed in acque interne (valli, laghi, stagni, peschiere, fiumi).</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati industriali                                       | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti e macchinari generici                               | 6%              |                  |
| Impianti e macchinari specifici (bacini di allevamento, forni, lavorieri) | 8%              |                  |
| Attrezzatura varia e minuta                                  | 20%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

## 4 - Tabella dei coefficienti di ammortamento - Gruppo IV INDUSTRIE ESTRATTIVE DI MINERALI METALLIFERI E NON METALLIFERI

**<u>Specie 1 - Miniere di minerali di ferro e di minerali metalliferi non ferrosi.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (edifici, silos, vasche e serbatoi, opere idrauliche fisse strade e piazzali, acquedotti) | 5%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Gallerie e pozzi (escluse le armature mobili)                | 6%              |                  |
| Impianti generici del soprasuolo (produzione o presa e distribuzione di energie - raccordi e materiale rotabile - officina di manutenzione - impianti di trasporto - impianti e mezzi di sollevamento, carico, scarico e pesatura - ove non siano da considerare impianti specifici) | 8%              |                  |
| Impianti specifici del soprasuolo                            | 10%             |                  |
| Impianti specifici del sottosuolo                            | 15%             |                  |
| Forni e loro pertinenze                                      | 10%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 30%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 2 - Miniere di zolfo.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 5,50 %          |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Gallerie e pozzi (escluse le armature mobili)                | 6%              |                  |
| Impianti generici del soprasuolo (come nella specie 1)       | 8%              |                  |
| Impianti specifici del soprasuolo                            | 11%             |                  |
| Impianti specifici del sottosuolo                            | 16%             |                  |
| Forni e loro pertinenze                                      | 10%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 30%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 3 - Miniere di combustibili fossili.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 5%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Gallerie e pozzi (escluse le armature mobili)                | 6%              |                  |
| Impianti generici del soprasuolo (come nella specie 1)       | 8%              |                  |
| Impianti specifici del soprasuolo                            | 9%              |                  |
| Impianti specifici del sottosuolo                            | 14%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 30%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 4 - Miniere di combustibili liquidi e gassosi.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 5,50 %          |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1)                      | 8%              |                  |
| Impianti specifici (compresi i pozzi)                        | 15%             |                  |
| Impianti specifici dell'industria per lo sfruttamento delle forze endogene | 25%             |                  |
| Autosonde, autoregistratori per rilievi geofisici e diversi  | 25%             |                  |
| Attrezzatura varia e minuta                                  | 35%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. medianteimpiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto ininterno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 5 - Cave di marmo ed affini, di pietre da costruzione, di calcari, di marne, ecc.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori ed impianti                             | 10%             |                  |
| Escavatrici e pale meccaniche                                | 25%             |                  |
| Attrezzatura varia e minuta                                  | 30%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 6 - Cave di sabbia, ghiaia e pietrisco.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori ed impianti (compresi gli escavatori)   | 8%              |                  |
| Attrezzatura varia e minuta                                  | 30%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 7 - Miniere di salgemma, sorgenti salate naturali e produzione di sale marino e di ebollizione (Vedi specie 2).</u>**

(4) Il D.M. 9 maggio 1989 (Gazz. Uff. 9 maggio 1989, n. 124) ha così disposto:
«Art. 1. - A decorrere dal periodo di imposta in corso alla data di pubblicazione nella Gazzetta
Ufficiale del presente decreto, i soggetti che svolgono le attività indicate nel gruppo IV della tabella
dei coefficienti di ammortamento allegata al decreto ministeriale 31 dicembre 1988, ai fini della
determinazione del reddito di impresa, possono dedurre le spese di manutenzione, riparazione,
ammodernamento e trasformazione relativi ai cespiti utilizzati nelle predette attività fino al limite
del 15 per cento del costo complessivo di tutti i beni ammortizzabili quale risulta, all'inizio
dell'esercizio, dal registro dei beni ammortizzabili.
Art. 2. - Ai fini della corretta pubblicazione delle disposizioni del precedente art. 1, le spese di
manutenzione, riparazione, ammodernamento e trasformazione relative ai cespiti indicati nello
stesso art. 1, devono essere rilevate distintamente nelle scritture contabili delle imprese interessate e
riportate distintamente in apposito prospetto allegato alla dichiarazione dei redditi».

## 5 - Tabella dei coefficienti di ammortamento - Gruppo V INDUSTRIE MANIFATTURIERE ALIMENTARI

**<u>Specie 1 - Brillatura del riso, pilatura ed altre lavorazioni di cereali e legumi, esclusa la molitura.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (edifici, opere idrauliche fisse, silos, strade e piazzali, fognature, vasche e serbatoi) | 3%              |                  |
| Silos in materiale ferroso                                   | 8%              |                  |
| Silos in materiale plastico                                  | 10%             |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori e impianti                              | 10%             |                  |
| Macchine per la preparazione degli alimenti                  | 12,50 %         |                  |
| Attrezzatura varia e minuta                                  | 20%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 2 - Molitura di cereali.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori e impianti                              | 10%             |                  |
| Attrezzatura varia e minuta                                  | 20%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 3 - Panificazione, produzione di biscotti e di pasticcerie.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori ed impianti                             | 9%              |                  |
| Impianti specifici                                           | 12,50 %         |                  |
| Forni e loro pertinenze                                      | 14%             |                  |
| Macchinari con rilevante componente elettronica              | 18%             |                  |
| Attrezzatura varia e minuta                                  | 25%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 4 - Pastificazione.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (servizio vapore e acqua calda, impianti di presa e distribuzione energia, officina di manutenzione, impianti di trasporto interno, impianti e mezzi di sollevamento, carico, scarico e pesatura, raccordi e materiale rotabile) | 7,50 %          |                  |
| Macchinari operatori e impianti specifici (compresi i forni e gli impianti di condizionamento) | 14%             |                  |
| Attrezzatura varia e minuta                                  | 40%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 5/a - Lavorazione del cacao, produzione di cioccolata e confetture in genere, torrefazione del caffè, produzione di surrogati.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori e impianti                              | 12,50%          |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 40%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 5/b - Produzione di gelati.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori e impianti                              | 15%             |                  |
| Attrezzatura varia e minuta                                  | 40%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 6 - Produzione e raffinazione dello zucchero.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari e impianti generici (come nella specie 4)         | 7,50%           |                  |
| Macchinari e impianti specifici                              | 12,50%          |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 20%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 7 - Lavorazione e conservazione delle carni.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari e impianti generici (come nella specie 4)         | 9%              |                  |
| Macchinari e impianti specifici (compresi i forni e gli impianti di condizionamento) | 15%             |                  |
| Attrezzatura varia e minuta                                  | 20%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 8 - Lavorazione e conservazione dei prodotti alimentari della pesca.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori e impianti                              | 12,50%          |                  |
| Attrezzatura varia e minuta                                  | 20%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 9 - Conservazione e trasformazione di frutta, ortaggi, funghi e prodotti similari (marmellate, conserve di pomodoro, conserve alimentari in genere, dadi per brodo, ecc.).</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari e impianti generici (come nella specie 4)         | 7,50%           |                  |
| Macchinari e impianti specifici (compresi gli impianti di condizionamento) | 14%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 20%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 10 - Lavorazione del latte (caseifici, stagionatura del formaggio, lavorazione di mozzarelle ed altri latticini freschi lavorazione del burro) e conservazione del latte.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 4%              |                  |
| Costruzioni leggere 10%Macchinari e impianti generici        | 10%             |                  |
| Macchinari e impianti specifici                              | 16%             |                  |
| Attrezzatura varia e minuta di laboratorio                   | 20%             |                  |
| Mobili e macchine ordinarie e d'ufficio                      | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Automezzi dei depositi periferici per consegna ai clienti    | 30%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 11 - Produzione di olio d'oliva e di semi, per spremitura, e di olii vegetali, con solventi.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori e impianti                              | 10%             |                  |
| Attrezzatura varia e minuta                                  | 20%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 12 - Raffinazione degli olii vegetali (Vedi specie 1).</u>**

**<u>Specie 13 - Industria dei vini, mosti concentrati ed aceti (Vedi specie 11).</u>**

**<u>Specie 14 - Distillerie di alcole (Vedi specie 11).</u>**

**<u>Specie 15 - Produzione di liquori e affini (Vedi specie 11).</u>**

**<u>Specie 16 - Produzione di malto, birra ed estrattti di malto.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari e impianti generici (come nella specie 4)         | 7,50%           |                  |
| Macchinari e impianti specifici (compresi gli impianti di condizionamento) | 14%             |                  |
| Attrezzatura varia e minuta e di laboratorio (comprese le casse e i fusti) | 20%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 17 - Produzione di bevande analcoliche gassate e non (5).</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori e impianti                              | 10%             |                  |
| Attrezzatura varia e minuta e di laboratorio (compresi i frigoriferi e distributori automatici di bevande imbottigliate, le bottiglie a rendere, le casse, i fusti, le pedane e i distributori da banco) (6) | 20%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 18 - Fabbricazione del ghiaccio ed esercizio di frigoriferi per conto terzi.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori ed impianti (compresi gli impianti di condizionamento) | 12,50%          |                  |
| Attrezzatura varia e minuta                                  | 20%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemitelefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 19 - Imbottigliamento di acque minerali naturali (7).</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Opere idrauliche fisse e pozzi di estrazione e loro pertinenze | 2%              |                  |
| Serbatoi                                                     | 5%              |                  |
| Impianti di filtrazione e di imbottigliamento                | 12,50%          |                  |
| Condutture                                                   | 8%              |                  |
| Impianti di sollevamento e macchinari in genere              | 10%             |                  |
| Attrezzatura varia e minuta e di laboratorio (come nella specie 17) | 20%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

(5) Così modificato dal D.M. 7 novembre 1992 (Gazz. Uff. 17 novembre 1992, n. 271).
(6) Così modificato dal D.M. 7 novembre 1992 (Gazz. Uff. 17 novembre 1992, n. 271).
(7) Specie aggiunta dal D.M. 7 novembre 1992 (Gazz. Uff. 17 novembre 1992, n. 271).

## 6 - Tabella dei coefficienti di ammortamento - Gruppo VI INDUSTRIE MANIFATTURIERE DEL LEGNO

**<u>Specie 1 - Prima lavorazione del legno (segherie).</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (edifici, opere idrauliche fisse, strade e piazzali, acquedotti e fognature) | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici e specifici (officina manutenzione, servizi vapore, mezzi di carico, scarico e pesatura, impianti di presa e produzione energia) | 11,50%          |                  |
| Attrezzatura varia e minuta (attrezzi, scali di alaggio, ecc.) | 25%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 2 - Laboratori di falegnameria, di carpenteria in legno. Fabbricazione di oggetti e di recipienti in legno (Vedi specie 1).</u>**

**<u>Specie 3 - Costruzione e riparazione di veicoli in legno (Vedi specie 1).</u>**

**<u>Specie 4- Cantieri navali per costruzioni, riparazioni e demolizioni di navi in legno (Vedi specie 1).</u>**

**<u>Specie 5 - Fabbricazione di mobili e di arredamenti in legno, ebanisterie. Lucidatura, laccatura, doratura di mobili e di altri oggetti in legno (Vedi specie 1).</u>**

**<u>Specie 6 - Preparazione del crine vegetale, della trebbia, del truciolo e tracce di truciolo (non per cappelli) e simili. Lavorazione di canne palustri, vimini, giunchi, paglia e trecce di paglia (non per cappelli), sparto, saggina e simili. Fabbricazione di scope e affini (Vedi specie 1).</u>**

**<u>Specie 7 - Lavorazione del sughero.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (edifici, opere idrauliche fisse, strade e piazzali, acquedotti e fognature) | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici e impianti specifici non compresi nella voce seguente (officina manutenzione, servizi vapore, mezzi di carico, scarico e pesatura, impianto di presa eproduzione energia, macchine lavoratrici) | 7,50%           |                  |
| Impianti e macchinari specifici (forni di cottura)           | 12,50%          |                  |
| Attrezzatura varia e minuta (attrezzi e superfici attive)    | 20%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 8 - Industrie per la produzione di compensati, pannelli di legno laminati e pannelli di legno non sfibrati, compresi quelli misti con altre sostanze.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (edifici, opere idrauliche fisse, strade e piazzali, acquedotti e fognature) | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici e impianti specifici non compresi nella voce seguente (presse, officina di manutenzione, servizi vapore, mezzi di carico e scarico, misurazione, impianti di presa e produzione di energia) | 10%             |                  |
| Impianti e macchinari specifici con intervento di reagenti chimici e di alte pressioni (compresi i forni) | 12,50%          |                  |
| Attrezzatura varia e minuta                                  | 20%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 9 - Industrie per la produzione di pannelli di legno sfibrato e affini (masonite e faesite).</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (edifici, opere idrauliche fisse, strade e piazzali, acquedotti e fognature) | 5%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici ed impianti specifici non compresi nella voce seguente (presse, officina manutenzione, servizi vapore, mezzi di carico, scarico e misurazione, impianti di presa e produzione energia, cassoni di flusso, macchina continua, ecc.) | 10%             |                  |
| Impianti e macchinari specifici (di preparazione di lavaggio, idrofugazione, scromatura, cromatura, vagliatura, disidramento) ed altri macchinari con interventi di reagenti chimici o di alte pressioni | 12,50%          |                  |
| Attrezzatura varia e minuta                                  | 20%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

## 7 - Tabella dei coefficienti di ammortamento - Gruppo VII INDUSTRIE MANUFATTURIERE METALLURGICHE E MECCANICHE

**<u>Specie 1/a - Siderurgia in genere.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (edifici, opere idrauliche fisse, strade e piazzali, acquedotti e fognature) | 5%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (impianti di produzione, presa e distribuzione energia, officina di, manutenzione, raccordi e materiale rotabile, centrale di conversione parco motori e pompe ecc., impianti di trasporto interno, carico, scarico, sollevamento e pesatura) e specifici | 12%             |                  |
| Grandi impianti e macchine operatrici automatici             | 17,50%          |                  |
| Forni e loro pertinenze 15%Attrezzatura dei mezzi di produzione | 25%             |                  |
| Attrezzatura dei sistemi flessibili di produzione            | 30%             |                  |
| Attrezzatura varia e minuta (stampi, modelli, attrezzi e laboratorio) | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 1/b - Metallurgia dei metalli non ferrosi (piombo, alluminio, zinco, rame, loro derivati, ecc.).</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 5%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a) e specifici        | 10%             |                  |
| Grandi impianti specifici macchine operatrici automatici     | 17,50%          |                  |
| Celle elettrolitiche - Impianti con intervento di reagenti chimici | 17,50%          |                  |
| Forni e loro pertinenze                                      | 15%             |                  |
| Attrezzatura varia e minuta (stampi, modelli, attrezzi e laboratorio) | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 1/c - Fonderie di 2° fusione.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 5%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a) e specifici        | 10%             |                  |
| Macchinari specifici automatici                              | 17,50%          |                  |
| Forni e loro pertinenze                                      | 15%             |                  |
| Attrezzatura varia e minuta (stampi, modelli e attrezzi)     | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 1/d - Industria metallurgica del magnesio.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 5%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a) e specifici        | 10%             |                  |
| Celle elettrolitiche - Impianti con intervento di reagenti chimici - Impianti elettrotermici per la produzione del magnesio | 17,50%          |                  |
| Forni e loro pertinenze                                      | 15%             |                  |
| Attrezzatura varia e minuta (stampi, modelli, attrezzi e laboratorio) | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici eletelettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |


**<u>Specie 2 - Fabbriche di macchine industriali ed agricole e di utensileria per macchine utensili.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a) e superfici        | 10%             |                  |
| Grandi impianti specifici e macchine operatrici automatici   | 15,50%          |                  |
| Forni di trattamento                                         | 15%             |                  |
| Attrezzatura varia e minuta                                  | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 3 - Costruzione di pompe, compressori, ventilatori industriali, fucine, rubinetteria, valvole a aracinesca, apparecchi ad aria compressa ed affini (Vedi specie 2).</u>**

**<u>Specie 4 - Costruzione di mobili, letti ed arredi metallici, casseforti, armadi e serrature di sicurezza (Vedi specie 2).</u>**

**<u>Specie 5 - Costruzione di apparecchi igienico-sanitari e termici per uso domestico (Vedi specie 2).</u>**

**<u>Specie 6 - Fabbricazione di serrature comuni e di minuterie metalliche, di molle, di bulloneria grezza, di bulloneria e viteria lavorata e di derivati dalla lavorazione del filo.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a) e specifici        | 10%             |                  |
| Impianti specifici e macchine operatrici automatici          | 15,50%          |                  |
| Forni e loro pertinenze                                      | 15%             |                  |
| Attrezzatura varia e minuta                                  | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 7 - Fabbricazione di scatolame, fustame metallico e prodotti affini di lamiera sottile (Vedi specie 2).</u>**

**<u>Specie 8 - Fabbricazione di stoviglie, vasellame, posateria, attrezzi da cucina e di accessori casalinghi (Vedi specie 2).</u>**

**<u>Specie 9 - Fabbricazione di coltelleria, armi bianche ed attrezzi per arti e mestieri (Vedi specie 2).</u>**

**<u>Specie 10 - Fabbricazione di strumenti ed apparecchi per chirurgia, medicina, odontotecnica e di apparecchi ortopedici (Vedi specie 2).</u>**

**<u>Specie 11 - Fabbricazione di armi da fuoco e di materiale bellico in genere (Vedi specie 2).</u>**

**<u>Specie 12 - Fabbricazione di bilance, macchine per scrivere addizionatrici, calcolatrici ed affini, orologeria, apparecchi per misurazione, strumenti ed installazioni per il controllo del volo e degli impianti propulsori ed installazioni varie di bordo degli aerei (9).</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a) e specifici        | 10%             |                  |
| Impianti specifici e macchine operatrici automatiche         | 15,50%          |                  |
| Forni e loro pertinenze                                      | 15%             |                  |
| Attrezzatura varia e minuta                                  | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 13 - Fabbricazione di giocattoli di metallo.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari                                                   | 12,50%          |                  |
| Attrezzatura varia e minuta                                  | 35%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 14 - Fabbricazione di medaglie, argenterie, oreficerie, gioiellerie ed affini (Vedi specie 13).</u>**

**<u>Specie 15 - Costruzione e montatura di biciclette e fabbricazione di parti, di ricambi e di accessori (Vedi specie 13).</u>**

**<u>Specie 16/a - Costruzione e montatura di motoveicoli e fabbricazione di parti di motoveicoli e di accessori.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 3%              |                  |
| Piste di prova (10)                                          | 7%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a), specifici e macchine operatrici non automatiche | 10%             |                  |
| Impianti specifici e macchine operatrici automatiche         | 17,50%          |                  |
| Celle elettrolitiche e impianti con intervento di reagenti chimici | 20%             |                  |
| Forni e loro pertinenze                                      | 15%             |                  |
| Centri di lavoro robottizzati                                | 22%             |                  |
| Strumenti di collaudo e controllo                            | 30%             |                  |
| Attrezzatura varia e minuta                                  | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 16/b - Costruzione e montaggio motori per aviazione (Vedi specie 16/a).</u>**

**<u>Specie 17 - Costruzione di autoveicoli ed autotelai, e fabbricazione di parti di ricambio e di accessori (Vedi specie 16/a).</u>**

**<u>Specie 18 - Costruzione di carrozzerie per auto, per motoveicoli e per vetture ferrotramviarie e filoviarie, costruzione di rimorchi e fabbricazione di parti ed accessori.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.).               | 10%             |                  |
| Impianti generici (come nella specie 1/a) e specifici        | 10%             |                  |
| Forni, loro pertinenze e impianti con intervento di reagenti chimici | 15%             |                  |
| Centri di lavoro robottizzati                                | 22%             |                  |
| Strumenti di collaudo e di controllo                         | 30%             |                  |
| Attrezzatura varia e minuta                                  | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 19 - Costruzioni di materiale rotabile ferroviario e filoviario (Vedi specie 16/a).</u>**

**<u>Specie 20 - Costruzione e riparazione di aeromobili (Vedi specie 16/a).</u>**

**<u>Specie 21 - Cantieri navali per costruzioni, riparazioni e demolizioni di navi in metallo. Imprese di recupero navi (Vedi specie 18).</u>**

**<u>Specie 22 - Costruzione di macchine, apparecchi e strumenti elettrici, di apparecchi di telecomunicazione in genere, di elettronica specializzata ed affini.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a) e specifici        | 10%             |                  |
| Impianti specifici e macchine operatrici automatici          | 15,50%          |                  |
| Celle elettrolitiche e impianti con intervento di reagenti chimici | 20%             |                  |
| Forni e loro pertinenze                                      | 15%             |                  |
| Attrezzatura varia e minuta compresi impianti e strumentazioni elettroniche | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 23 - Officine per fucinatura, stampatura, imbutitura, saldatura (elettrica, alluminotermica ed ossiacetilenica), taglio (con fiamma ossidrica ed ossiacetilenica), tempera, cementazione e trattamenti superficiali ed elettrogalvanici dei metalli.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari                                                   | 12,50%          |                  |
| Attrezzatura varia e minuta                                  | 35%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 24 - Officine da ramaio, lattoniere, stagnino, fabbro ferraio, maniscalco ed arrotino compresi gli ambulanti (Vedi specie 13).</u>**

**<u>Specie 25 - Officine meccaniche per la riparazione di auto, motoveicoli e biciclette, e per riparazioni meccaniche generiche e specializzate.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari                                                   | 12,50%          |                  |
| Attrezzatura varia e minuta                                  | 35%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 26 - Officine per l'installazione e riparazione di impianti, macchinari ed apparecchi elettrici, radiofonici ed affini (Vedi specie 25).</u>**

**<u>Specie 27 - Imprese specializzate, non costruttrici, per l'installazione di impianti termici, di ventilazione, di condizionamento d'aria, idrico-sanitari, elettrici, telefonici interni ed affini (Vedi specie 25).</u>**

**<u>Specie 28 - Lavorazione artistica dei metalli non preziosi (Vedi specie 25).</u>**

**<u>Specie 29 - Fabbricazione e riparazione di strumenti ed apparecchi musicali (Vedi specie 25).</u>**

(8) Il D.M. 13 ottobre 1994 (Gazz. Uff. 12 novembre 1994, n. 265) ha così disposto:
«Art. 1. A decorrere dal periodo di imposta in corso alla data di pubblicazione nella Gazzetta
Ufficiale del presente decreto, i soggetti che svolgono le attività indicate nel gruppo VII, specie 1/A
e 1/C, della tabella dei coefficienti di ammortamento allegata al decreto ministeriale 31 dicembre1988, ai fini della determinazione del reddito di impresa, possono dedurre le spese di manutenzione,
riparazione, ammodernamento e trasformazione relative ai cespiti utilizzati nelle predette attività,
fino al limite dell'11 per cento del costo complessivo di tutti i beni materiali ammortizzabili quale
risulta, all'inizio dell'esercizio, dal registro dei beni ammortizzabili».
(9) Così modificato dal D.M. 7 novembre 1992 (Gazz. Uff. 17 novembre 1992, n. 271).
(10) Aggiunta dal D.M. 7 novembre 1992 (Gazz. Uff. 17 novembre 1992, n. 271).

## 8 - Tabella dei coefficienti di ammortamento - Gruppo VIII INDUSTRIE MANIFATTURIERE DEI MINERALI NON METALLIFERI

**<u>Specie 1 - Macinazione e lavaggio di minerali non metalliferi, lavorazione del marmo e della pietra da costruzione e per uso industriale.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (edifici, strade e piazzali) | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori e impianti                              | 10%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 2 - Lavorazione di pietre dure e preziose per gioiellerie e per uso industriale.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori e impianti                              | 10%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 3 - Lavorazione artistica dei marmi e delle pietre.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori ed impianti                             | 10%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 4/a - Fabbricazione di calce e gesso.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 5,50%           |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (impianti di produzione, presa e distribuzione d'energia, officina di manutenzione, raccordi e materiale rotabile, servizi vapore ed acqua calda, impianti di, trasporto interno, impianti e mezzi di sollevamento, carico, scarico, pesatura, parco motori pompe, ecc.) | 10%             |                  |
| Macchinari operatori ed impianti specifici                   | 12,50%          |                  |
| Forni e loro pertinenze                                      | 9%              |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 4/b - Fabbricazione di cemento.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 5,50%           |                  |
| Cave                                                         | 8%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 4/a) e specifici        | 12,50%          |                  |
| Forni e loro pertinenze                                      | 15,50%          |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 5/a - Fabbricazione di laterizi.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 5,50%           |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 4/a)                    | 12%             |                  |
| Macchinari operatori ed impianti specifici                   | 15%             |                  |
| Forni e loro pertinenze                                      | 15%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. medianteimpiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 5/b - Fabbricazione di oggetti in gres e materiali refrattari.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 4/a)                    | 10%             |                  |
| Macchinari operatori ed impianti specifici                   | 12,50%          |                  |
| Forni e loro pertinenze                                      | 14%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 5/c - Fabbricazione di abrasivi granulari, rigidi e flessibili (Vedi specie 5/b).</u>**

**<u>Specie 6 - Industria della ceramica (Vedi specie 5/b).</u>**

**<u>Specie 7 - Fabbricazione di manufatti di cemento, di conglomerati cementizi misti con misti con fibre e altre materie; di manufatti di gesso e stucco.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 4/a)                    | 12%             |                  |
| Macchinari operatori, impianti specifici e stampi            | 15,50%          |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 8 - Fabbricazione e lavorazione del vetro (esclusa la lavorazione delle lenti per occhiali e per strumenti ottici).</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1)     | 5,50%           |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 4/a)                    | 10%             |                  |
| Macchinari operatori e impianti specifici                    | 15%             |                  |
| Forni e loro pertinenze                                      | 22%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

## 9 - Tabella dei coefficienti di ammortamento - Gruppo IX INDUSTRIE MANIFATTURIERE CHIMICHE

**<u>Specie 1/a - Produzione di acido solforico, cloro, soda elettrolitica e derivati ed altri prodotti chimici non compresi nelle altre specie.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (edifici, opere idrauliche fisse, strade e piazzali, acquedotti e fognature, serbatoi in muratura e vasche di contenimento) | 7%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (impianti di produzione, presa e distribuzione energia, officina dimanutenzione, raccordi e materiale rotabile, servizi vapore e acqua calda, impianti di, trasporto interni, impianti e mezzi di sollevamento, carico, scarico, pesatura, parco motori pompe, ecc.) | 12,50%          |                  |
| Macchinari operatori e impianti specifici per le lavorazioni chimiche scarsamente corrosive e per le lavorazioni meccaniche | 15,50%          |                  |
| Macchinari operatori e impianti specifici per le lavorazioni chimiche altamente corrosive - Celle elettrolitiche - Forni - Reattori per sintesi - Apparecchi soggetti ad alte pressioni e temperature | 22,50%          |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 1/b - Produzione di ammoniaca sintetica, acido nitrico, nitrato di calcio ed ammonico, solfato ammonico e urea.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 7%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a)                    | 12,50%          |                  |
| Macchinari operatori ed impianti specifici per le lavorazioni chimiche non altamente corrosive e per le lavorazioni meccaniche | 15%             |                  |
| Macchinari operatori e impianti specifici per le lavorazioni chimiche altamente corrosive - Forni - Reattori per sintesi - Apparecchi soggetti ad alte pressioni e temperature | 19%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 2 - Raffinerie di petrolio, produzione e distribuzione di benzina e petroli per usi vari, di oli lubrificanti e di oli lubrificanti e residuati, produzione e distribuzione di gas di petrolio liquefatto.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 5,50%           |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a)                    | 10%             |                  |
| Macchinari operatori e impianti specifici per le lavorazioni chimiche scarsamente corrosive e per le lavorazioni meccaniche | 12,50%          |                  |
| Macchinari operatori e impianti specifici per le lavorazioni chimiche altamente corrosive - Forni - Reattori per sintesi - Apparecchi soggetti ad alte pressioni e temperature | 17,50%          |                  |
| Oleodotti - Serbatoi - Impianti stradali di distribuzione (chioschi, colonne di distribuzione, stazioni di imbottigliamento, stazioni di servizio) | 12,50%          |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 25%             |                  |
| Bombole gas di petrolio liquefatti                           | 15%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 3/a - Produzione di derivati della distillazione del carbon fossile, escluse le officine del gas (compresa la produzione e lavorazione dei derivati della distillazione del catrame di carbon fossile).</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a)                    | 9%              |                  |
| Macchinari operatori e impianti specifici                    | 10%             |                  |
| Forni e loro pertinenze                                      | 14%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 3/b - Produzione di elettrodi per forni elettrici per la fabbricazione dell'acciaio e anodi per l'elettrolisi dell'alluminio.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati ordinari                                          | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici                                            | 8%              |                  |
| Forni di cottura e grafitazione                              | 14%             |                  |
| Macchinari                                                   | 10%             |                  |
| Attrezzatura varia e minuta                                  | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 4 - Produzione di carburanti artificiali liquidi, compresa la produzione di alcole etilico e metilico.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 5,50%           |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a)                    | 10%             |                  |
| Macchinari operatori e impianti specifici per le lavorazioni chimiche scarsamente corrosive e per le lavorazioni meccaniche | 12,50%          |                  |
| Macchinari operatori e impianti specifici per le lavorazioni chimiche altamente corrosive | 15,50%          |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 5 - Produzione di gas compressi.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a)                    | 7,50%           |                  |
| Macchinari operatori ed impianti specifici                   | 10%             |                  |
| Apparecchiature ed impianti specifici di distribuzione (comprese le bombole) | 9%              |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 6 - Produzione di esplosivi.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 7%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a)                    | 10%             |                  |
| Macchinari operatori e impianti specifici per la lavorazioni meccaniche | 12,50%          |                  |
| Macchinari operatori e impianti specifici per le lavorazioni chimiche | 5,50%           |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 7 - Idrogenazione di olii e grassi vegetali ed animali, e lavorazione dei grassi.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 5,50%           |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a)                    | 10%             |                  |
| Macchinari operatori e impianti specifici                    | 12,50%          |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 8 - Produzione di saponi, glicerine, profumerie, essenze, aromi, derivati agrumari, candele ed affini (compresi i fiammiferi ed i detersivi sintetici).</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 5,50%           |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a)                    | 10%             |                  |
| Macchinari operatori e impianti specifici per le lavorazioni chimiche e scarsamente corrosive e per lavorazioni meccaniche | 12,50%          |                  |
| Macchinari operatori e impianti specifici per le lavorazioni chimiche altamente corrosive - Forni | 15,50%          |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 35%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 9 - Produzioni farmaceutiche, chimico-farmaceutiche ed affini.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 5,50%           |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a)                    | 10%             |                  |
| Macchinari operatori e impianti specifici per le lavorazioni chimiche scarsamente corrosive e per le lavorazioni meccaniche | 12%             |                  |
| Macchinari operatori e impianti specifici per le lavorazioni chimiche altamente corrosive - Forni - Reattori per sintesi - Apparecchi soggetti ad alte pressioni e temperature | 17,50%          |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemitelefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 10/a - Produzione di colori organici e sintetici e relativi prodotti (Vedi specie 1/b).</u>**

**<u>Specie 10/b - Produzione di estratti concianti, di vernici, pitture, inchiostri, destrine, colle, ceralacche ed affini (comprese matite ed affini).</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori ed impianti                             | 11,50%          |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 11/a - Produzione di cellulosa (compresa quella per la carta).</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 6%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a)                    | 10%             |                  |
| Macchinari operatori e impianti specifici per le lavorazioni chimiche scarsamente corrosive e per le lavorazioni meccaniche | 12,50%          |                  |
| Macchinari operatori e impianti specifici per le lavorazioni chimiche altamente corrosive - Forni - Apparecchi soggetti ad alte pressioni e temperature | 17,50%          |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 30%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 11/b - Produzione del trasparente di cellulosa, di fibre tessili artificiali e simili.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 6%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a)                    | 10%             |                  |
| Macchinari operatori e impianti specifici                    | 14%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 12 - Produzione di materie plastiche e resine sintetiche. Produzione dell'industria petrolchimica non compresa nelle altre specie (Vedi specie 11/a).</u>**

**<u>Specie 13 - Produzione di materiali sensibili per fotografia e cinematografia.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 5,50%           |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a)                    | 9%              |                  |
| Macchinari operatori e impianti specifici                    | 14%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 14 - Raffinerie di zolfo.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 5,50%           |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a)                    | 10%             |                  |
| Macchinari operatori e impianti specifici (compresi i forni) | 17,50%          |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

## 10 - Tabella dei coefficienti di ammortamento - Gruppo X INDUSTRIE MANIFATTURIERE DELLA CARTA

**<u>Specie 1/a - Fabbricazione e lavorazione di carta e cartone, compresa la fabbricazione di carte da parato e carte da gioco.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (edifici - opere idrauliche fisse - strade e piazzali - acquedottie fognature - serbatoi e vasche di contenimento) | 15,50%          |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (impianti di produzione, presa e distribuzione d'energia - officina di manutenzione e materiale rotabile - servizi vapore e acqua calda - impianti di trasporto interno - impianti e mezzi di sollevamento, carico, scarico, pesatura, parco motori, pompe, compressori, ecc.) | 9%              |                  |
| Macchinari operatori ed impianti specifici per preparazione pasta e per produzione e lavorazione carta e cartone | 11,50%          |                  |
| Impianti di preparazione dei liscivi e sbianche e per lisciviazione | 19%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 1/b - Fabbricazione di manufatti di carta e cartone, compresa la produzione di imballaggi (cartotecnica) (Vedi specie 1/a).</u>**

## 11 - Tabella dei coefficienti di ammortamento - Gruppo XI INDUSTRIE MANIFATTURIERE DELLE PELLI E DEL CUOIO

**<u>Specie 1 - Concia e tintura delle pelli. Produzione di succedanei e imitazioni del cuoio e pelli.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (edifici - strade e piazzali, pozzi, acquedotti e fognature - bottali in cemento) | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori e impianti                              | 17,50%          |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 2 - Fabbricazione di articoli in cuoio, pelle e loro succedanei esclusi guanti e calzature (Vedi specie 1).</u>**

## 12 - Tabella dei coefficienti di ammortamento - Gruppo XII INDUSTRIE MANIFATTURIERE TESSILI

**<u>Specie 1 - Produzione ed allevamento del seme-bachi. Essiccazione di bozzoli.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori e impianti                              | 10%             |                  |
| Attrezzatura varia e minuta                                  | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroni che compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 2 - Filatura (trattura) della seta (Vedi specie 1).</u>**

**<u>Specie 3 - Tessitura della seta e delle fibre tessili artificiali (Vedi specie 1).</u>**

**<u>Specie 4 - Produzione di fibre rigenerate (Vedi specie 1).</u>**

**<u>Specie 5/a - Lavorazione del cotone puro o misto con altre fibre.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.).               | 10%             |                  |
| Macchinari operatori e impianti (esclusi quelli in ambiente corrosivo) | 12,50%          |                  |
| Macchinari operatori di finissaggio ed impianti in ambiente normale | 15%             |                  |
| Macchinari operatori di finissaggio ed impianti in ambiente corrosivo | 18%             |                  |
| Attrezzatura varia e minuta                                  | 25%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 5/b - Lavorazione dei cascami di seta, puri o misti ad altre fibre (Vedi specie 5/a).</u>**

**<u>Specie 5/c - Lavorazione delle fibre sintetiche (11) (Vedi specie 5/a).</u>**

**<u>Specie 6 - Lavorazione della lana pura o mista con altre fibre (Vedi specie 5/a).</u>**

**<u>Specie 7 - Lavorazione del lino, della canapa, della juta, del ramiè e simili, puri o misti con altre fibre (Vedi specie 5/a).</u>**

**<u>Specie 7/b - Lavorazione di tessuti a maglia (Vedi specie 5/a) (12).</u>**

**<u>Specie 8 - Fabbricazione di cordami, spaghi, reti da pesca e da caccia (Vedi specie 1).</u>**

**<u>Specie 9 - Fabbricazione di passamanerie, tulli, merletti, nastri, tessuti elastici e simili (Vedi specie 1).</u>**

**<u>Specie 10 - Tintura, candeggio, stampatura, mercerizzazione, rifinitura, impermealizzazione ecc. di qualsiasi tessile (Vedi specie 5/a).</u>**

**<u>Specie 11 - Lavorazione delle setole, del crine animale, del pelo, delle penne, delle piume, del capok e simili (Vedi specie 1).</u>**

**<u>Specie 12 - Fabbricazione dei tappeti da terra (esclusi quelli di cocco e simili) (Vedi specie 1).</u>**

(11) Modificato dal D.M. 7 novembre 1992 (Gazz. Uff. 17 novembre 1992, n. 271).
(12) Aggiunta dal D.M. 7 novembre 1992 (Gazz. Uff. 17 novembre 1992, n. 271).

## 13 - Tabella dei coefficienti di ammortamento - Gruppo XIII INDUSTRIE MANIFATTURIERE DEL VESTIARIO, DELL'ABBIGLIAMENTO E DELL'ARREDAMENTO

**<u>INDUSTRIE MANIFATTURIERE DEL VESTIARIO, DELL'ABBIGLIAMENTO E DELL'ARREDAMENTO</u>**

| Categoria                   | Aliquota civile | Aliquota fiscale |
| --------------------------- | --------------- | ---------------- |
| Attrezzatura varia e minuta | 25%             |                  |

**<u>Specie 1 - Industria del cappello.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.).               | 10%             |                  |
| Macchinari operatori e impianti (13)                         | 12,50%          |                  |
| Grandi impianti e macchine operatrici automatici             | 17,50%          |                  |
| Attrezzatura varia e minuta                                  | 25%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 2 - Laboratori di modisteria (Vedi specie 1).</u>**

**<u>Specie 3 - Laboratori per la confezione di vestiario (Vedi specie 1).</u>**

**<u>Specie 4 - Laboratori per la confezione di pellicce (Vedi specie 1).</u>**

**<u>Specie 5 - Laboratori per la confezione di biancheria (Vedi specie 1).</u>**

**<u>Specie 6 - Laboratori per la fabbricazione di maglieria, guanti in maglia e calze (Vedi specie 1).</u>**

**<u>Specie 7 - Calzaturifici (Vedi specie 1).</u>**

**<u>Specie 8 - Laboratori di confezione e riparazione di calzature (Vedi specie 1).</u>**

**<u>Specie 9 - Laboratori per fabbricazione di guanti in pelle, in stoffa o in tessuti di maglia, esclusi quelli in maglia (Vedi specie 1).</u>**

**<u>Specie 10 - Laboratori per confezioni varie e accessori del vestiario (cravatte, sciarpe, bretelle, guarnizioni per abiti, fiori artificiali, bottoni, ecc.).</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori e impianti (14)                         | 12,50%          |                  |
| Macchinari operatori e impianti per stampaggio di resine sintetiche | 12,50%          |                  |
| Attrezzatura varia e minuta                                  | 25%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 11 - Fabbricazione e lavorazione di oggetti di ornamento, compresi quelli di tartaruga, di corallo e simili (Vedi specie 1).</u>**

**<u>Specie 12 - Laboratori di materassaio e tappezziere, laboratori per confezione di vele bandiere e simili (Vedi specie 1).</u>**

**<u>Specie 13 - Fabbricazione di giocattoli in genere (esclusi quelli di metallo e di gomma (Vedi specie 10).</u>**

(13) Così corretto con avviso di rettifica pubblicato nella Gazz. Uff. 3 agosto 1989, n. 180.
(14) Così corretto con avviso di rettifica pubblicato nella Gazz. Uff. 3 agosto 1989, n. 180.

## 14 - Tabella dei coefficienti di ammortamento - Gruppo XIV INDUSTRIE MANIFATTURIERE DELLA GOMMA DELLA GUTTAPERGA E DELLE MATERIE PLASTICHE

**<u>Specie 1/a - Produzione di manufatti di gomma.</u>**


| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (edifici - opere idrauliche fisse - strade e piazzali - fognature serbatoi e vasche di contenimento | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (servizio vapore e acqua calda - impianti di presa e distribuzione di energia officina di manutenzione - impianti di trasporto interni - impianti e mezzi di carico, scarico, sollevamento - parco motori, pompe, compressori) | 10%             |                  |
| Macchinari operatori ed impianti specifici                   | 15%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 1/b - Produzione di cavi elettrici.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a)                    | 10%             |                  |
| Macchinari operatori ed impianti specifici                   | 11,50%          |                  |
| Attrezzatura varia e minuta di laboratorio                   | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 1/c - Lavorazione di materie plastiche.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici (come nella specie 1/a)                    | 7,50%           |                  |
| Macchinari operatori, impianti specifici (compresi i forni)  | 12,50%          |                  |
| Attrezzatura varia e minuta e di laboratorio (compresi gli stampi utilizzati per la produzione di fondi in poliuretano e in gomma per calzature) (15) | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 1/d - Produzione di dischi fonografici, incisione, edizione e stampa.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati ordinari ed altri manufatti                       | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici                                            | 12%             |                  |
| Impianti specifici (registrazione, incisione, produzione dischi e matrici) | 30%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 40%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 2 - Laboratori di vulcanizzazione degli oggetti di gomma.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (come nella specie 1/a)   | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori ed impianti                             | 12,50%          |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 40%             |                  |
| Impianti destinati al trattamento ed al epuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |


Autovetture, motoveicoli e simili 25%(15) Modificato dal D.M. 7 novembre 1992 (Gazz. Uff. 17 novembre 1992, n. 271).

## Tabella dei coefficienti di ammortamento - Gruppo XV INDUSTRIE POLIGRAFICHE, EDITORIALI ED AFFINI

**<u>Specie 1 - Tipografie, litografie ed affini.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori non automatici ed impianti generici     | 10%             |                  |
| Macchinari operatori automatici e per operazioni di finitura | 15,50%          |                  |
| Rotative da stampa per carta in bobine                       | 20%             |                  |
| Sistemi elettronici di fotoriproduzione, fotocomposizione e simili | 25%             |                  |
| Impianti di acclimazione                                     | 20%             |                  |
| Attrezzatura varia e minuta (comprese fustelle e tipi)       | 25%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 2 - Legatorie.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Macchinari operatori ed impianti                             | 10%             |                  |
| Attrezzatura varia e minuta                                  | 25%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemitelefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 3 - Editori di libri e di giornali ed agenzie di stampa (Vedi specie 1).</u>**

## Tabella dei coefficienti di ammortamento - Gruppo XVI INDUSTRIE EDILIZIE

**<u>Specie 1/a - Imprese di costruzioni edilizie, di lavori di terra e di opere stradali, portuali e specializzate.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 12,50%          |                  |
| Impianti generici (elementi per tettoie e baracche, serbatoi e vasche, condutture, recinzioni, ponteggi in metallo - trasformatori - officina di manutenzione - impianti di trasporto interno, sollevamento, carico e scarico - impianti galleggianti e cassoni per costruzioni marittime) | 10%             |                  |
| Macchinari operatori ed impianti specifici (macchinario per le costruzioni edili, di gallerie, pozzi, argini - compressori stradali ed altro macchinario per costruzione di strade | 15%             |                  |
| Casseforti metalliche e palancole metalliche                 | 25%             |                  |
| Attrezzatura varia e minuta compresi i ponteggi in legno     | 40%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Escavatori e pale meccaniche                                 | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 1/b - Imprese costruzioni reti trasporto e distribuzione elettriche e telefoniche.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 3%              |                  |
| Compressori, martelli pneumatici, motopompe, scavatori, pale meccaniche | 25%             |                  |
| Attrezzatura varia (strumenti di misura elettrici ed elettronici e scale) | 40%             |                  |
| Mobili e macchine ordinarie d'ufficio e arredi               | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 1/c - Edilizia prefabbricata.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 3%              |                  |
| Costruzioni leggere                                          | 12,50%          |                  |
| Impianti generici                                            | 10%             |                  |
| Macchinari operatori e impianti specifici e stampi           | 20%             |                  |
| Attrezzatura varia                                           | 25%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

## Tabella dei coefficienti di ammortamento - Gruppo XVII INDUSTRIE DELL'ENERGIA ELETTRICA DEL GAS E DELL'ACQUA

**<u>Specie 1/a - Produzione e distribuzione di energia idroelettrica.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Opere idrauliche fisse                                       | 1%              |                  |
| Condotte forzate                                             | 4%              |                  |
| Centrali idroelettriche (esclusi i fabbricati)               | 7%              |                  |
| Linee di trasporto A.T.                                      | 4%              |                  |
| Sottostazioni di trasformazione (esclusi i fabbricati)       | 7%              |                  |
| Rete di distribuzione B.T.                                   | 8%              |                  |
| Attrezzatura varia e minuta - Apparecchi di misura e controllo | 10%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 1/b - Produzione e distribuzione di energia termoelettrica.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Centrali termoelettriche (esclusi i fabbricati)              | 9%              |                  |
| Linee di trasporto A.T.                                      | 4%              |                  |
| Sottostazioni di trasformazione (esclusi i fabbricati)       | 7%              |                  |
| Rete di distribuzione B.T.                                   | 8%              |                  |
| Attrezzatura varia e minuta - Apparecchi di misura e controllo | 10%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 2/a - Produzione e distribuzione di gas illuminante.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Gasometri                                                    | 5%              |                  |
| Impianti generici (compresi quelli di miscelazione metano)   | 8%              |                  |
| Impianti di produzione e filtrazione                         | 10%             |                  |
| Condutture                                                   | 5%              |                  |
| Attrezzatura varia e minuta - Apparecchi di misura e controllo | 10%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 2/b - Produzione e distribuzione di gas naturale.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 5,50%           |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Pozzi di estrazione e pertinenze                             | 15%             |                  |
| Serbatoi (vasche di contenimento)                            | 5%              |                  |
| Metanodotti:                                                                       Condotte dorsali per trasporto a grandi distanze dai centri di produzione | 10%             |                  |
| Condotte dorsali per trasporto a grandi distanze dai giacimenti gassoso-acquiferi; condotte di derivazione e di allacciamento | 12%             |                  |
| Condotte per usi civili (reti urbane)                        | 8%              |                  |
| Stazioni di compressione e pompaggio                         | 10%             |                  |
| Attrezzatura varia e minuta - Apparecchi di misura e controllo e bombole | 10%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 3 - Distribuzione di acqua potabile e non potabile.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 3,50%           |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Opere idrauliche fisse                                       | 2,50%           |                  |
| Serbatoi                                                     | 4%              |                  |
| Impianti di filtrazione                                      | 8%              |                  |
| Condutture                                                   | 5%              |                  |
| Impianti di sollevamento                                     | 12%             |                  |
| Attrezzatura varia e minuta - Apparecchi di misura e controllo laboratori | 10%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 4/a - Stabilimenti balneari marini.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Stabilimenti in muratura                                     | 6%              |                  |
| Stabilimenti in legno                                        | 20%             |                  |
| Attrezzatura da spiaggia (ombrelloni, sedie, tende)          | 30%             |                  |
| Natanti e galleggianti                                       | 12%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 4/b - Stabilimenti termali, idrotermali (16).</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Opere idrauliche fisse e pozzi di estrazione e loro pertinenze | 2%              |                  |
| Serbatoi                                                     | 5%              |                  |
| Impianti di filtrazione e di imbottigliamento                | 12,50%          |                  |
| Condutture                                                   | 8%              |                  |
| Impianti di sollevamento e macchinari in genere              | 10%             |                  |
| Attrezzatura varia e minuta e di laboratorio                 | 20%             |                  |
| Biancheria                                                   | 40%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |


(16) Modificato dal D.M. 7 novembre 1992 (Gazz. Uff. 17 novembre 1992, n. 271).

## Tabella dei coefficienti di ammortamento - Gruppo XVIII INDUSTRIE DEI TRASPORTI E DELLE COMUNICAZIONI

**<u>Specie 1, 2 e 3 - Trasporti aerei, marittimi, lacuali, fluviali e lagunari.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Piste, moli e terreni ad essi adibiti                        | 1%              |                  |
| Fabbricati destinati all'industria (edifici d'aeroporto e portuali) | 4%              |                  |
| Opere d'arte fisse                                           | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Aereo completo di equipaggiamento (compreso motore a terra e salvo norme a parte in relazione ad esigenze di sicurezza) (17) | 14%             |                  |
| Nave passeggeri                                              | 10%             |                  |
| Nave da carico cisterna o frigorifera                        | 10%             |                  |
| Nave da carico per carico secco                              | 9%              |                  |
| Nave per navigazione interna in acciaio o ferro - Ferry-boat - Rimorchiatore - Naviglio fermo | 7,50%           |                  |
| Nave per navigazione interna in legno - Barconi, chiatte, pontoni e lance | 9%              |                  |
| Apparecchi di segnalazione in genere, attrezzature di pista - Servizio carburanti | 31,50%          |                  |
| Impianti e mezzi di carico, scarico, sollevamento e trasporto (a terra) | 10%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |
| Contenitori di grandi dimensioni in metallo o materiale plastico | 15%             |                  |
| Aliscafi                                                     | 13%             |                  |
| Navi già in esercizio per almeno otto anni, acquistate per l'impiego nell'ulteriore durata residua (18) | 15%             |                  |

**<u>Specie 4 e 5 - Ferrovie, compreso l'esercizio di binari di raccordo per conto terzi, l'esercizio di vagoni letto e ristorante. Tramvie interurbane,urbane, e suburbane, ferrovie metropolitane, filovie, funicolari, funivie, slittovie ed ascensori.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Terreni adibiti alle linee e servizi ferroviari              | 1%              |                  |
| Fabbricati destinati all'industria                           | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Opere d'arte fisse (ponti, viadotti, gallerie)               | 4%              |                  |
| Altre opere d'arte                                           | 11,50%          |                  |
| Pali metallici                                               | 5%              |                  |
| Binari (rotaie, traverse, morsetterie)                       | 10%             |                  |
| Motrici in genere                                            | 10%             |                  |
| Materiale rotabile, ferroviario e tramviario (motrici escluse) | 7,50%           |                  |
| Materiale mobile - Impianti a cavo e filoviario (filobus, funivie, teleferiche, ascensori,slittovie) | 15%             |                  |
| Officina meccanica                                           | 10%             |                  |
| Attrezzatura varia e minuta - Mobili e macchine ordinarie di ufficio, di stazione e dei reparti accessori | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronic | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |
| Contenitori di grandi dimensioni in metallo o materiale plastico | 15%             |                  |

**<u>Specie 6, 7, 8 e 9 - Autoservizi per viaggiatori urbani, extraurbani e di linea. Servizi di trasporto persone convetture ed autovetture da piazza e da rimessa. Servizi di trasporto merci su vie ordinarie. Imprese di trasporti e pompe funebri. Servizi di trasporto e recapito corrispondenza (19).</u>**

### Specie 6, 7, 8 e 9 - Autoservizi per viaggiatori urbani, extraurbani e di linea. Servizi di trasporto persone convetture ed autovetture da piazza e da rimessa. Servizi di trasporto merci su vie ordinarie. Imprese di trasporti e pompe funebri. Servizi di trasporto e recapito corrispondenza (19).

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 4%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Autobus di linea adibiti a servizi pubblici di linea urbani ed extraurbani, compresi autobus in servizio per noleggio di rimessa e rimorchi per trasporto di persone | 25%             |                  |
| Autovetture in genere (servizio pubblico)                    | 30%             |                  |
| Autofurgoni e motofurgoni                                    | 30%             |                  |
| Trattori - Carri attrezzi - Carrelli elettrici               | 20%             |                  |
| Veicoli a traino animale                                     | 10%             |                  |
| Officina meccanica - Mezzi di sollevamento peso - Impianti di carica batterie | 10%             |                  |
| Attrezzatura varia e minuta - Finimenti per traino animali - Parati per pompe funebri -Accumulatori per carri elettrici | 20%             |                  |
| Attrezzatura varia e minuta - Mobili e macchine ordinarie di ufficio | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Contenitori di grandi dimensioni in metallo o materiale plastico | 15%             |                  |
| Contenitori e bottiglie per il trasporto di esafloruro di uranio e relative scocche protettive | 50%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) (20) | 20%             |                  |
| Autovetture, motoveicoli e simili (21)                       | 25%             |                  |

**<u>Specie 10/a - Servizi telegrafici, telefonici e telecomunicazioni tramite satelliti.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati ordinari ed altri manufatti                       | 3%              |                  |
| Fabbricati destinati all'industria                           | 6%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Centrali manuali ed elettromeccaniche (22)                   | 13%             |                  |
| Centrali e impianti elettronici                              | 18%             |                  |
| Ponti radio, circuiti (apparecchiature) A.F. ed amplificazioni | 15%             |                  |
| Rete aerea e pali di sostegno                                | 8%              |                  |
| Cavi sotterranei                                             | 5%              |                  |
| Cavi sottomarini                                             | 12%             |                  |
| Poste pubbliche e di abbonato, cabine, impianti interni e derivati, centralini ed apparecchiature | 12%             |                  |
| Attrezzatura varia e minuta                                  | 25%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 10/b - Servizi radiotelegrafonici, radiofonici, televisivi e telecomunicazioni tramite satelliti.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria                           | 6%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti radiofonici                                         | 12,50%          |                  |
| Impianti di sincronizzazione e centri di controllo           | 15,50%          |                  |
| Impianti di telediffusione e di televisione                  | 19%             |                  |
| Impianti di registrazione e ponti radio                      | 25%             |                  |
| Cavi sottomarini                                             | 12%             |                  |
| Dotazioni varie ed attrezzi                                  | 19%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Automezzi attrezzati                                         | 25%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 11 - Impianti per le telecomunicazioni a mezzo satelliti.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Segmento spaziale:                                                                                                                          Satelliti commerciali di telecomunicazioni e relativi centri di controllo | 18%             |                  |
| Trasponditori                                                | 36%             |                  |
| Stazioni terrene:                                                                                                                       Struttura antenna parabolica orientabile | 10%             |                  |
| Servosistema, sistema di illuminazione, ricevitore di inseguimento | 20%             |                  |
| Impianti di ricetrasmittenti e impianti e strumentazione centrali di misura e controllo | 25%             |                  |
| Impianto di alimentazione                                    | 10%             |                  |
| Terminali parabolici rice-trasmissivi di limitate dimensioni | 20%             |                  |
| Stazioni terrene mobili                                      | 25%             |                  |

**<u>Specie 12 - Autostrade, strade e superstrade in concessione.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Terreni adibiti ad autostrada                                | 1%              |                  |
| Fabbricati destinati all'industria                           | 4%              |                  |
| Costruzioni leggere                                          | 10%             |                  |
| Opere d'arte fisse (viadotti, ponti, gallerie, corpo autostradale, ecc.) | 4%              |                  |
| Altre opere d'arte (apparecchi di segnalazione, compressori, martelli pneumatici, semoventi, pale meccaniche) | 25%             |                  |
| Officine meccaniche                                          | 10%             |                  |
| Attrezzatura varia e minuta                                  | 12%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |

Autovetture, motoveicoli e simili 25%(17) Modificato dal D.M. 23 dicembre 1992 (Gazz. Uff. 7 gennaio 1993, n. 4).
(18) Voce così modificata dal D.M. 28 marzo 1996 (Gazz. Uff. 16 maggio 1996, n. 113).
(19) Modificato dal D.M. 7 novembre 1992 (Gazz. Uff. 17 novembre 1992, n. 271).
(20) Aggiunta dal D.M. 7 novembre 1992 (Gazz. Uff. 17 novembre 1992, n. 271).
(21) Aggiunta dal D.M. 7 novembre 1992 (Gazz. Uff. 17 novembre 1992, n. 271).
(22) Il coefficiente di cui alla presente voce è stato così elevato dal D.M. 19 ottobre 1995 (Gazz.
Uff. 31 ottobre 1995, n. 255).

## Tabella dei coefficienti di ammortamento - Gruppo XIX ALBERGHI, RISTORANTI, BAR E ATTIVITÀ AFFINI

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Edifici                                                      | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Mobili e arredamento                                         | 10%             |                  |
| Biancheria                                                   | 40%             |                  |
| Attrezzatura (stoviglie, posate, attrezzatura di cucina, ecc.) | 25%             |                  |
| Impianti generici (riscaldamento, condizionamento)           | 8%              |                  |
| Impianti specifici (igienici, cucina, frigorifero, ascensori, montacarichi, impianti telefonici, citofoni, campanelli e simili) | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

(23) Vedi, anche, l'art. 11, L. 27 dicembre 1997, n. 449, riportata alla voce Amministrazione del
patrimonio e contabilità generale dello Stato.

## Tabella dei coefficienti di ammortamento - Gruppo XX SERVIZI CULTURALI, SPORTIVI E RICREATIVI

**<u>Specie 1 - Teatri, cinematografi, sale da ballo e simili, campi sportivi, case da giuoco.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Edifici                                                      | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti termotecnici ed elettrici                           | 10%             |                  |
| Attrezzature (poltrone, ecc.)                                | 15,50%          |                  |
| Macchinari di proiezione ed impianto sonoro                  | 19%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 2 - Compagnie ed agenzie teatrali. Produzione, doppiaggio, sviluppo, stampa e noleggio films.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Fabbricati destinati all'industria (teatri, piazzali, strade) | 5,50%           |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti generici, produzione e trasporto energia            | 10%             |                  |
| Attrezzatura specifica (macchine da ripresa, gruppi elettrogeni, doppiaggio, registrazione sonora, sviluppo e stampa, ecc.) | 19%             |                  |
| Attrezzatura generica (officina,falegnameria,ecc.)           | 7,50%           |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

## Tabella dei coefficienti di ammortamento - Gruppo XXI SERVIZI SANITARI

**<u>Specie 1 - Ospedali, cliniche, sanatori, case di cura ed istituti similari privati.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Edifici                                                      | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Mobili ed arredamento                                        | 10%             |                  |
| Biancheria                                                   | 40%             |                  |
| Attrezzatura generica (stoviglie, posate, ecc.)              | 25%             |                  |
| Attrezzatura specifica                                       | 12,50%          |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

## Tabella dei coefficienti di ammortamento - Gruppo XXII SERVIZI IGIENICI ALLA PERSONA E DOMESTICI

**<u>Specie 1 - Servizi igienici e di estetica della persona. Alberghi diurni, istituti di igiene e di bellezza, barbieri, parrucchieri e simili.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Edifici                                                      | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Mobili ed arredamento                                        | 10%             |                  |
| Biancheria                                                   | 40%             |                  |
| Impianti specifici (igienici, riscaldamento, condizionamento, ecc.) | 8%              |                  |
| Attrezzatura generica                                        | 25%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Ambulanze                                                    | 25%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 2 - Impresa di smaltimento rifiuti (24).</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Edifici                                                      | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Impianti specifici di utilizzazione                          | 10%             |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

**<u>Specie 3 - Lavanderie, stiratorie, smacchiatorie, tintorie e servizi affini.</u>**

| Categoria                                                    | Aliquota civile | Aliquota fiscale |
| ------------------------------------------------------------ | --------------- | ---------------- |
| Edifici                                                      | 3%              |                  |
| Costruzioni leggere (tettoie, baracche, ecc.)                | 10%             |                  |
| Attrezzatura specifica                                       | 12,50%          |                  |
| Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante impiego di reagenti chimici | 15%             |                  |
| Mobili e macchine ordinarie d'ufficio                        | 12%             |                  |
| Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi telefonici elettronici | 20%             |                  |
| Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto interno, ecc.) | 20%             |                  |
| Autovetture, motoveicoli e simili                            | 25%             |                  |

## Attività precedentemente non specificate

**<u>1. Fiere e Rassegne.</u>**

   Fabbricati in muratura destinati a padiglioni per esposizione 10%
   Costruzioni in legno o in strutture mobili 20%
   Mobili comuni ed arredamento 10%
   Arredamento fiere (transenne, ecc.) 27%
   Mobili e macchine ordinarie d'ufficio 12%
   Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi
   telefonici elettronici
   20%
   Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto
   interno, ecc.) 20%
   Autovetture, motoveicoli e simili 25%

**<u>2. Altre attività.</u>**

   Edifici 3%
   Fabbricati destinati alla grande distribuzione 6%
   Costruzioni leggere (tettoie, baracche, ecc.) 10%
   Impianti e mezzi di sollevamento, carico e scarico, pesatura, ecc. 7 1/2 %
   Macchinari, apparecchi e attrezzature varie (compreso frigorifero, impianto di
   condizionamento e distributore automatico) 15%
   Stigliatura 10%
   Arredamento 15%
   Banconi blindati o con cristalli blindati 20%
   Impianti di allarme, di ripresa fotografica, cinematografica e televisiva 30%
   Impianti interni speciali di comunicazione e telesegnalazione 25%Impianti destinati al trattamento ed al depuramento delle acque, fumi nocivi, ecc. mediante
   impiego di reagenti chimici 15%
   Mobili e macchine ordinarie d'ufficio 12%
   Macchine d'ufficio elettromeccaniche ed elettroniche compresi i computers e i sistemi
   telefonici elettronici
   20%
   Autoveicoli da trasporto (autoveicoli pesanti in genere, carrelli elevatori, mezzi di trasporto
   interno, ecc.) 20%
   Autovetture, motoveicoli e simili 25%
   (24) Modificato dal D.M. 7 novembre 1992 (Gazz. Uff. 17 novembre 1992, n. 271).
   (25) Vedi, anche, l'art. 11, L. 27 dicembre 1997, n. 449, riportata alla voce Amministrazione del
   patrimonio e contabilità generale dello Stato.

## Da Fare/Segnalazioni


- da verificare come creare piani ammortamento differenti da "fa" non so come si faccia, di modo che si possano andare a generare ammortamenti convenzionali ad esempio fare popolare un ammortamento a metà valore per l' anno 1 oppure generare ad esempio un "superammortamento".

verificare la possibilità di impostare una tabella per importare situazione attuale cespiti di un cliente i dati da importare sono quelli che si evincono dall' immagine che riporto anche tra i report che chiamerei "scheda cespite"

[{{< figure src="/image/Cespiti-31.png"  width="850"  >}}](/image/Cespiti-31.png)

quindi dovrebbero essere questi i dati minimi da inserire.

| Matricola (codice) | Descr.cesp. | inizio poss. | val.storico | imp.agg. | ammort. | progr.amm. | res.da amm. |
| ------------------ | ----------- | ------------ | ----------- | -------- | ------- | ---------- | ----------- |
|                    |             |              |             |          |         |            |             |

in "importa cespite" ICE00 se in serisco i dati iniziali in realtà posso fare manualmente l' operazione di cari dati iniziali.

PS: non so come si capisca se tutti i cespiti in possesso siano ammortizzati e quindi se siano state fatte le registrazioni contabili relative.

### Esempi di Reportistica

di seguito inserisco tre immagini di report che mi sembrano abbastanza ben fatte in prima pagina l'immagine del programma di cui fanno parte.

[{{< figure src="/image/Cespiti-29.png"  width="850"  >}}](/image/Cespiti-29.png)

[{{< figure src="/image/Cespiti-30.png"  width="850"  >}}](/image/Cespiti-30.png)
[{{< figure src="/image/Cespiti-31.png"  width="850"  >}}](/image/Cespiti-31.png)


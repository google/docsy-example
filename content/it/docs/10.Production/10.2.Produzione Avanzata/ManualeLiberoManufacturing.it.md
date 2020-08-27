---
title: "Produzione Avanzata"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b></b>"
---
### PRODUZIONE

-   **1 REGOLE DI PRODUZIONE**

#### **1-1 Gestione delle risorse di produzione**

**(Manufacturing Resource Management)**

**Una risorsa di produzione è definita come tutto ciò che è necessario
per la produzione e la cui mancanza di disponibilità può causare il
mancato raggiungimento del piano di produzione.**

**Le risorse di produzione possono essere: impianti (plants), linee di
produzione (production lines), centri di lavoro (work center) e
stazioni di lavoro (work station).**

**Risponde principalmente alla domanda: dove viene prodotto il
prodotto?**

> **Capitolo 1 REGOLE DI FABBRICAZIONE 7 E-evolution Copyright ©**
 

#### **111 Tipo di risorsa (Resource Type)**

**La maschera Tipo di Risorsa è l\'opzione standard che viene utilizzata
per calcolare il tempo disponibile in una risorsa. Permette di inserire
l\'ora di inizio e l\'ora di fine per lo slot nei giorni lavorativi. Per
ulteriori informazioni, consultare il capitolo 16.**

[{{< figure src="/image/ManualeLiberoManufacturing0.png"  width="550"  >}}](/image/ManualeLiberoManufacturing0.png)
Figura 1.1.1 Gestione produzione \<Gestione ingegneria \<Produzione risorse \<Tipo di risorsa

> **Capitolo 1 REGOLE DI FABBRICAZIONE 8 E-evolution Copyright ©**

#### **1-1-2 Risorse di produzione (Manufacturing Resource)**

**La risorsa di produzione definisce una risorsa per un\'organizzazione.
Puoi introdurre tutte le risorse che desideri.**

**Il campo Tipo di risorsa consente di identificare la capacità di
questa risorsa.**

**Quando si seleziona la casella di controllo "Is Manufacturing
Resource", vengono visualizzati i campi seguenti: Tipo di risorsa di
produzione, Capacità giornaliera, Utilizzo percentuale, Tempo di
accodamento e Tempo di attesa.**

**Nel campo Tipo di Risorsa di Produzione è possibile selezionare una
risorsa tra Stazione di lavoro (Work Station), Linea di produzione
(Production Line), Centro di lavoro (Work Center) o Impianto (Plant).
Normalmente un gruppo di stazioni di lavoro (Work Station) sarà
integrato in un centro di lavoro (Work Center), un gruppo di centri di
lavoro in una linea di produzione (Production Line) e un gruppo di linee
di produzione in uno stabilimento (Plant). Questa relazione è costruita
in una gerarchia che viene utilizzata per accumulare la capacità
richiesta e disponibile dalla gerarchia inferiore a quelle superiori per
ciascuna risorsa.**

[{{< figure src="/image/ManualeLiberoManufacturing1.png"  width="700"  >}}](/image/ManualeLiberoManufacturing1.png)

> **Capitolo 1 REGOLE DI FABBRICAZIONE 9 E-evolution Copyright ©**

**La percentuale di utilizzo per una risorsa è definita come il tempo
richiesto per quella risorsa diviso per il tempo disponibile, il
risultato viene moltiplicato per 100. Il tempo di coda è il tempo che
normalmente deve attendere un\'operazione di ordine di produzione poiché
viene spostata in questa operazione fino a quando non inizia a
funzionare. Il tempo di attesa è il tempo che normalmente deve attendere
un\'operazione di ordine di produzione poiché è terminata fino a quando
non viene spostata all\'operazione successiva o al magazzino. Sia il
tempo di coda che il tempo di attesa immessi nella risorsa vengono
utilizzati come valori predefiniti per i nodi nel flusso di lavoro. Il
tempo giornaliero disponibile verrà calcolato per ogni giorno lavorativo
settimanale selezionato, quando si spunta lo slot del giorno. Il calcolo
per ottenere il tempo disponibile per un giorno sottrae il momento in
cui lo slot inizia dal momento in cui lo slot termina.**

[{{< figure src="/image/ManualeLiberoManufacturing2.png"  width="700"  >}}](/image/ManualeLiberoManufacturing2.png)

Figura 1.1.3 Gestione della produzione \<Gestione dell\'ingegneria

\<Produzione delle risorse

\<Risorse di produzione
>
> **Capitolo 1 REGOLE DI FABBRICAZIONE 10 E-evolution Copyright ©**

#### **1-1-2.a Prova questo**

**Creare 3 tipi di risorse di produzione ( Stazione di lavoro, linea di
produzione, centro di lavoro o impianto).
Immettere il nome del tipo di risorsa.**

**Attiva la checkbox del tempo disponibile per determinare il tempo di
utilizzo della risorsa**

**Attivare la checkbox giorni disponibili per determinare i giorni della
settimana in cui utilizzare la risorsa.**

**Creare una risorsa di produzione (Manufacturing Resource)**
**Immettere la ricerca chiave della risorsa di produzione Immettere il
nome dell\'organizzazione**

**Seleziona il tipo di risorsa che desideri utilizzare quelli già creati
nell\'attività precedente.**
**Scegli il negozio (punto di servizio) per desiderare la risorsa.**

> **Capitolo 1 REGOLE DI FABBRICAZIONE 11 E-evolution Copyright ©**

#### **1-2 Flussi di lavoro di produzione**

**Il flusso di lavoro di produzione (Routing) è uno strumento che ci
consente di definire le attività richieste per fabbricare un prodotto
tenendo conto della sequenza del processo, quanto tempo impiega
l\'attività (operazione) e dove dovrebbe essere fatto.**

**Risponde alla domanda: come dovrebbe essere realizzato il prodotto?**

> **Capitolo 1 REGOLE DI FABBRICAZIONE 12 E-evolution Copyright ©**

#### **1-2-1 Flussi di lavoro di produzione (Manufacturing Workflow)**

**La finestra Flussi di lavoro di produzione consente di definire il
Workfow per fabbricare un prodotto in qualsiasi organizzazione del
cliente (organizzazione \*) o in un\'organizzazione specifica.**

**È necessario utilizzare la scheda Flussi di lavoro di produzione per
inserire le informazioni generali, digitare il nome per identificare
questo flusso di lavoro specifico. Se la chiave di ricerca è uguale alla
chiave di ricerca del prodotto, questo WF sarà il Wf predefinito per il
prodotto. Quindi inserire una descrizione se lo si desidera. Spuntare la
casella di controllo "is Routing" e verranno visualizzati i campi Tipo
di processo e Risorsa.**
[{{< figure src="/image/ManualeLiberoManufacturing3.png"  width="700"  >}}](/image/ManualeLiberoManufacturing3.png)

Figura 1.2.1 Gestione della produzione \<Gestione dellaprogettazione \<Flusso di lavoro di produzione \<Flusso di lavoro di produzione
>
> **Capitolo 1 REGOLE DI FABBRICAZIONE 13 E-evolution Copyright ©**

**Il tipo di processo (Process Type) è selezionato tra diverse opzioni a
seconda delle caratteristiche**

**del processo che si desidera gestire. Il tipo di processo è solo un
riferimento e ha le**

**seguenti opzioni valide secondo la classificazione APICS:**

**Continuos Flow (Flusso continuo): il flusso continuo di
solito si riferisce alla produzione o alla lavorazione di fluidi,
rifiuti, polveri, metalli di base e altri articoli sfusi. Una raffineria
di petrolio greggio in vari prodotti petroliferi o una conduttura per
acqua, petrolio o gas naturale sono esempi di processi di produzione e
distribuzione a flusso continuo.**

**Dedicated Repetitive Flow (Flusso ripetitivo dedicato):
parti discrete come alberi e bielle e gruppi discreti come i
microcomputer possono essere prodotti mediante un processo di flusso
ripetitivo. Il termine dedicato implica che l\'impianto di produzione
produce solo un prodotto, comprese le variazioni di prodotto (come il
colore) che non richiedono alcun ritardo di installazione nel processo
di produzione.**

**Batch Flow (Flusso batch): è funzionalmente uguale al
continuo o al ripetitivo, tranne due o più prodotti fabbricati nella
stessa struttura. A causa dei lunghi tempi di installazione
nell\'officina del flusso batch, i cicli di produzione per ciascun
prodotto durano in genere diverse ore o diversi giorni.**

> **Capitolo 1 REGOLE DI FABBRICAZIONE 14 E-evolution Copyright ©**

**Repetitive Flow Mixed Model (Modello misto a flusso
ripetitivo): viene anche utilizzato per produrre due o più modelli.
Tuttavia, il tempo di commutazione tra i modelli è minimo e i diversi
modelli sono mescolati sulla stessa linea.**

**Job Shop: è caratterizzato dall\'organizzazione di
attrezzature simili per funzione (come fresato, forato, tornito,
forgiatura e assemblaggio). Man mano che i lavori passano dalla risorsa
di produzione alla risorsa di produzione, viene eseguito un diverso tipo
di operazione in ciascuna risorsa di produzione.**

**Fixed Site (progetto): ha la caratteristica principale
che i materiali, gli strumenti e il personale sono portati alla risorsa
di produzione in cui verrà fabbricato il prodotto. Il campo Risorsa è un
riferimento alla risorsa di produzione in cui verrà eseguito il lavoro
(Plant).**

**Nella Dimensione lotto (Batch Size) si specifica la quantità del
prodotto che ogni lotto può effettuare. Se stiamo per produrre una
quantità maggiore rispetto a 1 lotto, il sistema pianificherà diversi
lotti nella risorsa di produzione (linea di produzione), la quantità di
ciascuno verrà prelevata dalla quantità della confezione per ottenere la
quantità MO richiesta. Il campo Livello di accesso ai dati mostra il
livello di accesso a questo record.**

> **Capitolo 1 REGOLE DI FABBRICAZIONE 15 E-evolution Copyright ©**

**Nei campi:**

**Workflow Responsible (Responsabile del flusso di lavoro)
si inserisce la persona, il ruolo o**

**l\'organizzazione responsabile del flusso di lavoro.**

**Priority (priorità) indica quanto è**

**importante questa entità, le voci valide sono Alta, Media o Bassa.**

**Valid From-To (Nel campo Valido Da-A) viene registrato
il periodo di tempo in cui il flusso di lavoro è valido.**

**Il numero del documento è assegnato dal sistema e
proviene dalla sequenza definita nell\'opzione di menu Sequenza
documenti.**

**L\'autore è la persona che ha creato il record.**

**L\'attività iniziale mostra la prima attività (nodo) del
flusso di lavoro.**

**Infine, nella scheda Flusso di lavoro di produzione puoi vedere il
gruppo di campi Tempo, i campi inclusi in questo gruppo sono:**

**Accomulated Time (Tempo accumulato): attualmente è un
riferimento in cui si inserisce il tempo**

**totale necessario per eseguire ogni attività di questo WF.**

> **Capitolo 1 REGOLE DI FABBRICAZIONE 16 E-evolution Copyright ©**

**Queue Time (Tempo di coda): attualmente è un riferimento
in cui si inserisce il tempo di coda accumulato per questo WF. Il tempo
di coda è il tempo normalmente impiegato dal completamento
dell\'operazione precedente, oppure i componenti sono stati emessi dal
magazzino, fino a quando l\'operazione corrente in un ordine di
produzione inizia il suo processo.**

**Il Setup Time Currently (tempo di installazione attuale)
è un riferimento in cui si immette il tempo di installazione accumulato
per questo WF. Il tempo di installazione è il tempo necessario per
eseguire le attività necessarie in una risorsa di produzione per poter
avviare il processo di produzione.**

**Duration WF (Durata WF): attualmente è un riferimento in
cui inserire la Durata accumulata per questo WF. La durata WF è la
durata normale di un lavoro, in unità di durata.**

**Duration Unit (unità di durata) è l\'unità di misura del
tempo per questo gruppo di campi (ad es. Ore, minuti ecc.). Ogni volta
registrato in questo flusso di lavoro verrà fatto riferimento a questa
unità di durata.**

**Waiting Time (Tempo di attesa): attualmente è un
riferimento in cui inserire il tempo di attesa accumulato per questo WF.
Il tempo di attesa è il tempo in cui un lavoro rimane in una risorsa di
produzione fino a quando non viene spostato all\'operazione successiva o
al magazzino in cui l\'operazione è l\'ultima.**

> **Capitolo 1 REGOLE DI FABBRICAZIONE 17 E-evolution Copyright ©**

**[Move Time]{.underline} (Tempo di spostamento): attualmente è un
riferimento in cui si inserisce il tempo di spostamento accumulato per
questo WF. È il tempo stimato per spostare il materiale considerato
dalle risorse di produzione.**

**Facendo clic su Convalida flusso di lavoro in basso si verifica che il
flusso di lavoro non contenga errori.**
[{{< figure src="/image/ManualeLiberoManufacturing4.png"  width="450"  >}}](/image/ManualeLiberoManufacturing4.png)
Figura 1.2.1.2 Convalida inferiore del flusso di lavoro

**Al termine della convalida del processo, viene visualizzato il
messaggio corretto (OK) se il flusso di lavoro è corretto (con una
verifica limitata).**
[{{< figure src="/image/ManualeLiberoManufacturing5.png"  width="150"  >}}](/image/ManualeLiberoManufacturing5.png)
Figura 1.2.1.3 Messaggio OK

**Successivamente è necessario introdurre ciascuna delle operazioni che
prendono parte alla produzione del prodotto, per questo si utilizza la
scheda attività.**

> **Capitolo 1 REGOLE DI FABBRICAZIONE 18 E-evolution Copyright ©**

**Nella scheda attività viene introdotto il Nome per identificare le
operazioni dal routing di produzione. Se lo si desidera, fornire una
descrizione per il funzionamento.**

**Dall\'elenco di "selezione Risorsa" selezionare la risorsa di
produzione (precedentemente definita) in cui si desidera eseguire
l\'operazione. Per il calcolo del costo del prodotto, il tasso di
risorsa è ricavato dall\'elemento di costo introdotto nella finestra
Costing del prodotto.**

**Se la checkbox "Is Milestone" è selezionata significa
che al completamento dell'Ordine di Produzione viene generato
automaticamente l'Activity Control Report senza doverlo fare
manualmente. Se impostato a Yes indicherà che in questa operazione verrà
indicato il tempo reale utilizzato nell\'operazione e che per tutte le
operazioni precedenti, fino all\'ultima operazione di controllo, verrà
utilizzata l\'ora standard come reale tempo. (questa funzione verrà
utilizzata nel modulo di controllo del piano di produzione).**
[{{< figure src="/image/ManualeLiberoManufacturing6.png"  width="650"  >}}](/image/ManualeLiberoManufacturing6.png)


**Se la checkbox "is subcontractiong" (conto lavoro esterno) è
selezionata, indica che questa operazione verrà eseguita da una risorsa
esterna.**

> **Capitolo 1 REGOLE DI FABBRICAZIONE 19 E-evolution Copyright ©**

**Quando si inseriscono le date nei campi Valido da - A
viene indicato il periodo di tempo in cui questa operazione dovrà essere
considerata per l\'elaborazione del prodotto.**

**Nel campo Responsabile flusso di lavoro, immettere il
responsabile per questo nodo. Può essere uno dei seguenti tipi; Umano,
Organizzazione o Rotolo.**

**Unit Cycles (cicli unità) è il numero di prodotti che
possono essere prodotti nell\'unità di misura temporale dalla risorsa di
produzione. Questi dati vengono utilizzati al posto del campo
"Durata" in cui si immette il tempo richiesto per eseguire
un\'operazione per un prodotto.**

**Overlap Units (Sovrapponi unità), è il numero minimo di
prodotti che devi completare nell\'attività corrente prima di poter
continuare con il nodo successivo.**

**Working Time (Orario di lavoro): tempo di esecuzione
della simulazione del flusso di lavoro. Attualmente è solo un campo di
riferimento.**

**Queue time (tempo di coda) è il tempo in cui il prodotto
dovrà attendere prima di iniziare l\'elaborazione per questa attività.**

> **Capitolo 1 REGOLE DI FABBRICAZIONE 20 E-evolution Copyright ©**

**Setup Time (tempo di installazione) è il tempo richiesto
per eseguire le azioni di preparazione della risorsa specificata
nell\'attività per poter avviare il processo di produzione. Per eseguire
il programma di produzione utilizzando la tecnica sia in avanti che
all\'indietro, il tempo di impostazione viene considerato una sola volta
per ogni attività nell\'ordine di produzione.**

**Duration (Durata): il tempo standard pianificato per
produrre un\'unità di prodotto in un nodo.**

**Waiting Time (Tempo di attesa): è il tempo in cui un
lavoro rimane in una risorsa di produzione dopo che l\'attività
è terminata fino a quando non viene spostata all\'operazione successiva, o al magazzino. 
(ad es. per asciugare)**

**Move Time è il tempo che un lavoro trascorre in transito
da un\'attività all\'altra nell\'impianto.**

**Dopo aver inserito tutti i nodi richiesti (operazioni) per un processo
di fabbricazione, è necessario impostare la sequenza di attività,
selezionando la scheda Transizione.**
[{{< figure src="/image/ManualeLiberoManufacturing7.png"  width="700"  >}}](/image/ManualeLiberoManufacturing7.png)
Figura 1.2.1.6 Gestione della produzione \<Gestione della progettazione \<Flusso di lavoro di produzione

**Le informazioni richieste per stabilire la sequenza dei nodi si
trovano nella scheda Attività e nel campo Avvia attività della scheda Flusso di lavoro.**

**Per poter eseguire un programma di produzione sia in avanti che
all\'indietro, il sistema utilizza le caratteristiche impostate nella scheda attività e
la sequenza dalla scheda Sequenza.**

> **Capitolo 1 REGOLE DI FABBRICAZIONE 21 E-evolution Copyright ©**

**La pianificazione diretta utilizza la data di inizio della prima
operazione e utilizza i tempi richiesti in ciascuna operazione per
pianificare le date di ciascuna operazione nella sequenza operativa
impostata nel flusso di lavoro. Considera il tempo disponibile in
ciascuna risorsa per pianificare le date. La pianificazione a ritroso
utilizza la data di scadenza dell\'ultima operazione e utilizza i tempi
richiesti in ciascuna orazione per pianificare le date di ciascuna
operazione nelle operazioni opposte alla sequenza impostata nel flusso
di lavoro. Considera il tempo disponibile in ciascuna risorsa per
pianificare le date.**

> **Capitolo 1 REGOLE DI FABBRICAZIONE 22 E-evolution Copyright ©**

#### **1-2-2 Editor del flusso di lavoro**

**Con Work Flow Editor è possibile visualizzare in modo grafico le
operazioni del processo di produzione e la sua sequenza di esecuzione.
Allo stesso tempo è possibile visualizzare le informazioni registrate
nei campi: Nome, Descrizione e Guida dalla finestra Flusso di lavoro.**

**Quando si seleziona l\'icona dello zoom, viene visualizzata la
finestra Flusso di lavoro.**
[{{< figure src="/image/ManualeLiberoManufacturing8.png"  width="450"  >}}](/image/ManualeLiberoManufacturing8.png)
Figura 1.2.2 Editor di WorkFlow per la produzione

> **Capitolo 1 REGOLE DI FABBRICAZIONE 23 E-evolution Copyright ©**

#### **1-2-2.a Prova questo**

##### - **Crea flusso di lavoro di produzione**

**Immettere la chiave di ricerca e il nome del flusso di lavoro che si desidera creare.**

**Seleziona il tipo di flusso di lavoro che verrà utilizzato (Produzione).
Scegli la risorsa di impianto (precedentemente creata) con cui lavorare il flusso di lavoro.**

**Immettere il nome dell\'autore che crea il flusso di lavoro. 
Delle informazioni richieste nei seguenti campi, compilare il campo appropriato.**

**Nel campo dell\'operazione iniziale, le informazioni saranno
introdotte alla fine dei dati di transizione del carico. Nella scheda
operazioni, immettere la chiave di ricerca e il nome dell\'operazione
necessaria al flusso di lavoro. Scegli la risorsa (tra quelle
precedentemente create) in cui l\'operazione deve essere eseguita.**

**Se il flusso di lavoro richiede un prodotto e / o strumenti,
inserire rispettivamente i dati necessari nelle schede prodotto e
strumenti. Se l\'operazione è un processo esterno, inserire le
informazioni sul prodotto. Dopo aver immesso tutte le operazioni
necessarie, è necessario introdurre la sequenza delle operazioni nella
scheda della transazione, in cui si immette l\'operazione successiva
per iniziare l\'operazione.**

-   **La prima operazione del flusso di lavoro è impostata nella scheda
    del flusso di lavoro di produzione.**

-   **Per vedere il flusso di lavoro creato, accedere all\'opzione di
    menu dell\'editor del flusso di lavoro.**

> **Capitolo 1 REGOLE DI FABBRICAZIONE 24 E-evolution Copyright ©**

![](media/image33.png){width="1.4222222222222223in"
height="0.5388888888888889in"}

#### **1-3 Distinte Materiali e formula (BOM)**

-   **un elenco di tutti i sottoassiemi, intermedi, parti e materie
    prime che vanno in un assieme padre che mostra la quantità di
    ciascun prodotto per creare un assieme. Esistono una varietà di
    formati di visualizzazione della distinta base, tra cui distinta
    base a livello singolo, distinta base rientrata, modulare
    (pianificazione), distinta base costata, ecc. Può anche essere
    chiamata \"formula\", \"ricetta\", \"ingredienti elenco \"in alcuni
    settori.**

#### - Risponde alla domanda, quali sono i componenti del prodotto?

#### **1-3-1 distinte materiali e formula**

**Nella scheda Distinte materiali sono richiesti i seguenti campi per
identificare in modo specifico le distinte materiali: cliente,
organizzazione, chiave di ricerca e nome.**

**Inoltre, con il numero del documento di modifica tecnica è possibile
tenere traccia delle modifiche apportate alla distinta componenti. La
sequenza della BOM viene allocata dal sistema utilizzando la sequenza
immessa per questo tipo di documento. Nella scheda Distinta materiali
sono richiesti i seguenti campi: Cliente, Organizzazione, Chiave di
ricerca e Nome per identificare in modo univoco la distinta materiali e
il Numero del documento di modifica tecnica utilizzati per tenere
traccia della modifica.**

**Il campo Revisione mostra il numero di revisioni effettuate per questa
BOM e il Valido da e Valido per indicare il periodo valido per questa
BOM (in quel periodo è possibile utilizzare la BOM in un ordine di
fabbricazione).**
[{{< figure src="/image/ManualeLiberoManufacturing9.png"  width="650"  >}}](/image/ManualeLiberoManufacturing9.png)
Figura 1.3.1 Gestione della produzione \<Gestione dell\'ingegneria
\<Distinta materiali e formula \<Distinta materiali e formula

> **Capitolo 1 REGOLE DI FABBRICAZIONE 26 E-evolution Copyright ©**

**Il campo del prodotto insieme all\'istanza del prodotto identifica il
prodotto principale. Viene inoltre introdotta l\'unità di misura di
produzione che verrà presa in considerazione per le quantità immesse per
i componenti.**

**Il tipo di distinta base è lo stesso utilizzato nella finestra del
prodotto, nella scheda BOM per il prodotto principale. Le opzioni valide
sono Attivo attivo, Crea su kit, Crea su ordine, Configura e ripara
prodotto. Per ulteriori informazioni sulla distinta componenti,
consultare il capitolo 5 del manuale dell\'utente Adempiere.**
[{{< figure src="/image/ManualeLiberoManufacturing10.png"  width="650"  >}}](/image/ManualeLiberoManufacturing10.png)
Figura 1.3.1.2 Gestione della produzione \<Gestione dell\'ingegneria
\<Distinta materiali eformula \<Distinta materiali e formula**

**Quindi si introducono le informazioni dettagliate intorno alla BOM per
ogni componente usando la scheda BOM. Le informazioni richieste nella
distinta materiali sono il figlio del prodotto e l\'istanza del set di
attributi. Le date valide da e valide fino indicano il periodo di tempo
valido per utilizzare la distinta base in un ordine di produzione.**
   
> **Capitolo 1 REGOLE DI FABBRICAZIONE 27 E-evolution Copyright ©**

**L\'elenco di selezione del tipo di componente presenta le seguenti
opzioni: Componente: identifica una materia prima, un ingrediente, una
parte o un sottoassieme che va in un assieme di livello superiore,
composto o altro.**

**Byproduct: questa entità è un prodotto non pianificato ottenuto come
conseguenza di un altro processo di produzione. Ha un valore di vendita
ma è minimo.**

**Fantasma: indica che il prodotto è un assieme fittizio, vale a dire un
insieme di componenti raggruppati solo per facilitare l\'analisi in modo
separato dal resto della BOM. Quando la pianificazione MRP genera un
requisito del fantasma e il progetto non è disponibile, il processo
passa al livello inferiore e avvia un nuovo ciclo MRP ma non crea ordini
pianificati per il prodotto fantasma.**

**Imballaggio: questo prodotto non verrà preso in considerazione per
calcolare la quantità totale di componenti quando la casella di
controllo IsQtyPercentage è selezionata.**

**Pianificazione: il prodotto principale verrà utilizzato per il
processo di pianificazione delle diverse opzioni di prodotti simili.
(es. 30% di pane con fibra e 70% di pane senza fibra) Strumenti: il
prodotto è uno strumento che verrà utilizzato in un\'operazione di
produzione.**

> **Capitolo 1 REGOLE DI FABBRICAZIONE 28 E-evolution Copyright ©**

**Se si fa clic su IsQtyPercentage significa che è necessario introdurre
la quantità del componente come percentuale di tutti i componenti. Se non si fa
clic sulla casella di controllo IsQtyPercentage, è necessario introdurre nel
campo Qtà la quantità del componente per produrre un\'unità di misura del prodotto
principale.**

**Se si fa clic su Libretto degli assegni critico, un Ordine di
produzione non verrà rilasciato nell\'officina se questo componente non
è disponibile. Nel campo Test immettere una percentuale di componenti
che verranno utilizzati per effettuare un test. Il campo Scarto viene
introdotto come fattore percentuale componente che non dovrebbe essere
utile come parte della produzione principale.**

**Il campo Metodo di emissione consente di selezionare tra Issue o
Backflush, se si sceglie l\'emissione sono necessari due passaggi, prima
di emettere i componenti dal magazzino e dopo la produzione è necessario
un secondo movimento del magazzino per ricevere il prodotto finito nel
magazzino.**

**Se si sceglie il backflush in un unico movimento, si riceve il
prodotto finito nel magazzino e si emettono automaticamente i componenti
richiesti dal magazzino.**

> **Capitolo 1 REGOLE DI FABBRICAZIONE 29 E-evolution Copyright ©**

**Il gruppo Backflush viene utilizzato per raggruppare i componenti che
si desidera emettere insieme in un processo Backflush.**

**Il lead time offset è il numero di giorni dopo l\'inizio della
produzione del prodotto finito quando è necessario questo componente.**

**La previsione è la percentuale che prevediamo di utilizzare questo
componente per produrre il prodotto finito. Viene utilizzato per
pianificare i processi di acquisizione dei componenti e presenta un tipo
di distinta base di pianificazione della distinta base e non è possibile
utilizzare questa distinta base per un ordine di produzione.**

> **Capitolo 1 REGOLE DI FABBRICAZIONE 30 E-evolution Copyright ©**

#### **1-3-2 Distinta materiali e formula**

**Viene visualizzato il menu delle opzioni Revisione formula e
distinta componenti. in due diversi pannelli, la relazione
padre-componente per il prodotto è stata immessa nel campo Prodotto.**

-   **necessario introdurre il prodotto principale che si desidera
    vedere i suoi componenti, quindi fare clic sul pulsante OK, quindi
    trascinare il margine sinistro del pannello a destra e si avranno i
    due pannelli.**

**Quando è necessario consultare un\'implosione, fare clic sulla
casella di spunta dell\'implosione e inserire il componente che si
desidera consultare e selezionare la casella di spunta Implosione. Il
pannello di sinistra mostra le gerarchie BOM in una struttura ad
albero. Il pannello di destra mostra le informazioni collegate alla
BOM per ogni prodotto in essa contenuto. Per ulteriori informazioni
sul significato dei campi, consultare la sezione superiore di questo
capitolo.**
[{{< figure src="/image/ManualeLiberoManufacturing11.png"  width="750"  >}}](/image/ManualeLiberoManufacturing11.png)
Figura 1.3.2 Gestione della produzione \<Gestione dell\'ingegneria
\<Distinta materiali e formula \<BOM e informazioni sulla formula

> **Capitolo 1 REGOLE DI FABBRICAZIONE 31 E-evolution Copyright ©**

#### **1-3-2.a Prova questo**

**Imposta la distinta base e la formula di un prodotto.**

**Immettere il prodotto, la chiave di ricerca e il nome per
identificare in modo univoco la distinta materiali.**

**Successivamente verranno introdotte le caratteristiche dei
componenti del prodotto.**

**Nel tipo di campo BOM selezionare dall\'elenco l\'opzione
attualmente attiva. Nel campo BOM utilizzata selezionare l\'opzione di
produzione. Immettere il nome del prodotto figlio e l\'istanza del set
di attributi. Selezionare la durata di conservazione del prodotto
figlio, inserire la quantità di componente del prodotto richiesta.**

-   **Nella finestra del prodotto (Gestione materiali \<Regole di
    gestione dei materiali \<Prodotto) nella scheda BOM è possibile
    visualizzare le distinte materiali per un prodotto, che vengono
    create nella finestra BOM (Gestione produzione \<Gestione ingegneria
    \<Distinta materiali e formula \<Fatture di materiali e formula).**

> **Capitolo 1 REGOLE DI FABBRICAZIONE 32 E-evolution Copyright ©**

### **2 Pianificazione della Produzione**

**Prima di poter eseguire i processi di produzione, è necessario
pianificare le attività che devono essere svolte per garantire che i
prodotti possano essere ottenuti alla giusta quantità e tempo al fine di
non avere un eccesso di inventario a lungo nel magazzino, o al contrario
, per causare ritardi nelle spedizioni a causa della carenza di
componenti nell\'ordine di produzione. Alcuni altri argomenti da
prendere in considerazione sono i costi di produzione e la capacità di
spedizione di prodotti di buona qualità.**

**Usando la pianificazione della produzione rispondi alla domanda:
quando e quanti prodotti dobbiamo ottenere?**

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 33 E-evolution Copyright©**

#### **2-1 Pianificazione dei dati**

#### - **2-1-1 Prodotti di pianificazione**

**Oltre ai dati caricati nella finestra Prodotto, in cui sono definite
le caratteristiche di ciascun prodotto, nella Finestra Pianificazione
prodotto inserisci le informazioni sul prodotto che serviranno come base
per eseguire gli algoritmi di Pianificazione fabbisogno di materiali,
insieme a MPS (Produzione principale Programma), ordini aperti e
inventari.**
[{{< figure src="/image/ManualeLiberoManufacturing12.png"  width="650"  >}}](/image/ManualeLiberoManufacturing12.png)
Figura 2.1 Gestione della produzione \<Gestione della pianificazione\<Pianificazione del prodotto \<Dati di pianificazione del prodotto

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 34 E-evolution Copyright©**

**Nella scheda Pianificazione Prodotto è possibile inserire i seguenti
campi:**

**Magazzino: luogo in cui individuare e controllare i
prodotti**

**Risorsa: una risorsa di produzione è un luogo in cui
verrà realizzato un prodotto.**

**Il nome BOM/Formula che introduci in questa finestra sarà considerato
la BOM predefinita per produrre il prodotto in questa
Organizzazione-Impianto-Magazzino. Se non si compila questo campo, la
distinta base e la formula predefinite per l\'entità saranno la distinta
base / la formula con lo stesso nome del prodotto.**

**Il flusso di lavoro (Workflow) introdotto in questa
finestra sarà considerato il flusso di lavoro predefinito per produrre
il prodotto in questa organizzazione-pianta-magazzino. Se non si compila
questo campo, il flusso di lavoro predefinito per l\'entità sarà il
flusso di lavoro con lo stesso nome del prodotto.**

**Quando si fa clic sulla checkbox "Is MPS" si indica che
il prodotto in questo magazzino-organizzazione potrebbe essere richiesto
per un ordine previsionale, di vendita o di produzione. (Master Plan
Schedule)**

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 35 E-evolution Copyright©**

**Se si spunta la checkbox "Crea plan" indica che MRP deve
creare gli ordini pianificati per questo
magazzino-organizzazione-prodotto se non si fa clic sulla checkbox, è
necessario utilizzare la scheda Replenishment nella finestra del
prodotto e controllare il livello di inventario utilizzando il Replenish
Report.**

**Se la checkbox "Required Calculated MRP" è selezionata,
ciò significa che è stata apportata una modifica ad alcuni elementi che
influiscono sul calcolo MRP per questo prodotto, ad esempio distinta
base, ordini, inventario, MPS, ecc. E pertanto è necessario ricalcolare
l\'MRP per modificare la pianificazione Ordini alle nuove condizioni e
per ottenere i messaggi di azione aggiornati.**

**Il Time Fence è il numero di giorni da quando si esegue
il processo MRP all\'interno del quale il sistema non deve modificare
gli ordini pianificati. Il sistema genererà messaggi di azione che
avvertono se un certo ordine deve essere modificato o creato nella
barriera temporale.**

**Nel campo "Promised Delivery Time" (Termine di consegna
promesso) è necessario immettere il numero medio di giorni per ricevere
il prodotto nel magazzino poiché si approva la richiesta o l\'ordine di
produzione fino a quando non si riceve il materiale nel magazzino. Se il
prodotto viene acquistato, è necessario registrare i giorni di
calendario richiesti poiché si effettua l\'OP fino a quando non si
riceve il materiale in magazzino. Se il prodotto è fabbricato nel tuo
impianto, devi registrare il numero di giorni lavorativi da quando
rilasci il MO fino a quando non ricevi il materiale in magazzino.**

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 36 E-evolution Copyright©**

**Transfert Time (Il tempo di trasferimento) è il numero
di giorni in cui il prodotto deve essere spostato da un magazzino a un
altro.**

**Order Policy (La politica degli ordini) è riferita al
modo in cui MRP deve adattare l\'ordine pianificato alle esigenze
dell\'organizzazione, del magazzino e delle risorse. Le opzioni valide
sono:**

**Quantità ordine fissa (Fixed Order), lotto per lotto (Lot For Lot)
e quantità ordine periodo (Period Order Quantity)**

**Utilizzare Quantità ordine fissa "Fixed Order Qty"
quando è sempre necessario richiedere la stessa quantità di prodotto,
questa quantità viene inserita nel campo "Order Qty" Qtà
ordine.**

**Se la politica dell\'ordine non è "Fixed Order Qty" e si
immette una quantità nel campo "Order Qty", questa quantità è la
Quantità ordine economico.**

**La politica del "Lot for Lot" indica che il processo MRP
deve generare un ordine pianificato per ogni domanda non soddisfatta.**

**La politica "Period Order Qty" si riferisce al modo in
cui MRP crea un singolo ordine pianificato con tutti i requisiti netti
per un determinato numero di giorni. questi giorni vengono inseriti nel
campo "Order Period".**

**Se si spunta la casella "Is Issue", quando questo
prodotto è un componente di un MO, verrà emesso dal magazzino se non si
spunta la casella di controllo, questo componente verrà prelevato
dall\'inventario dell\'officina.**

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 37 E-evolution Copyright©**

**Se si spunta la casella "Is Phantom", indica che il
prodotto è un assieme virtuale, vale a dire quando la pianificazione MRP
richiede un fantasma ed è disponibile MRP lo prende come fornitura ma se
la quantità disponibile richiesta non è completa, invece di generare un
ordine pianificato per questo prodotto fantasma MRP cercare i componenti
e continuare il processo.**

**Se un importo è registrato in "Order Qty" significa che
si tratta della dimensione del lotto economico. Quando si inserisce una
quantità nel campo "Order Pack Qty", gli ordini
pianificati devono essere creati in multipli di questa quantità, ciò è
utile quando il venditore vende solo quantità fisse di prodotti o
quando, per effetto del calcolo MRP, si ottiene una frazione di prodotti
che deve essere ottenuto in quantità intere.**

**Quantità Minima Ordine viene utilizzata quando gli
ordini devono essere eseguiti almeno per questa quantità a causa delle
politiche del fornitore o delle limitazioni di fabbricazione. Il
processo MRP utilizzerà questa quantità quando l\'ordine pianificato
calcolato è per una quantità inferiore alla quantità minima
dell\'ordine, quindi MRP crea l\'ordine pianificato per la quantità
minima dell\'ordine.**

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 38 E-evolution Copyright©**

**Il sistema genera un messaggio che avverte questa variazione di
quantità. "Ordine Massimo" è la quantità massima
dell\'ordine e viene utilizzata quando gli ordini devono essere
eseguiti al massimo per tale quantità a causa delle politiche del
fornitore o delle limitazioni del magazzino. Il processo MRP
utilizzerà la quantità calcolata per creare l\'ordine pianificato ma
genera un messaggio che avverte che la quantità è maggiore della
quantità massima.**

**Nel campo "Working Time" (orario di lavoro) inserisci il tempo
accumulato (utilizzando il Tempo di consegna promettente) nel percorso
critico della distinta base per questo prodotto.**

**E' il tempo necessario per produrre il prodotto come se non avessi
alcun componente a portata di mano.**

**Nel campo "Yeld Field" (Rendimento) inserisci la
percentuale del prodotto che ti aspetti soddisfi le specifiche QA
rispetto alla quantità totale da produrre.**

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 39 E-evolution Copyright©**

#### **2-1-2 Creazione della pianificazione del prodotto**

**Per facilitare il caricamento della pianificazione dei dati di
prodotti simili, è possibile eseguire il processo Crea pianificazione
del prodotto e questo processo creerà il registro di pianificazione dei
dati per ogni prodotto che si adatta ai parametri: Categoria di
prodotto, Magazzino e Risorsa. Viene visualizzata una finestra di
dialogo che informa sul processo di caricamento globale dei dati.**
[{{< figure src="/image/ManualeLiberoManufacturing13.png"  width="350"  >}}](/image/ManualeLiberoManufacturing13.png)
Figura 2.1.2 Gestione produzione \<Gestione pianificazione \<Pianificazione prodotto
\<Crea pianificazione prodotto

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 40 E-evolution Copyright ©**

**Fare clic sul pulsante OK e verrà visualizzato il modulo (figura 2.1.3).**
[{{< figure src="/image/ManualeLiberoManufacturing14.png"  width="450"  >}}](/image/ManualeLiberoManufacturing14.png)

-   **necessario indicare i parametri di pianificazione definiti
    nell\'ultima sezione per ogni categoria di prodotto, magazzino e set
    di risorse. Ogni prodotto che corrisponde a questi tre parametri
    avrà un record di pianificazione dei dati con gli stessi valori di
    pianificazione dei dati inseriti in questo modulo. Il significato
    dei campi è spiegato nella sezione precedente di questo capitolo.**

Figura 2.1.3 Gestione produzione \<Gestione pianificazione \<Pianificazione prodotto \<Crea pianificazione prodotto

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 41 E-evolution Copyright©**

#### **2-1-2.a Prova questo**

**Registrare i dati o le informazioni sulla pianificazione del
prodotto come base per l\'implementazione di MRP e PMP**

**Seleziona il prodotto a cui inserirà le informazioni per la pianificazione.**\
**Nella scheda Pianificazione prodotto inserire il magazzino in cui verrà verificata l\'esistenza di quel prodotto.**

**Immettere la risorsa in cui è stato prodotto il prodotto. Seleziona
la distinta base e la formula e il flusso di lavoro che corrisponde al
prodotto. Questa informazione è già stata inserita nelle
attività precedenti.**

**Selezionare il campo è PMP, se il prodotto è una domanda
indipendente e dovrebbe far parte del PMP e selezionare se si desidera
che la pianificazione MRP crei ordini pianificati per questo
prodotto.**

**Seleziona la politica di ordinazione, in questo momento seleziona
Quantità-Periodo-Ordine.**

**Dalle informazioni richieste nei seguenti campi, compila quelli che ritieni necessari.**

-   **Per facilitare l\'inserimento della pianificazione dei dati di
    prodotti simili, è possibile utilizzare il processo di
    pianificazione del prodotto e caricare i dati per un gruppo di
    prodotti.**

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 42 E-evolution Copyright©**

#### **2-2 MRP (Pianificazione fabbisogno di materiali).**

**MRP è un insieme di tecniche che utilizza distinte materiali, dati di
inventario, ordini e programma di produzione principale per calcolare i
requisiti del materiale. Crea ordini pianificati per bilanciare domanda
e offerta di prodotti. MRP fornisce raccomandazioni per l\'accoglienza
dei materiali nelle giuste quantità e nelle date giuste per soddisfare
il Master Production Schedule, nel modo più efficiente.**

#### **2-2-1 Calcola livello basso**

**Questo processo calcola e registra il livello più basso di un prodotto
all\'interno di qualsiasi BOM. Viene utilizzato nei calcoli MRP e deve
essere eseguito quando si immette una nuova BOM.**

#### **2-2-2 Crea record MRP**

**Questo processo ricrea la domanda, approva e apre gli ordini per un
prodotto.**

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 43 E-evolution Copyright©**

![](media/image71.png){width="5.272916666666666in"
height="1.836111111111111in"}

**2-2-3 Calcolo del piano materiale (Calculate Material Plan)**

**Viene visualizzata una finestra di dialogo che informa che inizierà il
processo di Calcola piano materiali. Fai clic sul pulsante OK**

**Quando si seleziona OK, apparirà la finestra della figura 2.2.1.**
[{{< figure src="/image/ManualeLiberoManufacturing15.png"  width="650"  >}}](/image/ManualeLiberoManufacturing15.png)
Figura 2.2.1 Gestione della produzione \<Gestione della pianificazione
\<MRP \<Calcola piano materiale

**Viene visualizzato un modulo che richiede di accedere
all\'organizzazione per la quale si desidera creare un piano materiale e
la versione di questo piano. Puoi avere diverse versioni in modo tale da
poter decidere la versione più conveniente che desideri utilizzare.**
[{{< figure src="/image/ManualeLiberoManufacturing16.png"  width="450"  >}}](/image/ManualeLiberoManufacturing16.png)
Figura 2.2.1.1 Gestione della produzione \<Gestione della pianificazione \<MRP \<Calcola
piano materiale

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 44 E-evolution Copyright©**

#### **2-2-4 Informazioni MRP**

**Nella voce si inserisce il Prodotto, lo stabilimento, il magazzino e
il periodo di tempo in cui si desidera verificare le richieste e le
forniture. Come di consueto, se si lascia in bianco un parametro
verranno prese in considerazione tutte le possibilità. Quindi premi il
pulsante di aggiornamento e vengono visualizzati due set di dati: nel
pannello superiore vengono visualizzati i dati di pianificazione del
prodotto e il prodotto a portata di mano. In quello inferiore sono
mostrate le informazioni intorno alla risorsa di produzione in cui verrà
prodotto il prodotto, la domanda e l\'offerta di magazzino e le
informazioni per entrambi i documenti di domanda e offerta. I campi
visualizzati sono:**

**I requisiti lordi sono la quantità richiesta. La fonte della domanda
può essere una domanda indipendente (Ordine di vendita, Previsione) o i
componenti richiesti per un ordine di produzione (domanda dipendente).**

**Data promessa è la data di scadenza per la domanda o l\'offerta. Le
ricevute pianificate mostra le quantità degli ordini di fornitura che
verranno ricevute con la data di scadenza. La fonte delle entrate
pianificate può essere un ordine di acquisto aperto e un ordine di
produzione aperto.**
[{{< figure src="/image/ManualeLiberoManufacturing17.png"  width="550"  >}}](/image/ManualeLiberoManufacturing17.png)
Figura 2.2.4 Gestione della produzione \<Gestione della pianificazione
\<MRP \<Informazioni MRP

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 45 E-evolution Copyright©**

**La quantità prevista a disposizione viene calcolata a partire dalla
quantità disponibile indicata nell\'intestazione, quindi aggiungendo le
forniture e sottraendo i requisiti. Una quantità negativa a portata di
mano indica che è necessario generare un ordine pianificato per
soddisfare la domanda in modo tale che alla fine del processo MRP la
quantità prevista a portata di mano sia almeno pari a zero.**

**La colonna Dettagli ha due possibili voci, D e S. D indica che
l\'ordine genera una domanda (il prodotto è un componente di un MO, un
prodotto di una linea SO o una linea di previsione). Il codice AS indica
che l\'ordine genera una fornitura (il prodotto è un prodotto finito di
un MO o un prodotto incluso in una riga PO o in una richiesta).**

**La colonna Tipo indica il tipo di domanda o offerta, i tipi validi
sono:**

- **SOO - Ordine di Vendita,**

- **POO - Ordine d\'acquisto,**

- **POR - Richiesta di acquisto**

- **MOP - Ordine di produzione pianificato**

**La colonna Ordine ci mostra il numero del documento dell\'ordine I
possibili Stati dell\'ordine sono:**

- **DR - Bozza**

- **NA - Non approvato**

- **IP - In elaborazione (azienda pianificata)**

- **CO -Completo**

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 46 E-evolution Copyright ©**

#### **2-2-5 Messaggi di azione**

**È un gruppo di messaggi generati dal processo MRP.
Indica allo scheduler le azioni che deve fare per raggiungere il
Programma di produzione principale. I messaggi di azione vengono
impostati come avvisi per il pianificatore quando si iscrive alla
sessione iDempiere.**

**I possibili messaggi di azione sono:**

**MRP001 - Quantità iniziale inferiore a zero.**

**MRP020 - Crea un ordine di approvvigionamento deve essere creato per
soddisfare un bilancio negativo proiettato a mano. Questo
messaggio viene generato solo se Crea piano è No o se viene visualizzato
un nuovo requisito.**

**MRP030 - Expedite - Indica che un ordine di fornitura pianificato è
dovuto prima che sia necessario e che debba essere ritardato o
che la domanda venga riprogrammata a una data precedente.**

**MRP040 - Expedite - Indica che è necessario un ordine di fornitura
programmato dopo che è necessario e deve essere
riprogrammato a una data precedente o la richiesta riprogrammata a una
data successiva.**

**MRP050 - Annulla - Indica che un ordine di fornitura programmato non è
più necessario e deve essere eliminato.**

**MRP060 - Release prevista per - Indicare che è necessario rilasciare un
ordine di pianificazione.**

**MRP070 - Rilascio scaduto - per Indicare che un ordine di fornitura non
è stato rilasciato quando era dovuto e che dovrebbe essere
rilasciato o accelerato ora o la richiesta è stata riprogrammata per una
data successiva.**

**MRP080 - Quantità inferiore al minimo - Indica che è stato creato un
ordine di fornitura per una quantità inferiore alla quantità
minima impostata nella pianificazione del prodotto.**

**MRP090 - Quantità inferiore al massimo - Indica che è stato creato un
ordine di fornitura per una quantità per una quantità maggiore
della quantità massima impostata nella pianificazione del prodotto.**

**MRP100 - Past Due Time Fence - Indica che è presente un requisito di
materiale insoddisfatto all\'interno della barriera temporale di
pianificazione per questo articolo. È necessario pianificare e
accelerare manualmente gli ordini per soddisfare questa
domanda o ritardare l\'adempimento del requisito che ha creato la
domanda.**

**MRP110 - Non esiste Demand Warehouse - indica che la pianificazione del
prodotto non è impostata su Demand.**

**MRP120 - Nessun magazzino di approvvigionamento esistente - indica che
la pianificazione del prodotto non è impostata come approvvigionamento.**

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 47 E-evolution Copyright©**

#### **2-2-5.a Prova questo**

**Creare la pianificazione dei requisiti dei materiali (MRP). Generare
un ordine cliente con un termine d\'esecuzione di un mese e con una
quantità considerevole in modo che questa stessa attività possa essere
utilizzata nel calcolo del CRP.**

**Seleziona l\'opzione di menu Calcola livello basso ed eseguilo. Per
pulire la tabella, selezionare il processo: Creare record MRP e
selezionare la risorsa desiderata.**

**Seleziona il processo Calcola piano materiale e seleziona la risorsa
(la stessa dell\'attività precedente). Per vedere il risultato del
processo MRP, immettere l\'opzione Dettagli MRP con i parametri
risorsa, periodi, prodotto e altri campi necessari.**

-   **Prima di creare la pianificazione MRP, verificare che nella
    finestra BOM, il tipo di campo BOM abbia selezionato l\'opzione
    attualmente attiva e il campo BOM abbia usato l\'opzione
    Produzione.**

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 49 E-evolution Copyright©**

#### **2-3 Pianificazione dei requisiti di capacità**

**E' un insieme di tecniche che utilizza gli ordini pianificati da MRP,
ordini di produzione aperti, risorse di produzione e flussi di lavoro
per calcolare il tempo richiesto per ogni risorsa insieme al tempo
disponibile. Con queste informazioni, siamo in grado di bilanciare il
carico richiesto con il tempo disponibile. Attraverso la conoscenza
delle capacità richieste e disponibili è possibile regolare il Programma
di produzione principale fino a quando non ne otteniamo uno
realistico.**

**CRP risponde alla domanda: è adattata la capacità disponibile per
soddisfare la domanda di tempo richiesta in ogni risorsa di
produzione?**

#### **2-3-1 Calcolo del piano di capacità**

**Il processo di calcolo del piano di capacità ci consente di
conoscere il tempo disponibile in ciascuna risorsa di produzione,
nonché il tempo necessario per soddisfare il programma di produzione
principale.**

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 50 E-evolution Copyright©**

#### **2-3-2 Visualizzazione carico risorse**

**Mostra un grafico del tempo richiesto e disponibile per ciascuna 
risorsa di produzione.**
[{{< figure src="/image/ManualeLiberoManufacturing18.png"  width="450"  >}}](/image/ManualeLiberoManufacturing18.png)
Figura 2.3.1 Gestione produzione \<Gestione pianificazione \<CRP \<Visualizzazione carico risorse

**I parametri richiesti per ottenere la vista Carico risorse sono: la
risorsa che si desidera analizzare e la data all\'inizio del periodo che
si desidera analizzare. Quindi fai clic sul pulsante OK e vedrai la
capacità disponibile giornaliera nella risorsa selezionata. Le barre del
grafico mostrano la capacità richiesta, la capacità disponibile e la
differenza tra di loro. I tempi accumulati da altri periodi non sono
considerati per questi calcoli.**

> **Capitolo 2 PIANIFICAZIONE DELLA PRODUZIONE 51 E-evolution Copyright©**

### **3 Controllo della Produzione**

**Una volta eseguito il processo di pianificazione della produzione, il
processo di controllo della produzione ci ha permesso di verificare le
attività di esecuzione al fine di essere sicuri di poter raggiungere il
piano materiale.**

**Ogni volta che devi rilasciare un ordine devi assicurarti che i
componenti siano completi nel magazzino, questo può essere ottenuto
monitorando il rilascio e le date di scadenza per ogni componente, è
facile ottenere i rapporti di carenza di questo modulo.**

**Questo modulo risponde principalmente alla domanda: cosa devo fare per
realizzare l\'MPS?**

**\... e se si è in difficoltà e non è possibile coprire l\'MPS come
previsto, questo modulo fornisce informazioni per ridurre l\'effetto sui
costi del servizio clienti.**

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 52 E-evolution Copyright ©**

#### **3-1 Produzione discreta**

##### **3-1-1 Approvazione dell\'ordine pianificato**

**Un ordine di produzione pianificato è un ordine di produzione
suggerito dal processo MRP e contiene la sua quantità e le date di
rilascio e promessa. quando si approva un ordine pianificato di
produzione, lo si converte in un ordine di produzione con lo stato In
elaborazione. Quando si approva un ordine pianificato, si comunica al
sistema che l\'ordine di produzione è pronto per iniziare il suo
processo, con l\'approvazione si cambia lo stato dell\'ordine da Bozza a
In elaborazione.**
[{{< figure src="/image/ManualeLiberoManufacturing19.png"  width="450"  >}}](/image/ManualeLiberoManufacturing19.png)
Figura 3.1.2 Gestione della produzione \<Gestione della produzione \<Produzione discreta \<Ordine di produzione

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 53 E-evolution Copyright ©**

#### **3-1-2 Ordine di produzione**

**L\'Ordine di produzione è un\'autorità di trasporto di documenti per
la fabbricazione di prodotti specifici in quantità specificate.**
[{{< figure src="/image/ManualeLiberoManufacturing20.png"  width="450"  >}}](/image/ManualeLiberoManufacturing20.png)
Figura 3.1.2.1 Gestione della produzione \<Gestione della produzione\<Produzione discreta \<Ordine di produzione

-   **necessario immettere o selezionare i parametri per filtrare i
    record**

-   **degli ordini di produzione desiderati. Le opzioni per filtrare il
    MO sono:**

-   **Numero del documento del MO, Descrizione del documento,**

-   **Nome del prodotto, data in cui è stato generato l\'ordine, data
    della**

-   **promessa dell\'ordine, data in cui l\'ordine dovrebbe essere
    avviato s**

-   **econdo il programma di produzione (chiamato anche data di rilascio
    )**

-   **o lo stato del documento (DR, IP, CO, CL).**

[{{< figure src="/image/ManualeLiberoManufacturing21.png"  width="450"  >}}](/image/ManualeLiberoManufacturing21.png)
Figura 3.1.2.2

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 54 E-evolution Copyright ©**

**Data ordinata: è la data in cui è stato generato l\'ordine. Se il MO
viene creato manualmente, la data predefinita ordinata è la data del
sistema. Se il MO è stato generato da MRP, la data predefinita
ordinata è il giorno del processo MRP.**

**Data promessa: è la data in cui ci impegniamo a consegnare l\'ordine
al magazzino. Se il MO viene creato manualmente, la data predefinita
promessa è la data di sistema. Se il MO**

-   **stato generato da MRP, questa data viene riempita
    automaticamente**

-   **usando il suo calcolo dell\'algoritmo. Data di approvazione: è la
    data in cui**

-   **l\'ordine pianificato deve essere approvato per essere rilasciato
    nell\'officina.**

-   **Data di consegna: è la data in cui il materiale finito di questo
    ordine è**

-   **stato ricevuto dal magazzino.**

**Data di inizio pianificata: è la data, pianificata da MRP, quando il
MO deve essere rilasciato in officina.**

**Data di fine pianificata: è la data, pianificata da MRP, in cui il
MO deve essere ricevuto dal magazzino.**

**Data di inizio: è la data in cui viene segnalato il primo movimento
dell\'ordine di produzione, che può essere un inventario o movimento
di manodopera.**

**Data di fine: è la data in cui viene segnalato l\'ultimo movimento
dell\'ordine di produzione, è la data dell\'ordine di chiusura.**

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 55 E-evolution Copyright ©**

**Prima del float: verrà utilizzato nelle versioni future per bilanciare
il caricamento delle risorse.**

**Dopo il float: verrà utilizzato nelle versioni future per bilanciare
il caricamento delle risorse.**

**Nel gruppo di campi Quantità è possibile
visualizzare i campi seguenti:**

**La quantità del prodotto da fabbricare e l\'unità di misura di questa
quantità.**

**Qtà lotti è il numero di lotti che si intende fare per fabbricare
tutto il prodotto nell\'ordine.**

**La quantità La dimensione del lotto è la quantità di prodotto da
realizzare in ciascun lotto.**

**Nel campo Resa è possibile visualizzare la Resa del prodotto definita
come la quantità del prodotto che si adatta alle specifiche di qualità
divisa per la quantità totale dell\'ordine.**

**Quantità consegnata è un campo di sola lettura che contiene la
quantità consegnata al magazzino aggiornata.**

**La quantità rifiutata è la quantità di prodotto non conforme alle
specifiche di qualità riportate nell\'ordine di produzione. Quando l\'assicurazione della qualità
prende una decisione in merito al prodotto rifiutato, questo prodotto dovrà essere
successivamente rielaborato o inviato allo scarto. Quando si segnala la quantità di scarto, questa
verrà aggiunta alla quantità di scarto per l\'ordine di produzione.**

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 56 E-evolution Copyright ©**

**La quantità di scarto è la quantità di materiale non conforme alle
specifiche e con caratteristiche tali da rendere impraticabile la
rilavorazione. Il progetto e la campagna si riferiscono alle dimensioni
standard di Adempiere.**

**I dati contenuti nel gruppo di campi Stato hanno l\'uso normale di idempiere.**

**La distinta base e la formula utilizzate nell\'ordine di produzione
sono ricavate dalla finestra dei dati di pianificazione del prodotto. La
distinta base e i flussi di lavoro utilizzati dagli ordini di produzione
sono tratti dalla pianificazione dei dati di prodotto.**
[{{< figure src="/image/ManualeLiberoManufacturing22.png"  width="450"  >}}](/image/ManualeLiberoManufacturing22.png)
Figura 3.1.2.3 Gestione della produzione \<Gestione della produzione \<Produzione discreta \<Ordine di produzione**

**Le informazioni relative a ciascun componente che verrà utilizzato
nella fabbricazione del prodotto finito sono tratte dalla distinta
materiali. Queste informazioni sono contenute nella scheda Ordine BOM / Formula.**

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 57 E-evolution Copyright ©**

**Per ottenere maggiori informazioni sui dati dell\'intestazione della
BOM utilizzati nel MO, utilizzare la scheda Ordine BOM / Formula. I dati
contenuti in questa scheda sono spiegati nella sezione BOM / Formula in
questo capitolo.**

**Le informazioni su ogni componente che verranno utilizzate nella
fabbricazione del prodotto finito sono tratte dalle linee della distinta
componenti. Puoi trovare queste informazioni nella scheda Ordine BOM /
Linee formula. Il primo gruppo di campi è spiegato nella sezione BOM in
questo manuale. I campi del gruppo di consegna dei campi nella parte
inferiore della finestra mostrano le quantità dei componenti che erano
stati spostati e il localizzatore di questi prodotti. Questi campi sono
i seguenti:**

**Data di consegna è la data in cui è stato fornito il componente
all\'OM.**

**Consegna a persona o area che riceve il prodotto. Il magazzino è
l\'area da cui viene prelevato il materiale. Il localizzatore è il
corridoio, il cestino e il livello nel magazzino in cui viene prelevato
il materiale.**

**La quantità è la quantità del movimento.**
[{{< figure src="/image/ManualeLiberoManufacturing23.png"  width="450"  >}}](/image/ManualeLiberoManufacturing23.png)
Figura 3.1.2.4 Gestione della produzione \<Gestione della produzione
\<Produzione discreta \<Ordine di produzione


> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 58 E-evolution Copyright ©**

**Qtà richiesta: sono il componente necessario a MO. Quantità di
quantità consegnata del componente che era già stato fornito al MO.**

**Quantità riservata: quantità di componente che è stata riservata dal
magazzino al MO attraverso l\'approvazione del MO.**

**Qty Reject: quantità del componente che non corrisponde al motivo
della specifica di qualità per cui dovrà essere rielaborato o segnalato
come scarto.**

**Qtà scarto: quantità di componente che non farà parte del processo di
produzione perché questo prodotto non soddisfa le specifiche di qualità
e non è più possibile elaborarlo nuovamente per trasformarlo in un
prodotto utilizzabile.**

**Qtà posta: indica un importo che è stato applicato alla contabilità
generale.**
[{{< figure src="/image/ManualeLiberoManufacturing24.png"  width="450"  >}}](/image/ManualeLiberoManufacturing24.png)
Figura 3.1.2.5 Gestione della produzione \<Gestione della produzione
\<Produzione discreta \<Ordine di produzione

**Per ottenere informazioni sull\'intestazione del flusso di lavoro che
verrà utilizzata nell\'ordine di produzione, è necessario selezionare la
scheda Flusso di lavoro. I dati contenuti in questa scheda sono spiegati
nella sezione Flusso di lavoro di produzione (percorsi e processi), in
questo manuale.**

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 59 E-evolution Copyright ©**

**Le informazioni relative a ciascuna attività (o operazioni) verranno
utilizzate nella produzione di un prodotto e saranno prese dai nodi
registrati nelle finestre del flusso di lavoro di produzione nella
scheda Nodi. Questi dati possono essere modificati e anche i dati dalla
scheda di transizione. Per ottenere informazioni dettagliate sui campi,
consultare la sezione Flusso di lavoro di produzione in questo capitolo.
Nella scheda Costo abbiamo un record per ogni
elemento di costo definito nel Prodotto da produrre, per tali
Organizzazione, Magazzino, Gruppo di costi e Risorsa. È possibile
visualizzare gli importi standard per ciascun elemento di costo a questo
livello e per ciascun elemento di costo a livello inferiore per il
prodotto. Il costo a questo livello si riferisce agli elementi di costo
del prodotto da produrre (proprio a livello del prodotto finito). Gli
elementi di costo a livelli inferiori si riferiscono al costo del
prodotto da produrre (proprio a livello dei componenti prodotti). Gli
ultimi quattro campi sono correlati alle quantità e agli importi
accumulati per i movimenti di prodotti e movimenti registrati. Questi
campi sono indicati per ciascun elemento di costo:**
[{{< figure src="/image/ManualeLiberoManufacturing25.png"  width="450"  >}}](/image/ManualeLiberoManufacturing25.png)
Figura 3.1.2.6 Gestione della produzione \<Gestione della produzione \<Produzione discreta \<Ordine di produzione

**Cum Costo elemento di costo: questo campo mostra la somma delle
quantità del prodotto che hanno subito movimenti.**

**Posta di costo cum quantità elemento di costo: questo campo mostra
la somma delle quantità del prodotto che hanno subito movimenti e sono
state registrate nella GL per gli elementi di costo. Cum Amt Cost
Element: questo campo mostra la somma degli importi del prodotto che
hanno subito movimenti. Cum Amt Cost Element Post: questo campo mostra
la somma degli importi del prodotto che hanno subito movimenti e che
sono stati registrati nella GL.**

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 60 E-evolution Copyright ©**

#### **3-1-3 Rapporto sugli ordini di produzione**

-   **un report di ogni filtro degli ordini di produzione in base alle
    caratteristiche che l\'utente è interessato a selezionare.**

#### **3-1-4 Controllo dei componenti**

**Prima di completare un MO è necessario convalidare i componenti
disponibili nel magazzino, al fine di tenere traccia della
disponibilità dei componenti si ottiene un rapporto che mostra tra gli
altri dati: la quantità richiesta per il MO, la quantità riservata, la
quantità disponibile e la quantità disponibile.**
[{{< figure src="/image/ManualeLiberoManufacturing26.png"  width="450"  >}}](/image/ManualeLiberoManufacturing26.png)
Figura 3.1.4 Gestione della produzione \<Gestione della produzione
\<Produzione discreta \<Controllo dei componenti

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 61 E-evolution Copyright ©**

#### **3-1-5 Transazioni ordini**

**Con questo rapporto possiamo verificare i dettagli di ogni transazione
di Ordine di produzione eseguita con un Ordine di produzione, comprese
informazioni come il numero di documento, le quantità, i prodotti e la
data in cui sono state effettuate le transazioni, ecc.**
[{{< figure src="/image/ManualeLiberoManufacturing27.png"  width="450"  >}}](/image/ManualeLiberoManufacturing27.png)
Figura 3.1.5 Gestione della produzione \<Gestione della produzione \<Produzione discreta \<Transazioni ordini

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 62 E-evolution Copyright ©**

#### **3-1-6 Ordine di stampa e rilascio**

**Una volta approvati gli ordini di produzione pianificati generati da
MRP, hanno raggiunto la data di liberazione e hanno verificato che i
componenti richiesti sono disponibili, gli ordini vengono emessi
all\'impianto per la sua fabbricazione.**

**Se si desidera stampare la documentazione del magazzino e
dell\'officina, selezionare la casella di controllo appropriata. Se si
seleziona la casella di controllo Stampa elenco di selezione, verrà
visualizzato un rapporto con i componenti e le quantità richiesti per
aiutare l\'impiegato del magazzino a inviare il materiale in officina.**

**Se si seleziona la casella di controllo Elenco pacchetti di stampa,
verrà visualizzato un rapporto con i componenti richiesti e contenente
il materiale con un tipo di imballaggio del componente registrato nella
finestra BOM.**
[{{< figure src="/image/ManualeLiberoManufacturing28.png"  width="450"  >}}](/image/ManualeLiberoManufacturing28.png)
Figura 3.1.6 Gestione della produzione \<Gestione della produzione \<Produzione discreta \<Ordine di stampa e rilascio

**Un altro report che fa parte del pacchetto di rilascio degli ordini di
produzione è il flusso di lavoro (routing). È possibile stampare questo
rapporto spuntando la casella di controllo Stampa flusso di lavoro e
mostra al personale dell\'officina i passaggi necessari per la
fabbricazione del prodotto. Questo rapporto contiene il luogo in cui il
prodotto deve essere realizzato, i tempi standard, gli strumenti e i
dispositivi necessari. Se si desidera stampare questo rapporto,
selezionare la casella Stampa flusso di lavoro.**

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 63 E-evolution Copyright ©**

### **3-1-7 Ricevuta ed emissione dell\'ordine**

**L\'ultimo passo nel processo di fabbricazione con un Ordine di
produzione è quello di ricevere il prodotto finito nel magazzino. La
finestra mostra, nella parte superiore della finestra, informazioni
statiche intorno al prodotto e alla risorsa di produzione in cui deve
essere effettuato, mostra anche un riepilogo delle quantità da
controllare nel MO come l\'originale e le quantità consegnate e la
quantità da consegnare per il MO.**

**Se il processo di produzione richiede la produzione in batch, allora
Qty Batches mostra il numero di batch che l\'officina deve fare e la Qty
Batch Size contiene le dimensioni di ogni lotto da produrre.**

**Se si desidera emettere i componenti MO prima di ricevere il prodotto
finito, selezionare la casella È consegna, questo caso è consigliato
quando si ha un tempo di consegna medio-lungo e si desidera avere le
quantità di inventario il più accurate possibile in ogni momento .**
[{{< figure src="/image/ManualeLiberoManufacturing29.png"  width="450"  >}}](/image/ManualeLiberoManufacturing29.png)
Figura 3.1.7 Gestione della produzione \<Gestione della produzione \<Produzione discreta \<Ricevuta ed emissione dell\'ordine

**Se hai tempi di consegna brevi e desideri risparmiare tempo
impiegato,seleziona la casella di controllo È backflush e riceverai il prodotto
finito nello stesso momento in cui emetti automaticamente i componenti.**

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 64 E-evolution Copyright ©**

**Il campo Gruppo backflush viene utilizzato quando si desidera emettere
solo componenti appartenenti a questo gruppo. (Questa caratteristica non
può essere inclusa nella versione corrente).**

**Nella parte inferiore della finestra è possibile trovare l\'elenco di
ogni componente MO, che può essere modificato in base ai prodotti e alle
quantità effettivi emessi nell\'officina.**

**Le quantità da emettere sono selezionate con la casella di controllo
nella prima colonna dell\'elenco dei componenti. Se la quantità
effettiva è diversa dalla quantità standard mostrata nella colonna Qtà
da consegnare, è necessario modificare questo campo per inserire la
quantità corretta da emettere. Alla fine una finestra di messaggio
chiede se si desidera chiudere il documento OM, se questo MO non avrà
più transazioni e dovrà essere chiuso, fare clic sul pulsante ok.**

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 65 E-evolution Copyright ©**

#### **3-1-8 Controllo attività**

**Per poter pianificare, tenere traccia degli ordini di produzione in
officina e aggiornare il tempo richiesto in ogni risorsa dell\'impianto,
è necessario inserire nel sistema le attività realizzate in ogni risorsa
dell\'impianto. Un altro uso importante del Rapporto sul controllo delle
attività è quello di ottenere gli elementi per il calcolo del costo
corrente del lavoro, degli oneri e del processo esterno. Con questi dati
e i dati sulle transazioni materiali è possibile identificare le
variazioni tra i costi standard e quelli correnti per ogni ordine di
produzione.**
[{{< figure src="/image/ManualeLiberoManufacturing29.png"  width="450"  >}}](/image/ManualeLiberoManufacturing29.png)
Figura 3.1.8 Gestione produzione \<Gestione produzione \<Controllo attività \<Rapporto controllo attività

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 66 E-evolution Copyright ©**

**Immettere l\'ordine di produzione, il tipo di documento di
destinazione (ordine di produzione), l\'attività dell\'ordine di
produzione e il nodo. Quindi inserisci le quantità fabbricate, scartate
e scartate in ciascun nodo e i tempi effettivi trascorsi in ogni
attività.**

**Quando hai rifiutato o scartato le quantità puoi utilizzare un codice
di causa che ci consente di ottenere dati statistici per identificare le
cause di discrepanza delle specifiche di qualità, sviluppare modifiche
nelle cause (uomo, metodo, macchina, materiale) e migliorare i livelli
di qualità. Nel campo Quantità movimento è necessario immettere la
quantità fabbricata, scartata e scartata (ad es. Quantità movimento 10,
quantità scartata 1, quantità scartata 2, ciò significa che da una
quantità totale di 10, 2 sono state scartate e da quest\'ultima quantità
è stata scartata e uno può essere rielaborato)**

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 67 E-evolution Copyright ©**

#### **3-1-8.1 Lavoro esterno**

**Quando il nodo da segnalare ha la casella di controllo Lavoro esterno
selezionata, significa che il nodo verrà elaborato in una risorsa
esterna. La finestra Controllo attività è di sola lettura e le
informazioni sono prese dal nodo corrispondente nel flusso di lavoro
assegnato al prodotto da fabbricare con questo MO.**
[{{< figure src="/image/ManualeLiberoManufacturing30.png"  width="450"  >}}](/image/ManualeLiberoManufacturing30.png)
Figura 3.1.8.1 Gestione produzione \<Gestione produzione \<Controllo attività \<Rapporto controllo attività

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 68 E-evolution Copyright ©**

**Quando il nodo da segnalare ha la casella di controllo del lavoro
esterno selezionata e si completa l\'operazione, il sistema crea
automaticamente un ordine di acquisto per il servizio esterno richiesto
indicato nel nodo corrispondente del flusso di lavoro. Nella scheda
Acquisto della finestra Prodotto si trova il fornitore del prodotto e il
suo prezzo di listino.**
[{{< figure src="/image/ManualeLiberoManufacturing31.png"  width="450"  >}}](/image/ManualeLiberoManufacturing31.png)
Figura 3.1.8.2 Gestione produzione \<Gestione produzione \<Controllo attività \<Rapporto controllo attività

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 69 E-evolution Copyright ©**

**Quando si completa il documento, il sistema salva la sequenza Ordine
d\'acquisto nel campo descrizione del record Controllo attività.**
[{{< figure src="/image/ManualeLiberoManufacturing32.png"  width="450"  >}}](/image/ManualeLiberoManufacturing32.png)
Figura 3.1.8.2 Richiesta di fattura \<Ordine di acquisto.

**L\'ordine di acquisto viene generato nello stato Bozza e i suoi dati
possono essere modificati dall\'utente in controllo dell\'ordine, in
base all\'accordo specifico con il fornitore. L\'ordine di produzione si
trova nel campo della descrizione dell\'ordine di acquisto e l\'ordine
di acquisto si trova nel campo della descrizione del record di controllo
attività come riferimento incrociato.**

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 70 E-evolution Copyright ©**

#### **3-1-9 Dettaglio transazione officina**

**Questo Rapporto supporta il Floor Manager nello sviluppo /
aggiornamento del Programma di produzione, questo Rapporto è noto come
Rapporto di spedizione e ci mostra ogni operazione da effettuare in
ciascuna risorsa con i relativi tempi e quantità da fabbricare.**
[{{< figure src="/image/ManualeLiberoManufacturing33.png"  width="450"  >}}](/image/ManualeLiberoManufacturing33.png)
Figura 3.1.9 Gestione della produzione \<Gestione della produzione \<Controllo attività \<Dettaglio transazioni officina

> **Capitolo 3 CONTROLLO DELLA PRODUZIONE 71 E-evolution Copyright ©**

### **4 GESTIONE DEI COSTI**

**Il sistema di gestione dei costi viene utilizzato per separare i
problemi più importanti da quelli meno importanti utilizzando i criteri
dei costi di produzione. Con la gestione dei costi possiamo conoscere il
costo effettivo degli elementi di costo raggruppati nelle tipologie di
costo: materiale, manodopera, onere, spese generali, lavoro esterno e
distribuzione per ogni prodotto utilizzato nella produzione.
Conoscendo i costi e le sue variazioni: attuale vs standard, sarai in
grado di intraprendere le azioni correttive al momento giusto**
[{{< figure src="/image/ManualeLiberoManufacturing34.png"  width="450"  >}}](/image/ManualeLiberoManufacturing34.png)

**Con questo modulo rispondi principalmente alla domanda: tutti gli
elementi di costo sono utilizzati negli Ordini di produzione,
all\'interno del piano di produzione?**

#### **4-1 Tipo di costo**

**Il tipo di costo consente di definire tutti i set di costi desiderati
per lo stesso prodotto nell\'organizzazione. Ad esempio, è possibile impostare uno o più tipi
di costo per eseguire un\'analisi \"What if\" in caso di possibili variazioni dei
costi a causa dell\'ambiente aziendale economico. D\'altra parte è necessario definire
un tipo di costo da utilizzare nelle transazioni contabili.**

**Per introdurre o modificare un gruppo di costi è necessario
selezionare il menu di opzioni Analisi delle prestazioni \<Costing \<Tipo di costo.**

> **Capitolo 4 GESTIONE DEI COSTI 72 E-evolution Copyright ©**

#### **4-2 Crea elemento di costo**

**Un elemento di costo è un componente di costo che può essere
controllato in modo separato ed è parte dei gruppi definiti come tipo di costo.**

**Il tipo di elemento di costo può essere: Onere (M. Spese generali),
Materiale, Elaborazione esterna, Spese generali e Risorsa. Ad esempio:
il tipo di costo Materiale può essere separato in un elemento di costo
denominato Trasporto e in un altro elemento di costo denominato
materiale.**
[{{< figure src="/image/ManualeLiberoManufacturing35.png"  width="450"  >}}](/image/ManualeLiberoManufacturing35.png)

**L\'elemento di costo può essere controllato in diversi elementi
contabili nella finestra Schema contabile, scheda predefinita o nella
scheda Contabilità nella finestra Categoria prodotto. Nel prossimo
capitolo troverai i problemi di contabilità creati dalle transazioni di
produzione.**

> **Capitolo 4 GESTIONE DEI COSTI 73 E-evolution Copyright ©**

#### **4-3 Crea elemento**

**Con questo processo è possibile creare tutti gli elementi di costo
definiti per un\'organizzazione, uno schema contabile, un magazzino, una
risorsa, un gruppo di costi e un prodotto. Per eseguire il processo,
selezionare l\'opzione di menu Gestione produzione \<Gestione costi
standard \<Crea elemento.**
[{{< figure src="/image/ManualeLiberoManufacturing36.png"  width="450"  >}}](/image/ManualeLiberoManufacturing36.png)

**Viene visualizzata una finestra di dialogo che informa che inizierà il
processo di creazione dell\'elemento. Fare clic sul pulsante Avvia
Quando si seleziona OK, verrà visualizzato il modulo della figura 4.3.2.
Fare clic sul pulsante OK per generare automaticamente gli elementi di
costo in base ai parametri selezionati.**
[{{< figure src="/image/ManualeLiberoManufacturing37.png"  width="450"  >}}](/image/ManualeLiberoManufacturing37.png)

> **Capitolo 4 GESTIONE DEI COSTI 74 E-evolution Copyright ©**

#### **4-4 Costo del prodotto**

**La scheda Prodotto mostra le informazioni di base su un prodotto. Sono
le stesse informazioni registrate nella scheda Prodotto dal menu delle
opzioni Prodotto. La scheda Costo del prodotto consente di inserire il
costo nel campo Importo di questo livello per l\'elemento di costo, che
è il prodotto di costo a livello del prodotto e questo elemento di costo
viene fornito per un\'organizzazione, schema contabile, magazzino,
risorsa e gruppo di costi.**

**Nella stessa scheda è possibile visualizzare gli importi di livello
inferiore per l\'elemento di costo. Qui puoi vedere il risultato
dell\'aggiunta degli importi degli elementi di costo per il prodotto
dato in ogni livello inferiore della distinta base.**
[{{< figure src="/image/ManualeLiberoManufacturing38.png"  width="450"  >}}](/image/ManualeLiberoManufacturing38.png)

**Il file Cum Qty Cost Element mostra l\'aggiunta delle quantità di
prodotto che sono state emesse agli Ordini di produzione con le stesse
condizioni degli elementi di Windows.**

**Il campo Importo cumulativo dell\'elemento di costo mostra l\'aggiunta
di tutti gli importi di costo del prodotto che è stata emessa a MO con le stesse
condizioni degli elementi di costo della finestra.**

> **Capitolo 4 GESTIONE DEI COSTI 75 E-evolution Copyright ©**

#### **4-5 Rapporto costi prodotto**

**Per controllare gli elementi di costo per ogni set di Prodotto,
Organizzazione, Schema contabile, Magazzino, Risorsa e Tipo di costo;
selezionare l\'opzione di menu: Analisi delle prestazioni \<Costing
\<Elemento di costo. Verrà visualizzato il seguente modulo.**
[{{< figure src="/image/ManualeLiberoManufacturing39.png"  width="450"  >}}](/image/ManualeLiberoManufacturing39.png)

**Fai clic sul pulsante OK e otterrai un rapporto che mostra per ogni
prodotto filtrato: elemento di costo, gruppo di costi, importi di costo
a questo livello e ai livelli inferiori inferiori tra alcuni altri
dati.**

> **Capitolo 4 GESTIONE DEI COSTI 76 E-evolution Copyright ©**

#### **4-6 Cost Collector**

**Il raccoglitore di costi è un repository di tutte le transazioni MO.
Questa relazione di transazioni reali consente di confrontarla con le
transazioni standard per poter calcolare le variazioni per elemento di
costo.**

**Immettere una descrizione o un ordine di produzione, è possibile
utilizzare la scheda avanzata per filtrare la selezione.**
[{{< figure src="/image/ManualeLiberoManufacturing40.png"  width="450"  >}}](/image/ManualeLiberoManufacturing40.png)

**Quando si fa clic sul pulsante OK La finestra della figura 4.6.1 verrà
visualizzato.**

**Come puoi vedere, usando questa finestra avrai le informazioni per
ogni transazione effettuata con un Ordine di produzione.**

> **Capitolo 4 GESTIONE DEI COSTI 77 E-evolution Copyright ©**

#### **4.7 Roll-up dei costi**

**Questo processo viene utilizzato per calcolare gli elementi di costo
che integrano il costo del prodotto in base al flusso di lavoro. Il calcolo viene
eseguito come segue:**

**Costo del lavoro, il costo del lavoro dell\'operazione viene calcolato
come la divisione del tempo di impostazione per la dimensione del lotto
della quantità più la durata dell\'operazione e il risultato
moltiplicato per il tasso di lavoro.**

**Costo dell\'onere, il costo dell\'operazione viene calcolato come la
divisione del tempo di impostazione per la dimensione del lotto della
quantità più la durata dell\'operazione e il risultato moltiplicato per
l\'onere dell\'onere.**

**Costo del flusso di lavoro, viene calcolato come la somma del costo
del lavoro di ogni operazione nel flusso di lavoro di produzione.**

**Costo del flusso di lavoro a carico, viene calcolato come la somma del
costo di ogni operazione nel flusso di lavoro di produzione.**

**Costo operativo del flusso di lavoro, viene calcolato come la somma
del costo del lavoro più il costo del carico di lavoro.**

>**Capitolo 4 GESTIONE DEI COSTI 78 E-evolution Copyright ©**

#### **4.7.1. Costi congelati / non congelati**

**Questo processo ci consente di sostenere il costo di prodotti o
categorie di prodotti per un tipo di costo e un elemento di costo.
L\'effetto di costo congelato nel roll-up dei costi OM è che il prodotto
di costo rimane invariato dopo il roll-up dei costi. Quando un costo
viene congelato nel roll-up dei costi della distinta base, i diversi
livelli del costo congelato non vengono influenzati, vale a dire, il
costo di un sottoassieme può rimanere invariato ma il prodotto finito
cambierà il suo costo in base al resto dei suoi componenti. Alla fine
del periodo fiscale, i costi selezionati possono essere aggiornati
utilizzando il processo Copia prezzo in costo standard.**
[{{< figure src="/image/ManualeLiberoManufacturing41.png"  width="450"  >}}](/image/ManualeLiberoManufacturing41.png)

> **Capitolo 4 GESTIONE DEI COSTI 79 E-evolution Copyright ©**

#### **4.7.2 Copia prezzo in costo standard**

**Questo processo ci consente di copiare il prezzo registrato in una
versione del listino prezzi nell\'elemento di costo Standard
selezionato. Per realizzare questo processo è necessario specificare il
tipo di costo, l\'organizzazione e lo schema contabile. Se disponiamo di
più di un elemento di costo, il sistema consente solo di utilizzare
materiale e, infine, dobbiamo indicare da quale listino prezzi i prezzi
saranno copiati nell\'elemento di costo.**
[{{< figure src="/image/ManualeLiberoManufacturing42.png"  width="450"  >}}](/image/ManualeLiberoManufacturing42.png)

> **Capitolo 4 GESTIONE DEI COSTI 80 E-evolution Copyright ©**

#### **4.7.3. Costo del flusso di lavoro roll up**

**Questo processo ci consente di integrare i costi di manodopera e onere
per un flusso di lavoro di produzione. Calcola per ogni operazione i
costi di manodopera e onere. Esegue i calcoli successivi:**

**Il costo del lavoro per ciascuna operazione viene calcolato come il
tempo di impostazione diviso per la dimensione del lotto più il tempo di
Durata e questo risultato viene moltiplicato per il tasso di lavoro
della risorsa operativa.**

**LC = ((ST / LS) + DT) \* LRTR) Costo**

**del lavoro = LC**

**Tempo di preparazione = ST**

**Dimensione del lotto = LS**

**Durata = PT**

**Tasso di lavoro questa risorsa = LRTR**
[{{< figure src="/image/ManualeLiberoManufacturing43.png"  width="450"  >}}](/image/ManualeLiberoManufacturing43.png)

> **Capitolo 4 GESTIONE DEI COSTI 81 E-evolution Copyright ©**

#### **4.7.4. Riepilogo costi di distinta base e formula**

**Questo processo ci consente di integrare gli elementi di costo di una
distinta materiali e formule aggiungendo il costo di ogni elemento di
costo dal livello inferiore della distinta base al livello superiore.
Infine, il costo totale della distinta base è la somma di ogni costo
degli elementi di costo definiti per ciascun prodotto che fa parte della
distinta base.**

**Elemento di costo a questo livello**

**+ Elemento di costo al livello inferiore**

| _________________________ 		Importo dell'elemento di costo |      |      |
| ------------------------------------------------------------ | ---- | ---- |
|                                                              |      |      |
|                                                              |      |      |
|                                                              |      |      |
|                                                              |      |      |

> **Capitolo 4 GESTIONE DEI COSTI 82 E-evolution Copyright ©**

#### **4.7.5 Revisione multilivello della distinta base di costo**

**Per visualizzare gli elementi di costo per ogni set di Prodotto,
Organizzazione, Schema di contabilità, Metodo di determinazione del
costo e Tipo di costo. Seleziona l\'opzione di menu Gestione della
produzione \<Gestione dei costi standard \<Revisione multilivello della
distinta base di costo. Successivamente viene visualizzato un modulo che
richiede i parametri del set richiesto. Dopo aver scelto i parametri per
filtrare i dati desiderati, fai clic sul pulsante Start e otterrai un
rapporto che mostra: Metodo di determinazione dei costi, Schema di
contabilità, Elemento di costo, Importo dell\'elemento di costo a questo
livello e ai livelli inferiori.**
[{{< figure src="/image/ManualeLiberoManufacturing44.png"  width="450"  >}}](/image/ManualeLiberoManufacturing44.png)

> **Capitolo 4 GESTIONE DEI COSTI 83 E-evolution Copyright ©**

### **Glossario**

**Messaggio di azione.- Un messaggio di sistema solitamente creato
durante i calcoli MRP. Richiama l\'attenzione su un problema attuale o
potenziale e suggerisce azioni correttive.**

**Distinta materiali (BOM) .- Un elenco di tutti i sottoassiemi, i
componenti e le materie prime che vanno in un assieme padre. Mostra la
quantità di ciascuno richiesta per creare un assieme padre. Può anche
essere chiamato una struttura di prodotto o una formula. Viene
utilizzato insieme al programma di produzione principale per determinare
gli articoli per i quali devono essere rilasciate le richieste di
acquisto e gli ordini di produzione.**

**Capacità.- Il carico di lavoro massimo per un centro di lavoro, una
macchina e così via.**

**Dimensionamento lotto.- Una tecnica per determinare la dimensione del
lotto durante i calcoli MRP. Le tecniche di dimensionamento dei lotti
più comuni sono Lotto per lotto, Quantità ordine periodo, Quantità
ordine fissa e Solo una volta.**

**Produzione.- Descrive la trasformazione delle materie prime in
prodotti finiti.**

**Pianificazione dei requisiti materiali (MRP) .- Un sistema di
pianificazione prioritaria a fasi che calcola i requisiti dei materiali
utilizzando le strutture del prodotto, lo stato dell\'inventario, il
programma di produzione principale e le date degli ordini aperti.
Determina cosa ordinare, quando e quanto. L\'offerta è programmata e
riprogrammata per soddisfare la domanda variabile e mantenere scadenze
valide. MRP richiede una fonte di domanda, strutture e rotte di
prodotto, bilanci di inventario accurati e dati di pianificazione.**

**Piano dei requisiti di capacità (CRP) .- Il processo per determinare
la quantità di risorse di manodopera e macchine necessarie per svolgere
le attività di produzione. Utilizzato per la gestione della capacità a
medio raggio per determinare e quindi fornire le risorse necessarie per
soddisfare le pianificazioni dettagliate degli articoli stabilite da
MRP.**

**Costo.- Importo economico che rappresenta la produzione di qualsiasi
componente o prodotto o servizio.**

**Operation.- Un singolo lavoro o attività eseguita come parte di un
ordine di lavoro.**

**Tutte le operazioni necessarie per fabbricare un articolo
costituiscono un percorso.**

**Prodotto principale.- Un prodotto che è un prodotto finale in sé e per
sé, per il quale esiste un ordine o un requisito indipendente. Un
elemento padre può essere un componente di un altro elemento padre. Può
anche essere chiamato un oggetto finale.**

> **Glossario del capitolo 84 E-evolution Copyright ©**

**Ordine di lavoro pianificato.- Una quantità di ordine suggerita, una
data di rilascio e una data di scadenza create dall\'elaborazione MRP,
quando soddisfa i requisiti netti. Gli ordini di lavoro pianificati
vengono generati solo al di fuori dell\'intervallo di tempo
dell\'articolo. Gli ordini pianificati devono essere approvati dal
pianificatore principale per diventare ordini pianificati fissi nel
programma di produzione principale.**

**Processi.- Una sequenza sistematica di passaggi che producono un
risultato specificato.**

**Prodotto.- Qualsiasi prodotto prodotto in vendita. Gli articoli finali
e gli articoli sostitutivi sono prodotti.**

**Controllo di produzione.- Dirigere e regolare la circolazione delle
merci attraverso il ciclo produttivo, dalla requisizione della materia
prima alla consegna di un prodotto finito.**

**Linea di produzione.- Una linea di attrezzature di produzione dedicata
ad un particolare articolo. Il piano operativo mostra le quantità di
produzione dovute per linea di produzione.**

**Tempo di coda.- Il tempo che un ordine di lavoro attende in un centro
di lavoro prima di essere lavorato. Gli aumenti del tempo di coda
comportano aumenti diretti del lead time di produzione.**

**Ordine di rilascio.- La data in cui è pianificato un ordine rilasciato in officina.**

**Memorizzare.- Qualsiasi materiale immagazzinato utilizzato nella
realizzazione di un prodotto. In genere, componenti grezzi e materiali
non destinati alla vendita.**

**Transazione.- Un singolo evento segnalato al sistema informatico.**

**Tempo di attesa.- Il tempo in cui un ordine di lavoro deve attendere
dopo che è stato elaborato, ma prima di essere spostato all\'operazione
successiva. Ad esempio, essiccazione, polimerizzazione,
raffreddamento.**

**Centro di lavoro.- Un\'area di produzione composta da una o più
persone e / o macchine. Considerato come un\'unità per la pianificazione
dei requisiti di capacità e la pianificazione dettagliata.**

**Flusso di lavoro.- Definire le attività necessarie allo sviluppo di un
prodotto, considerando la sequenza di realizzazione di ogni fase della
produzione, la durata e il luogo da implementare nonché i diversi
attributi.**

> **Glossario del capitolo 85 E-evolution Copyright ©**

---
title: "System Ansible - Manuale"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 15
pre: "<b></b>"
--- 
#  ANSIBLE-IDEMPIERE TASK
## manuale del sistemista
### Overview
Strumento che mantiene le configurazioni delle macchine in modo “automatico” previa immissione delle stesse nel sistema.

### Disclaimer

C'è una leggera sovrapposizione negli usi del termine `TASK`

cercherò di seguire questa convenzione dove il senso non è palese:

- ansibleTask è la maschera su iDempiere 
- task è l'unità minima di elaborazione di ansible sul controller, può essere inserito all'interno di un play oppure in un file separato e `included`nel play o addirittura lanciato da riga di comando direttamente (se autoconsistente)

### Installazione
Per poter gestire le macchine è necessario decidere quale macchina fungerà (ANCHE) da controller, in essa installiamo ansible (versione maggiore di 2.4).
Essendo Ansible basato fortemente su python ed essendo quest’ultimo in rapido sviluppo useremo la versione 3, anche perché la 2 sarà deprecata a breve.
Ansible (https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html):
posso decidere tre vie di installazione (elencate per semplicità)

1. via pip (python package manager): più rapida, semplice e più aggiornata

2. via apt (system package manager): modo classico, ma un po’ più indietro

3. compilazione da sorgente: solo se interessati allo sviluppo di ansible stesso

scegliamo la prima, ma avremo bisogno di installare pip (ci sarà molto utile anche in seguito)

  `apt install python3-pip`    (python3-venv python3 -m venv ansiblenv  TBD)

  `pip3 install ansible`

verifichiampo la versione con 

  `ansible --version`

siccome useremo pesantemente un modulo di ansible che necessita di una libreria python la installiamo subito (sulle altre macchine se ne occuperà ansible stesso laddove non già presente dal restore di un container adeguato )

  `apt install psycopg2` oppure 

`pip3 install psycopg2`

  (serve per comunicare con postgresql e quindi con iDempiere e AnsibleTask)

un altro pacchetto utile ad ansible è

`jmespath`

lo installiamo con 

`pip3 install jmespath`

(serve a gestire le variabili complesse tipo json)

adesso istruiamo ansible di usare la versione 3 di python senza modificare tutto il sistema, infatti se qualche programma necessita di python 2 potremmo avere problemi con la scelta della versione 3 di default system-wide (che comunque riporto in fondo per eventuali necessità o come template per altri software)
Modifichiamo il file di configurazione

 `/etc/ansible/ansible.cfg`

aggiungendo alla sezione (già che ci siamo anche altre opzioni)

 `[default]`

  `interpreter_python = /usr/bin/python3`

  `remote_user = root`

  `nocows = 1`

  `gathering = smart`

  `vault_password_file = ./vpass.txt`

  `pipelining = True`

  `retry_files_enabled = False`

  `forks = 50`

  `inventory      = /opt/ansible/inventoryDir`

quest'ultimo file indicato conterrà la lista delle macchine sotto controllo, i gruppi verranno gestiti dinamicamente nei playbook.

## Flusso dei task

il playbook principale è:

`/opt/ansible/playbook/genericTask.yml`

Esso contiene due play: 

1. il primo è la parte di ricerca delle informazioni generali per ansibleTask desiderato,
   viene eseguito interamente nella machina controller.
   
   `---`
   
   `- name: eseguo un generico task da idempiere in base al tipo di file scelto.`
   
   `	hosts: localhost`
   
   `	connection: local`
   
2. il secondo è l'esecuzione vera e propria sulle macchine scelte, qui viene richiamato il file specifico per la TaskAction scelta (JAR,2PACK,SQL...).
   `- name: solo il gruppo dei selezionati`

   `  hosts: "{{hostvars['localhost'].group_name}}"`



passiamo ora al dettaglio dei vari task, ognuno avrà il suo file dedicato sotto alla cartella tasks con lo stesso `id` della actionType scelta ( es: prxmox-->PROX, JAR File--> JAR) :

`db-id-Consulting:/opt/ansible# `

 `
L__> tree -d `

`\ -- group_vars`
 `|-- host_vars `
 `|-- inventoryDir`
 `\-- playbook `
          `\ -- files`
           `|-- tasks `
           `\-- vars`





### 2PACK



### JAR



### SQL

bisogna aggiungere un altro paio di sotto task: 
attualmente eseguo  SQLstatemente con le varioabili (@variabile@) recuperate nella SELECT CLAUSE del campo sopra, attualmente implicitamente viene aggiunta la WHERE bpform_id del client sulla macchina obiettivo

### PROXMOX





## pregi, difetti, TODO

#### pregi

Un indubbio pregio è la flessibilità della modalità scelta:
se voglio aggiungere una action basterà scrivere un file con lo stesso nome ed estensione `.yml` sotto alla directory `tasks` 

All'inizio del file principale (genericTask.yml) ci sono tutte (o quasi) le variabili che il playbook usa (TODO valutare se spostarle tutte su un file apposito) per esempio la cartella dove scaricare l'allegato, il database di ansible..

#### cose da migliorare 

0. bisogna ancora fare il "pairing" a mano della chiave ssh 

   `ssh-copy-id root@1.2.3.4`

1. alcune cose sono ancora hardcoded "sparse" nei vari file:

- (segue elenco)
- il nome `generickTask.yml`  non è modificabile in quanto inserito dentro alla regola  `autoansibletask`  `AD_Rule_ID=1000053` ([...]      ` cmd = Msg.parseTranslation(A_Ctx, "ansible-playbook  /opt/ansible/playbook/genericTask.yml  -e ansibleID=" + A_Record_ID  );` [...])
- per 2Pack: un po' delicata l'installazione mista client system, quando va a buon fine per più client dello stesso host viene replicata tante volte quanti sono i client il messaggio di esecuzione riuscita
- necessario utente `AnsibleWebServices` con ruolo `Web Services Ansible` (solo per il 2Pack), creato packout ma da verificare corretta funzionalità
- variabili, elencate nella prima parte del file principale (genericTask.yml)
- nomi, alcuni non molto precisi nella descrizione

2. un po' lentino: c'è il rischio che il demone pensi che iDempiere sia bloccato?

    ( testare meglio `mitogen` , il mio test è fallito ed ho abbandonato l'impresa)

#### TODO

- JAR: implementare il restart, trovare il modo di inserire più plugin_version
- SQL: in query con risultato... MOSTRARLO!
- PROXMOX....  ()









## system-wide python version

`find /usr/bin/ -type f -name python* -exec update-alternatives --install /usr/bin/python python {} 1 \;`
(tecnicamnet l’ultimo numero dovrebbe essere il “valore di priorità” ma così è più semplice)
questo comando aggiorna il gestore versioni delle multiple versioni di python installate in modo da poter poi scegliere agevolmente tra di esse (ricordo che /usr/bin/python è solo un link al vero eseguibile, oppure ad un altro link che punta a quello vero)
`update-alternatives --config  python`  
con questo sceglieremo la versione di default per tutto il sistema

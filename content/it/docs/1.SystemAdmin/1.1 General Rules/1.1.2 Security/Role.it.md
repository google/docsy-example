---
title: "Ruolo Utente"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 75
pre: "<b>1.1.2 </b>"
--- 

-------------------------------------------
SESSIONE PER I RUOLI - RIASSUNTO SESSIONE - giorno 24/01/2019---
-------------------------------------------
a)	Esiste un Flag MANUALE si/no que definisce un ruolo appunto MANUALE o AUTOMATICO
b)	I ruoli manuali sono creati senza permessi, un utente al quale si associa un ruolo manuale al quale non e' stato aggiunto nessun permesso, non avrebbe acesso a nulla.
c)	Un ruolo creato come automatico e' paragonabile per permessi al ruolo di default ADMIN.
d)	Nel ruolo automatico il sistema "appende" i permessi anche di tutti gli oggetti creati successivmanete alla sua creazione.
e)	Per dare accesso a tutte le organizzazioni esiste un flag (Accede a tutte le org) in testata al ruolo, togliendo il flag si possono assegnare le organizzazioni desiderate in riga a livello dettaglio.
f)	Mostra Contabilita e Mostra Advanced Access in testata al ruolo sono due metodi efficaci per limitare o dare accesso ad un determinato ruolo, appunto alla Contabilita' e a tutte le finestre/funzioni definite a sistema come "Avanzate"
g)	Un ruolo definito come "Padre" e' un ruolo al quale si possono attribuire un SET di permessi specifici da poi riutilizzare in seguito attribuendoli ad un altro ruolo "normale" (per esempio un ruolo chiamato "Magazziniere" con acesso a windows "magazzino" inserendola nella tab "Accesso Finestra" - nello stesso luogo potrei definire l'accesso anche in sola lettura)
h)	Un ruolo non "Padre" e' di fatto un ruolo "normale". Ai ruoli normali puoi attribuire 1 o piu' ruoli "Padre" (da tab "Includi Ruoli").
i)	"Vuoi impostare di default una Customizzazione della Tab Utente?" e' una domanda che appare dopo la creazione di un utente nuovo e serve per riordinare in maniera migliorata le tab (personalizzazione IC)
h)	In testata ruolo troviamo altri flag rilevanti come: Puo' stampare, Puo' Esportare che si spiegano da soli.
l)	Dalla finestra "Ruolo access" posso attribuire ad un ruolo Padre dei permessi "negativi" ossia di rimozione di diritto, o come viene mostrato in dettaglio riga "Escluso". Esempio posso inserire nel dettaglio "Accesso Tabella" una riga con Tabella "c_invoice" e selezionare "Escluso". Questo ruolo attribuito ad un ruolo normale, andra' a rimuovere il diritto di accesso al utente con quel specifico ruolo. 
m)	Discorso identico al punto (l) puo' essere fatto per il tab "Accesso Colonna", ovviamente per quanto riguarda rimuovere accessi a colonne.


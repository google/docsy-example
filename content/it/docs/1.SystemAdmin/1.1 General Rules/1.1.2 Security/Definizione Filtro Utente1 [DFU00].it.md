---
title: "Plugin Copia Impostazioni Griglia"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 70
pre: "<b>1.1.2 </b>"
plugin: it.cnet.impl.copyCustomColumn
---

Video - Copia Impostazioni Griglia [V001] 

## Descrizione

Processo Copy Custom Column

Questo processo permette di copiare le impostazioni di larghezza e visione/disattivazione delle colonne in visione griglia delle tab da un utente all’altro tramite '''Info Window "Copy Tab Customization Info"'''
! [ image ] ( PluginCopyCustomColumn.png )


## Istruzioni Plugin

**PREMESSA**: Dopo aver installato il plugin dobbiamo installare a livello Client il 2pack "2packClient_TabCustomization", questo 2pack installa le Tab Customizzate di default (di Default sono state impostate a livello di User:SYSTEM)

Creata Info Window che ci consente di visualizzare le TAB, selezionarle e lanciare il processo di copia (DA Utente A Utente)

RICORDA: Le tab di default sono impostate a livello di utente SYSTEM

! [ image ] (  )


## PARTE **Filtro Ricerca condivisibile a livello Client**



## Descrizione

Questa utilità permette di condividere una Query di Ricerca anche ad altri Utenti. Vediamo un esempio:

Accedo come GardenWorld ed apro una maschera a scelta (ad:es Sales Order). Vado sul filtro di ricerca e Salvo la mia Query, si aprirà una finestra popup.


! [ image ] (  )

Deseleziono il campo "User/Contact" e Salvo. 

Adesso anche l'utente GardenUser (o qualsiasi altro utente) può visualizzare il filtro di ricerca creato dall'utente GardeWorld.


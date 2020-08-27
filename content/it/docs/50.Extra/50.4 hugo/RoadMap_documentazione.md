---
title: "RoadMap_documentazione"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 20
pre: "<b></b>"
--- 

# Strumenti di base:

## HUGO

Hugo è un tool che permette di renderizzare siti web statici e creare la struttura del sito web pronta per il deploy. 

installare HUGO via snap:

`sudo snap install hugo`

per eseguire :

`snap run hugo`

consigliato l'alias:
`alias hugo='snap run hugo'`





# PANDOC

Pandoc è un tool che serve a convertire tra i più disparati formati

installare pandoc:

`sudo apt install pandoc`

per eseguire bisognerà indicare il file sorgente e in che tipo lo vorremo convertire, per esempio se volessimo convertire da *.md a *.html:

`pandoc test1.md -f markdown -t html -s -o test1.html`

nello specifico - f per il tipo in ingresso, -t per il tipo in uscita e -o per indicare il nome del file in uscita, -s per produrre un file standalone con gli header appropriati.per convertrire in pdf bisogna usare il tipo latex in uscita: 

`pandoc test1.md -f markdown -t latex -o filename.pdf`

IMPORTANTE: per convertire in pdf bisogna avere LaTex installato

quindi:

`sudo apt install texlive-latex-recommended`

nota: attenzione!!



Adesso è tutto pronto per iniziare:

- creiamo la struttura delle directory con:
  `hugo new site $NOMESITO`

- entriamo nella directory appena createa:

  `cd $NOMESITO`

- installiamo un tema a piacimento:

  ```bash
  git init
  git submodule add https://github.com/budparr/gohugo-theme-ananke.git themes/ananke
  ```

- aggiungiamo il tema alla configurazione del sito:

  `echo 'theme = "ananke"' >> config.toml`

- creiamo i contenuti: abbiamo due modi per farlo:

1. creiamo i file direttamente e poi aggiungiamo gli header

2. facciamo fare a lui:

   `hugo new $DIRECTORY/$FILE.$FORMAT`



Siccome per l'interfaccia grafica si userà ZENITY bisogna installarlo:

`sudo snap install zenity  # version 3.32.0+pkg-468f, `
oppure
`sudo apt  install zenity`

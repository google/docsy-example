---
title: "Home Page Custom Theme "
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 17
pre: "<b>1.7 </b>"
---


# **CUSTOM HOMPAGE**


Link wiki idempiere 

[Link Wiki idempiere Custom Home Page NF2.1](http://wiki.idempiere.org/en/NF2.1_Custom_Homepage)

## Descrizione:



Possiamo modificare la nostra Hompage iniziale a proprio piacimento modificando le immagini, icone e le loro posizioni (ovviamente per modificare la posizione e lo stile dovremo modificare il file .css)


Il Task da System  ( dopo l'installazione di Initial Client Setup)

/opt/repos/idempiere-download/tasksystem/HomeProperties.sh 

copia la directory /opt/repos/idempiere-download/tasksystem/HomeProperties/ 

nel server .

## Note di modifica



Prima di tutto dobbiamo prendere il file “home.properties.txt” e copiarlo all’interno della nostra cartella Home (nel nostro caso “Idempiere-Server”)
(possiamo copiare questo file presente all’interno dei progetti eclipse, org.adempiere.server.org/src/main/home/org/bmlaurus/home/home.properties oppure possiamo prenderlo da qui 
[Link bitbucket.org/idempiere](http://bitbucket.org/idempiere/idempiere/raw/tip/org.adempiere.server/src/main/home/org/bmlaurus/home/home.properties) 
In questo file è possibile personalizzare alcune variabili. Per cambiare il tema è necessario personalizzare il “TemplateName” (presente all’interno del file home.properties.txt). Questo di default fornisce due temi: black e white. È però possibile creare dei temi nuovi: Come fare? Vedere il prossimo paragrafo

## *Come creare dei temi nuovi*:



Per creare dei temi nuovi (diversi dal white o black di default) ci sono due metodi (il primo efficace e il secondo più problematico):

#### Metodo 1

Modificare la cartella “templates” con le relative immagini, icone, ecc... situata all’interno del jar "org.adempiere.server_3.1.0.v20160221-0620.jar" presente nella seguente directory: /opt/idempiere/idempiere-server8081/plugins/).

#### Metodo 2

Copiare la cartella “templates” (presente nel progetto eclipse org.adempiere.server.org/resources/templates) all’interno della nostra Home di Idempiere (nel nostro caso nella cartella “Idempiere-server”).
All’interno della cartella templates possiamo visualizzare i due temi di default (black e white). Adesso possiamo copiare uno di questi temi (ovviamente cambiando nome della cartella, ad es: “Prova”)e modificare i setaggi al loro interno: immagini e file .css (quest’ultimo ci consente la modifica del layout).

Per poter visualizzare il nostro nuovo tema “Prova” dobbiamo aprire il file  “home.properties.txt” e impostare:

```
TemplateName        =       prova
TemplatePath        =       file:///opt/idempiere-server/templates/
```

### Cambiare icone / Nomi / Collegamenti*:

#### logo login (142x133)

inserire nel System Configurator: 

```
ZK_LOGO_LARGE    
Configurated Value: /images/nome_del_logo.png 
```

(inserire nella seguente directory l’immagine del logo   /opt/idempiere/idempiere-server/plugins/org.adempiere.ui.zk_3.1.0.v20160221-0620/images/) --> VECCHIA VERSIONE

(/opt/idempiere/idempiere-server/jettyhome/work/jetty-db-id-magtest-8443-org.adempiere.ui.zk_5.1.0.201807260619.jar-_webui-any-/)

#### logo header idempiere in alto a sx (132x35)

inserire nel System Configurator: 

```
ZK_LOGO_SMALL    
Configurated Value: /images/nome_del_logo.png 
```

 (inserire nella seguente directory l’immagine del logo   /opt/idempiere/idempiere-server/plugins/org.adempiere.ui.zk_3.1.0.v20160221-0620/images/) --> VECCHIA VERSIONE

(/opt/idempiere/idempiere-server/jettyhome/work/jetty-db-id-magtest-8443-org.adempiere.ui.zk_5.1.0.201807260619.jar-_webui-any-/)

#### nome label browser

inserire nel System Configurator: 

```
 ZK_BROWSER_TITLE
 Configurated Value: Nome Azienda
```

 

#### logo icona label browser (32x32)

inserire nel System Configurator: 

```
ZK_BROWSER_ICON
Configurated Value: /images/nome_dell'_icona.png 
```

(inserire nella seguente directory l’immagine dell'icona   /opt/idempiere/idempiere-server/plugins/org.adempiere.ui.zk_3.1.0.v20160221-0620/images/) --> VECCHIA VERSIONE

(/opt/idempiere/idempiere-server/jettyhome/work/jetty-db-id-magtest-8443-org.adempiere.ui.zk_5.1.0.201807260619.jar-_webui-any-/)

#### Help (Login URL)

inserire nel System Configurator: 

```
LOGIN_HELP_URL
Configurated Value: inserire URL
```

#### sfondo pagina login 1920x1080) /Video

/opt/repos/idempiere-download/plugin-standard/ThemeBusinessTeam/

Ci sono  jar  uno con video e immagine e uno senza vide.
Il video è prioriatario rispetto all'immagine quidni se non si vuole il video prendere il jar (novideo)

modificare il file .jar del plugin  - Aprirlo con un file archive 

struttura

```
- META-INF
- businessteam
  -+css
  -+images
   -..
   -envado_video.mp4
   -..
   -idempieregroup.mp4
```

```
cancellare l'immagine idempieregroup.jpg  e/o video  envado_video.mp4
creare una struttura uguale a quella sopra  (per comodità creata già come sottocartella di dove è il jar
```

```
./busintessteam/images

inserire qui dentro l'immagine e il video con lo stesso nome sopraindicato
```

```
fare un import (drag & drop) della cartella /businessteam e verificare che sia stata sostituita l'immagine
eseguire un salva con nome del nuovo jar
```

# **THEME**

---

link documenti ufficiali

[Link bitbucket.org](https://bitbucket.org/consulnet)

## Descrizione Plugin

---

Con questo plugin possiamo modificare gli aspetti grafici di Idempiere
Per modificare le immagini (sfondo, logo, icone, ecc...) basta entrare nella cartella images del plugin (o del progetto eclipse presente su bitbucket) e modificare le immagini a proprio piacimento

## Installazione Plugin Tema

---

Installare e attivare il plugin dalla console di Felix (Attenzione: nel momento in cui carico il plugin devo spuntare il refresh automatico) IMPORTANTE : Entrare come 

```
System Administrator
```

andare nella maschera 

```
System Configurator 
```

e nel campo ZK_THEME

```
Configured Value : "businessteam" (Role Access Update e Riavviare il tutto)
```

Modifica del Titolo nell’etichetta del browser:
sempre da System Configurator andare nel campo ZK_BROWSER_TITLE e modificare il titolo a proprio piacimento

## Reset Cache sul Server (Importante)

---

Ci potrebbero essere dei bug e quindi: icone, immagini,ecc.. del tema potrebbero non essere visualizzate correttamente

Andare nella configurazione di jetty nel file jetty.xml presente nel seguente percorso;

```
cd /opt/idempiere/idempiere-server/jettyhome/etc/jetty.xml
```

ed aggiungiamo la seguente linea (sotto la linea ''<Configure id="Server" class="org.eclipse.jetty.server.Server">'')

```
<Set class="org.eclipse.jetty.util.resource.Resource" name="defaultUseCaches">false</Set>
```

 E' necessario riavviare l'Application Server

[[Category:Troubleshooting]]

# **BUSINESS THEME - MENU SUMMARY**



È stata aggiunta la possibilità di avere un MENU SUMMARY direttamente da dashboard.
Il plug-in di riferimento si trova sotto "/opt/repos/idempiere-download/plugin-standard/ThemeBusinessTeam/Plugin Tema Menu Summary": in questa cartella, oltre al plug-in_JAR, ci sono:
```
1. 2PackSystem_themeNewField_Menu.zip:''' 2pack da installare a livello SYSTEM, che crea i nuovi campi sulla window "Menu"
2. 2PackClient_DBoardMenuSummary.zip:''' 2pack da installare a livello CLIENT, che crea il panello dashboard di Menu Summary nella Home di iDempiere
```
---

[{{< figure src="/image/HomePageCustom+Theme_1.png"  width="850"  >}}](/image/HomePageCustom+Theme_1.png)




## Configurazione

---

Una volta installato il 2packSystem.... menzionato prima, nella window "Menu" si dovranno settare i nuovi campi per poter visualizzare le voci di menu sulla dashboard personalizzata (entratìre come livello System)

{|
|
|STEP
|-

[{{< figure src="/image/HomePageCustom+Theme_2.png"  width="850"  >}}](/image/HomePageCustom+Theme_2.png)




|I campi in questione sono <br>
***DBoard Menu Group Line:*** questo campo determina la visualizzazione ordinata dei voce menu e l'eventuale raggruppamento delle voci di menu al 2°livello; può essere utilizzato sia per i "Summary Level" e sia per le window associate
***DBoard Menu Line:***   questo campo, se valorizzato ">0" e valorizzato insieme al campo "DBoard Menu Group Line", determina la visualizzazione ordinata  del menu di 2°livello
***DBoard Visual Description:***descrizione da voler visualizzare sulla voce di menu nella dashboard MenuSummary; se non viene valorizzato, prende di default il nome della voce di menu standard
***Image:*** campo utilizzato per l'icona da associare alla voce di menu; si appoggia alla maschera "System Image", dove viene definito il path dell'immagine. Nel campo 'Image URL' della maschera basta definire il path di una cartella presente a sistema (ad esempio **file:///opt/image/iD32.png**) oppure quelli definiti a plug-in, come quelli usati da default dal sistema iDempiere....
|}

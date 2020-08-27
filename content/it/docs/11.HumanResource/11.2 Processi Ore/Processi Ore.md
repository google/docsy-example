---
title: "Processi Ore"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b></b>"
---

## Tipi di Ore

---

#### Ore imputate a Centro di Costo [Costi generali] ORECDC

```
caratteristiche     : sono ore non fatturate che riguardano aspetti di gestione interna all'azienda 
                      esempio : amministrazione, attività commerciali etc.
Come si distinguono : Progetto : SI (non fatturabile) BP : azienda stessa 
Descrizione         : Le ore vengono registrate come non fatturabili e quindi vengon escluse dal processo di fatturazione ore
```

[Todo] VERIFICARE CHE IL PLUGIN RES ATT- recuperi il flag DO NOT  INVOICE DAL PROGETTO E QUINDI IMPOSTI IL RIL ORE IN MODO CORRETTO (DO  NOT INVOICE)

#### Ore a Consuntivo ORECONS

```
caratteristiche     : sono fatturate per servizi dove non è previsto un odv ne un contratto, possono essere associate a un progetto per questioni statistiche.
                      esempio : servizio di consulenza a ore per progetto a ,b ,c   (che magari riepilogo al cliente e/o riporto in fattura)
Come si distinguono : progetto : opzionale [se si deve essere fatturabile] , no odv  [TO DO ] Il Progetto deve essere : Non Creare ODV da Progetto.
Descrizione         : Le ore vengono registrate come fatturabili ed entrano nel processo di fatturazione
```

[todo] prevedere un alert per superamento ore a consuntivo

#### Ore su ODV (Chiuso) OREODVCHIUSO

```
caratteristiche     : sono ore non fatturate  in quanto viene fatturato l'odv
                     esempio : amministrazione, attività commerciali etc. 
Come si distinguono : Progetto : NO  ODV : NO (DO not invoice Resourse Attendance) 
Descrizione         : Le ore vengono registrate come non fatturabili e quindi vengono escluse dal processo di fatturazione ore
Alert previsti      : Sforamento rispetto alle ore preventivate [TO DO]
Report              : Marginalitù del singolo ODV [TO DO]
```

#### Ore a Progetto (su ODV Chiuso) OREODVCHIUSOPROG

```
caratteristiche     : sono ore non fatturate  in quanto viene fatturato l'odv
                     esempio : amministrazione, attività commerciali etc. 
Come si distinguono : Progetto : SI (non fatturare) - ODV : SI  (DO not invoice Resourse Attendance) 
Descrizione         : Le ore vengono registrate come non fatturabili e quindi vengono escluse dal processo di fatturazione ore
Alert previsti      : Sforamento rispetto alle ore preventivate [TO DO]
Report              : Marginalit del singolo ODV [TO DO]  Compreso dei costi imputati nel Progetto
```

#### Ore a ODV Aperto (senza Progetto ) OREODVOPEN

```
caratteristiche     : sono ore  fatturate  nell'odv aperto 
                     esempio : amministrazione, attività commerciali etc. 
Come si distinguono : Progetto : NO  - ODV : SI  (invoice Resourse Attendance)
Descrizione         : Le ore vengono registrate come fatturabili e quindi vengono escluse dal processo di fatturazione ore
Alert previsti      : nessuno
Report              : no
```

#### Ore a ODV Aperto (con Progetto ) OREODVOPENPROG

```
caratteristiche     : sono ore  fatturate  nell'odv aperto 
                     esempio : amministrazione, attività commerciali etc. 
Come si distinguono : Progetto : SI (fatturare i costi del prj)  - ODV : SI  (invoice Resourse Attendance)
Descrizione         : Le ore vengono registrate come fatturabili e quindi vengono escluse dal processo di fatturazione ore
Alert previsti      : nessuno
Report              : Marginalit del singolo ODV [TO DO]  Compreso dei costi imputati nel Progetto
```



```
caratteristiche     : sono ore non fatturate  in quanto viene fatturato il contratto
                     esempio : amministrazione, attività commerciali etc. 
Come si distinguono : Progetto : NO - ODV : NO  Contratto SI 
Descrizione         : Le ore vengono registrate come non fatturabili e quindi vengono escluse dal processo di fatturazione ore
Alert previsti      : Sforamento rispetto alle ore preventivate [TO DO]
Report              : Marginalit del singolo Contratto -   Compreso dei costi imputati nel Progetto
```

#### Ore a Contratto [Multi Contratto] ORECONTRATTOPROG

```
caratteristiche     : sono ore non fatturate  in quanto viene fatturato il contratto
                     esempio : amministrazione, attività commerciali etc. 
Come si distinguono : Progetto : SI [Progetto che linka i vari contrtti] - ODV : NO  Contratto NO
Descrizione         : Le ore vengono registrate come non fatturabili e quindi vengono escluse dal processo di fatturazione ore
Alert previsti      : Sforamento rispetto alle ore preventivate [TO DO]
Report              : Marginalit del singolo Contratto -   Compreso dei costi imputati nel Progetto
```

# Processi di Controllo Giornaliero / Settimanale / fine Mese

## Processo di Conferma Ore

```
Ogni Risorsa ogni giorno /2/3 giorni deve coonfermare le proprie ore dalla maschera info resource attendance
```



```
Report Riepilogo ore data a data
```

## Processo di Approvazione Ore

```
Il Responsabile Risorse ogni settimana deve approvare le ore delle risorse
```

## Processo di Fatturazione Ore

```
L'amministrazione inizia il controllo delle ore da fatturare .
a) dalla info resource attendance per il periodo in considerazione (dal 1° al 31 del mese precedente) filtr[edit] a le ore : DA FATTURARE ...
   imposta il primo BP e crea l'ordine di vendita
```



```
verificare che nel periodo non ci siano ore da fatturare
```


 Report di quadratura e di controllo gestione

```
A fine mese è necessario stampare
                    - report quadrature ore Risorsa : totale ore risorsa per giorno [controllo ore]  
                    - riepilogo mese per ore di inefficenza ( ore CDC ) [TO DO ]
                      - riepilogo mese per risorsa [TODO]  raggruppate per :  [TO DO]
                                    - inefficienza (ore CDC ]
                                    - efficienza [ore a consuntivo ]
                      - riepilogo progressivo annuale per ore di inefficenza (ore CDC ) [TODO]
                      - riepilogo progressivo annuale per risorsa rappruppate per : [TODO]
                                    - inefficienza (ore CDC ]
                                    - efficienza [ore a consuntivo ]
                      - Marginalità ODV Chiuso ..Chiusi nel mese
```

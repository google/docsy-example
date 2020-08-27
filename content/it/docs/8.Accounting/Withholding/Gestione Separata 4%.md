# Gestione separata 4%

## Indice

### [PREMESSA SPIEGAZIONE PROCESSO](#PREMESSA SPIEGAZIONE PROCESSO)
### [COSA DEVE FARE IL PROCESSO](#COSA DEVE FARE IL PROCESSO) 
### [ESTENSIONE APPLICATION DICTIONARY](#ESTENSIONE APPLICATION DICTIONARY)
### PREMESSA SPIEGAZIONE PROCESSO



Caso Semplice   A
Fattura professionista   
riga fattura (prodotti)
C001     Consulenza                     1000 €         IVA 22% (cat. Ritenuta 20%)   GS4% SI
D002     Spese anticipate             100 €         IVA 22%  (No cat Rit. 20% ) GS4% NO 
GS04    Gestione separata 4%      40 €        IVA 22% (cat. Ritenutea 20& /  oppure no )
​          Ritenuta  (su 1000 € oppure su  40 € ) dipende dal prodotto 
Schema

| Componenti Fattura | IVA  | Ritenuta | GS4% |
| ------------------ | ---- | -------- | ---- |
| Consulenza         | si   | si       | si   |
| Spese anticipate   | no   | si       | no   |
| Spese Documentate  | si   | si       | no   |
| Gest Sep 4%        | si   | si/no    | -    |
| Ritenuta           | no   | -        | no   |

### COSA DEVE FARE IL PROCESSO 

Deve fare la somma delle righe di fattura con i codici prodotto che siano GS4$ (Che la Regola della categoria di ritenutea abbia il campo TAXPAYERTYPEN NOT NULL ) 
OTTENGO A QUESTO PUNTO UNA IMPORTO (SOMMA) della base di calcolo 
ESEMPIO 1000 € 
  b) Devo aggiungere una riga/ o due
AGGIUNGO IL PRODUCT ID specificato enlla Whit calc e l’importo
  c) Quale calcolo ?

### ESTENSIONE APPLICATION DICTIONARY 

Utilizziamo il campo IS USE ORG TAX PAYER TYPE not null
ADD NEW FIELD 
TABLE: LCO_WithholdingCalc
COLUMN : Product_GS1_ID
​               Product_GS2_ID
​               Rate_GS1
​               Rate_GS2

WINDOW: Withholding Type> Withholding Calc
​    FIELD:  Product_GS1
​          Product_GS2
​          Rate Product_GS1
​          Rate Product_GS2
![](/opt/md/images/Gestione separata 4%/Gestione 1.png)
e Trovo il primo codice prodotto  aggiungo il codice alla fattura e  calcolo l’importo con la base di calcolo precedentemente consierata per la percentuale del campo
Eseguo la stessa cosa per il secondo cmapo Product _id  
Esempio di codice Prodotto  
GS04%  Descrizione  TIPO: SERVIZIO TASSA IVA 22%  - NO PREZZO
GS02% cassa architetti ….

DOVE SI APPLICA IL PROCESSO  

- In Fattura  (su calcolo ritenuta di acconto  )  	
- Processo di Creazione Fattura  	
**\*Aggiornamento:*** *il processo si applica nel momento della creazione e preparazione/completamento di un ordine*
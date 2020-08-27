# Gestione Ritenute di acconto

Fattura Professionista   

DOMADA : dove impostare il codice /gruppo di ritunute ?
\- a livello client ?
\- a livello org ?
\- a livello product ?
La più interessante protebbe essere a libello product  cosi posso fare due fatture una con un prodotto con ritenute (vedi consulenza)  dove applico correttamente la ritenute e una fattura di vendita di prodotto software (esempio antivirus ) dove non è obbligatorio applicare la ritenuta.
Per le situazioni più semplice come per gli avvocati, ingegneri etc forse avere una forzatura a livello client  risulta una soluzione vincente in quanto probabilmente avranno il 100% delle fatture sempre con ritenuta.

**CASO 1 - Fattura di vendita “NORMALE”**
Imponibile 1000
IVA 22% 220 €
Totale 1220 €

PRODOTTO A   PREZZO 1.000 €    IVA 22%     : TOTALE FATTURA 1200
**SCRITTURA CONTABILE E’ LA SEGUENTE**
dare					                   avere
Crediti verso clienti		       Diversi                                                    € 1.220,00
​       			          a          Ricavo da VEndita            € 1.000,00
​                          	  a	      IVA a Debito                     €     220,00	

Note : il conto iva viene desunto dalla c_Tax del prodotto
​	   il conto ricavi viene desunto dal procut category del product  

**CASO 2 - Fattura di vendita con ritenuta**

Prodotto A 1000  (soggeto a ritenuta)  
Imponibile = 1000   
iva (su imponibile )22%      220€  
- ritenuta 20% sull’imponibile 200  
Credito vs clienti 1000+220-200 = 1020
**SCRITTURA CONTABILE E’ LA SEGUENTE**

dare					                   avere

Diversi                     		       Diversi                                                    € 1.020,00
​       			                  a          Ricavo da VEndita            € 1.000,00
​                                          a           IVA a Debito      		€    220,00	
Crediti verso clienti	                                                                € 1.020,00
Erario c/ritenuta    		                                                        €    200,00

Note : il conto iva viene desunto dalla c_Tax del prodotto
​	il conto ricavi viene desunto dal procut category del product  

**CASO 3 - FAttura con ritenuta e cassa previdenziale 2%-4%**  

Nelle righe abbiamo .
- Cod. articolo di tipo ritenuta  CONSULENZA/PRESTAZIONE     1000 €  
- Cod. articolo di tipo SPESE DOCUMENTANTE                            100 €  
Cosa devo calcolare :  
- Cod. articolo di tipo CONTRIBUTO CASSA/PREVID 4%               40 €  (non sulle documentate .su 1000 € *4% =40 € )
- Cod. articolo di tipo RITENUTA 20% su 1000%                            200  €
- IVA a DEBITO su 1000 € + 40 €  *****  PROBLEMA    228,80 €
1000 + 100 + 40 +228,80 = 1368,80 - 200 Ritenuta : Netto a saldare (Credito v/cliente ) = 1168,80 
ERARIO C/RITENUTA     200 €

Totale a pareggio DATE  1368,80		Totale a pareggio 	1368,80

Note : il conto iva viene desunto dalla c_Tax del prodotto
​	il conto ricavi viene desunto dal procut category del product  

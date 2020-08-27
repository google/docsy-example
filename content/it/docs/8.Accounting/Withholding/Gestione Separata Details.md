# Gestione Separata Details

Creazione come nuovo prodotto della Gestione separata del 4%, senza prezzo

![](/opt/md/images/Gestione separata 4%/Gestione 2.png)

Poi, impostare una nuova categoria di ritenuta

![](/opt/md/images/Gestione separata 4%/Gestione 3.png)

Creare un nuovo tipo di ritenuta

![](/opt/md/images/Gestione separata 4%/Gestione 4.png)

Nella sotto-tab della configurazione delle regole di ritenuta, impostare i flag attivi “*Is
Use Withholding Category*” e “ Is Use Org Tax Payer Type ”

![](/opt/md/images/Gestione separata 4%/Gestione 5.png)

Alla sotto-tab successiva, nelle regole della ritenuta bisogna impostare la nuova categoria di ritenuta creata, il tipo contribuente (Tax Payer Type Organization) e il calcolo della ritenuta

N.B. : il processo non prenderà in considerazione la gestione del 4% se il campo tipo contribuente (Tax Payer Type Organization) non è valorizzato…..

**Punto1**: per impostare il tipo contribuente (Tax Payer Type Organization), bisogna crearlo nella sua apposita maschera “Tax Payer Type” e impostarlo nelle info dell’Organizzazione, machera “Organization > Organization Info”

![](/opt/md/images/Gestione separata 4%/Gestione 6.png)

**Punto 2**: per il calcolo della ritenuta, bisogna impostare 

\- il tipo base calcolo (Base Type) a livello di linea di fattura,  

- la tassa di ritenuta: bisogna creare una categoria di tassa (Tax Category) che sia di ritenuta  
- e poi la vera e propria tassa (Tax Rate), con il riferimento al categoria di tassa tipo ritenuta
-  selezionare il prodotto della gestione separata (Product GS1), quello creato apposta per gestione separata del 4%, e infine impostare il tasso di riferimento (Rate Product_GS1) al 4%

Una volta fatta questa gestione, creare un ordine e nelle linee d’ordine inserire i
prodotti che abbiano la categoria di ritenuta impostata x la gestione separata del 4%, come ad’esempio la consulenza

Alla fine della compilazione dell’ordine, azionare sul bottone “Azione Documento” (Document Action) e scegliere ‘Prepara’ / ‘Completa’ per far apparire la riga con il calcolo della gestione separata del 4%  

CLASSI JAVA DI RIFERIMENTO

**it.cnet.idempiere.separateAccount.model.EventHandler_cnet**

**it.cnet.idempiere.separateAccount.CalcSeparateAccount**


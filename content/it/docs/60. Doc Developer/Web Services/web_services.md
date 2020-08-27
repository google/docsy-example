# Web Services

---

* http://webservices.dotnethell.it/codicefiscale.asmx
  http://www.webservicex.net/New/Home/ServiceDetail/49
  Link video: https://www.youtube.com/watch?v=SXxs7PqR7SU
  http://wiki.idempiere.org/en/Web_services

---

## SOAP WSDL/WASD

Scaricare il programma per creareare i file SOAP --> SoaPUI

```
https://www.soapui.org/
```

Andare nel seguente link:

```
http://localhost:8080/ADInterface/services (in base al vostro ip di idempiere)
```

![image](/home/idempiere/Scrivania/Migrazione wiki/COLONNA1/Web Services/900px-WebServices.png)

Andare nel programma SoapUI, creare un generico Progetto ed incollare il path del link. Vedi immagine sotto:

![image](/home/idempiere/Scrivania/Migrazione wiki/COLONNA1/Web Services/600px-WebServices1.png)

Creiamo il nostro script, vediamo un esempio:

![image](/home/idempiere/Scrivania/Migrazione wiki/COLONNA1/Web Services/600px-WebServices2.png)


Andiamo su iDempiere (a livello Client) nella maschera Web Service Security e settiamo i parametri del web services. Vediamo alcuni esempi:

### RunProcess

Setaggio idempiere

![image](/home/idempiere/Scrivania/Migrazione wiki/COLONNA1/Web Services/1000px-WebServices3.png)

Nella Tab "Web Services Access" inseriamo il ruolo di Accesso (questo ruolo deve essere lo stesso dichiarato nel file xml)

![image](/home/idempiere/Scrivania/Migrazione wiki/COLONNA1/Web Services/600px-WebServices4.png)

ATTENZIONE!! Ricordati che il processo che vuoi lanciare deve essere abilitato anche nel Ruolo dell'Utente GSIAdmin. Dove? Nella Window --> Role, Tab --> Process Access


Vediamo adesso come deve essere impostato il file xml.

![image](/home/idempiere/Scrivania/Migrazione wiki/COLONNA1/Web Services/493px-WebServices5.png)

### Lanciare il comando SOAP Wsdl da Shell

Prima di tutto dobbiamo copiare l'xml presente nella colonna sinistra di SOAP UI in un file .xml (esempio SOAP_Wsdl.xml). Dopodichè ci posizioniamo nella directory di dove è situato il file xml appena salvato e lanciamo il seguente comando:

```
wget -q http://localhost:8080/ADInterface/services/ModelADService?wsdl --post-file=SOAP_Wsdl.xml -O log_result.xml
```
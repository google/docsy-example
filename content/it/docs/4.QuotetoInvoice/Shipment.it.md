---
title: "Spedizione"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 220
pre: "<b></b>"
---

## Documento di Trasporto  [DDT00]
[{{< figure src="/image/DocumentoTrasporto0.png"  width="850"  >}}](/image/DocumentoTrasporto0.png)
## Operazione di Spedizione [ODS00]
[{{< figure src="/image/OperazioneSpedizione0.png"  width="850"  >}}](/image/OperazioneSpedizione0.png)
## Crea Spedizione (manuale) [CSPEM00]
[{{< figure src="/image/CreaSpedizioneManuale.png"  width="850"  >}}](/image/CreaSpedizioneManuale.png)
## Crea Spedizione [CSPE00]
[{{< figure src="/image/CreaSpedizioneCSPE00.png"  width="850"  >}}](/image/CreaSpedizioneCSPE00.png)
## Info crea spedizione da ordine riga [ICSR00]
[{{< figure src="/image/InfoCreaSpedizionedaOrdineRiga.png"  width="850"  >}}](/image/InfoCreaSpedizionedaOrdineRiga.png)
## Info crea spedizione [ICS00]
[{{< figure src="/image/InfoCreaSpedizione.png"  width="850"  >}}](/image/InfoCreaSpedizione.png)
## Pacchetto spedizione [PCS00]
[{{< figure src="/image/PacchettoSpedizione0.png"  width="850"  >}}](/image/PacchettoSpedizione0.png)

# Report Spedizione
## Report Dettaglio Ordini [RE.54]
[{{< figure src="/image/DettaglioOrdiniNonEvasiRE54.png"  width="850"  >}}](/image/DettaglioOrdiniNonEvasiRE54.png)
## Report dettaglio Spedizioni [R.07]
[{{< figure src="/image/InformazioniDettagliSpedizioniR07.png"  width="850"  >}}](/image/InformazioniDettagliSpedizioniR07.png)

# Setup Shipping
## Tariffa Doganale [TFD00]
[{{< figure src="/image/TariffaDoganaleTFD00.png"  width="850"  >}}](/image/TariffaDoganaleTFD00.png)

## Video - Spedizione
### Video - Quote-to-Invoice - Reopening Shipment Document / Riapertura DDT⁄EM [V158]
{{<youtube j8PmRsGiWGY>}}

### Video - QuotetoInvoice - Genera spedizione da ordine riga x kit [V098]
{{<youtube KVIrFFy71yc>}}

# Documento di Trasferimento Merce

## 1. Tipo di Documento in Uscita



| Descrizione                                    | Scarico/Carico |      |      |      |
| ---------------------------------------------- | -------------- | ---- | ---- | ---- |
| DDT Vendita da ODV Magazzino o Ordine Standard | Scarico / --   |      |      |      |
|                                                |                |      |      |      |
|                                                |                |      |      |      |
|                                                |                |      |      |      |
|                                                |                |      |      |      |

| **Descrizione Causale**                                      | **Codice**    | **Movimento di Scarico**             | **Movimento di Carico** | **Movimento Contabile** | **iDempiere**                        | **Note**                                                     |
| ------------------------------------------------------------ | ------------- | ------------------------------------ | ----------------------- | :---------------------- | ------------------------------------ | ------------------------------------------------------------ |
|                                                              |               |                                      |                         |                         |                                      |                                                              |
| **Uscita Campionario (MM Shipment - Sample Shipment)**       | **CCAMP**     | **- Mag Interno**                    | **+ Mag Esterno**       |                         | **Documento di Trasporto**           | **OK**                                                       |
| **Eventuale Rientro Campionario da Agente**                  | **RCAMP**     | **+ Mag Interno**                    | **- Mag Esterno**       |                         |                                      | **OK Ddt agente (entro anno solare)**                        |
| **Se accordo fatturazione o fatturazione seguito danni**     | **FCAMP**     |                                      |                         | **Fattura**             |                                      |                                                              |
| **Comodato gratuito**                                        | **CCOMG**     | **- Mag Interno**                    | **+ Mag Esterno**       | **No Fattura**          | **Documento di Trasporto**           |                                                              |
| **Rientro comodato Gratuito**                                | **RCOMG**     | **+ Mag Interno**                    | **- Mag Esterno**       |                         |                                      | **Ddt da parte cliente**                                     |
| **Fatturazione da comodato gratuito (accordo o danno)**      | **FCOMG**     |                                      |                         | **Fattura**             |                                      |                                                              |
| **Conto Noleggio Omeroso**                                   | **CNOLO**     | **- Mag Interno**                    | **+ Mag Esterno**       |                         | **Documento di trasporto**           |                                                              |
| **Rientro Noleggio Oneroso**                                 | **RNOLO**     | **+ Mag Interno**                    | **- Mag Esterno**       | **Fattura**             |                                      | **Ddt da parte cliente**                                     |
| **Trasferimento a Magazzino (Material Movement)**            | **CTRAS**     | **- Mag Interno**                    | **+ Mag Esterno**       | **No Fattura**          | **Documento di Trasporto-Magazzino** |                                                              |
| **Rientro da Trasferimento**                                 | **RTRAS**     | **- Mag Esterno**                    | **+ Mag Interno**       |                         |                                      |                                                              |
| **Conto Deposito (Deposit Account)**                         | **CDEPC**     | **- Mag Interno**                    | **+ Mag Esterno**       | **No Fattura**          | **Documento di Trasporto-Magazzino** | **(+ rientro da cto dep usando la causale "RIENTRO")**       |
| **Reso Conto Deposito (Return Deposit Account)**             | **RDEPC**     | **- Mag Esterno**                    | **+ Mag Interno**       |                         | **Documento di Trasporto**           |                                                              |
| **Vendita da conto Deposito**                                | **FDEPC**     |                                      |                         | **Fattura**             |                                      |                                                              |
| **Conto Visione (Vision Account)**                           | **CVISI**     | **- Mag Interno**                    | **+ Mag Esterno**       |                         | **Documento di Trasporto-Magazzino** | **+ RIENTRO DA CONTO VISIONE (CAUSLE "RIENTRO") Report Mat. in CCV per nr giorni** |
| **Reso da Conto Visione (Return Vision Account)**            | **RVISI**     | **- Mag Esterno**                    | **+ Mag Interno**       | **No Fattura**          | **Documento di Trasporto**           | **(Come usufruitor)**                                        |
| **Vendita da Conto Visione**                                 | **FVISI**     |                                      |                         | **Fattura**             |                                      |                                                              |
| **Prestito d'uso gratuito (Loan of Use)**                    | **CPRUG**     | **- Mag Interno**                    | **+ Mag Esterno**       | **No Fattura**          | **Documento di Trasporto-Magazzino** |                                                              |
| **Reso da Prestito d'uso gratuito (Return Loan of Use)**     | **RPRUG**     | **- Mag Esterno**                    | **+ Mag Interno**       |                         | **Documento di Trasporto**           |                                                              |
| **Vendita materiale da Prestito d'uso gratuito addebito per danno** | **FPRUG**     |                                      |                         | **Fattura**             |                                      |                                                              |
| **Prestito d'uso oneroso**                                   | **CPRUA**     | **- Mag Interno**                    | **+ Mag Esterno**       |                         |                                      |                                                              |
| **Reso da Prestito d'uso oneroso**                           | **RPRUA**     | **+ Mag Interno**                    | **- Mag Esterno**       | **Fattura**             |                                      | **Ddt reso cliente**                                         |
| **Manutenzione/Riparazione Fornitore in garanzia**           | **CRIGF**     | **- Mag Interno**                    | **+ Mag Esterno**       |                         | **Documento di Trasporto-Magazzino** | **+ Rientro da conto manutenzione +causale RIENTRO**         |
| **Rientro da Manutenzione/Riparazione Fornitore in garanzia** | **RRIGF**     | **- Mag Esterno**                    | **+ Mag Interno**       | **No Fattura**          |                                      |                                                              |
| **Conto Riparazione/Manutenzione (Account Maintenance)**     | **CRIAF**     | **- Mag Interno**                    | **+ Mag Esterno**       |                         |                                      |                                                              |
| **Rientro da Conto Riparazione /Manutenzione**               | **RRIAF**     |                                      |                         | **Fattura**             |                                      | Ddt fornitore+Fattura                                        |
| **Conto Riparazione/Manutenzione (Account Maintenance)**     | **CMANC**     | X materiali non a giacenza magazzino |                         |                         |                                      |                                                              |
| **Rientro da Conto Riparazione /Manutenzione**               | **RMANC**     | X materiali non a giacenza magazzino |                         | **Fattura**             |                                      |                                                              |
| **Conto Lavorazione (Account Working)**                      | OUTPROD CLAVF | - Mag Interno                        | + Mag Esterno           |                         | Documento di Trasporto-Magazzino     |                                                              |
| **xxx Reso NC a Fornitore**                                  | RMA           | - Mag Interno                        |                         |                         | ??                                   |                                                              |
| **xx Omaggio**                                               | COM           | - Mag Interno                        | + Mag Esterno           |                         | Documento di Trasporto-Magazzino     |                                                              |

### **Documento Principale di Carico e Scarico**  

####  **DDT Vendita da ODV Magazzino o Ordine Standard**  

**| Descrizione           |Scarico|Carico|Maschera|Descrizione Tipo Doc|Note|Report|Link Processo**
**|:----------------------|:-----:|:----:|-----|-|-|-|**
**| DDT Vendita da ODV Magazzino      | SI    | -    |DDT(Customer Shipment)|DDT di Vendita|InDiretta|0045|**

####  **DDT Vendita da ODV Fattura Immediata**

**| Descrizione           |Scarico|Carico|Maschera|Descrizione Tipo Doc|Note|Report|Link Processo**
**|:----------------------|:-----:|:----:|-----|-|-|-|**
**| DDT Vendita Order Standard        | SI    | -    |DDT(Customer Shipmet)|DDT di Vendita |Diretta|0045|**

####  **Scarico Merce tenuta in Conto Deposito per il cliente**

**| Descrizione           |Scarico|Carico|Maschera|Descrizione Tipo Doc|Note|Report|Link Processo**
**|:----------------------|:-----:|:----:|-----|-|-|-|**
**| Scarico Merce tenuta in Conto Deposito        | SI    | -    |DDT(Customer Shipment)|DDT Invio Cto Deposito|-|0045|**

**| Reso a Fornitore      | SI    | -    |Reso a Fornitore (RAF)|Reso a Fornitore|Nota di Accredito|???|**

*****| Reso a Fornitore      | SI    | -    |Reso a Fornitore (RAF)|Reso a Fornitore|Riapre Ordine|???|**

### **Documento di Trasferimento**

| **Descrizione**                             | **Scarico** | **Carico** | **Maschera**               | **Descrizione Tipo Doc** | **Note**      | **Report** |
| :------------------------------------------ | :---------: | :--------: | -------------------------- | ------------------------ | ------------- | ---------- |
| **Trasferimento a Magazzino /Cto Deposito** |   **SI**    |   **-**    | **DDT(Customer Shipment)** | **DDT di Vendita**       | **Diretta**   | **0045**   |
|                                             |   **SI**    |   **-**    | **DDT(Customer Shipmet)**  | **DDT di Vendita**       | **Indiretta** | **0045**   |

### **Altri Documenti**

| **Descrizione**            | **Scarico** | **Carico** | **Maschera**               | **Descrizione Tipo Doc**   | **Note**      | **Report** |
| :------------------------- | :---------: | :--------: | -------------------------- | -------------------------- | ------------- | ---------- |
| **Uscita Campionario**     |    **-**    |   **-**    | **DDT(Customer Shipment)** | **DDT di Vendita**         | **Diretta**   | **0045**   |
| **Uscita Campionario (M)** |    **-**    |   **-**    | **DDT(Customer Shipment)** | **DDT di Vendita**         | **Diretta**   | **0045**   |
|                            |   **SI**    |   **-**    | **DDT(Customer Shipmet)**  | **DDT di Vendita**         | **Indiretta** | **0045**   |
|                            |   **SI**    |   **-**    | **DDT(Customer Shipment)** | **DDT Invio Cto Deposito** | **-**         | **0045**   |

## **2. Tipo di Documento In Entrata**

| **Descrizione tipo doc.** | **Scarico** | **Carico** | **Maschera**              | **Descrizione Tipo Doc** | **Note** | **Report** |
| :------------------------ | :---------: | :--------: | ------------------------- | ------------------------ | -------- | ---------- |
| **Entrata Merci e**       |    **-**    |   **SI**   | **Reso da Cliente (RDC)** | **Reso**                 | **-**    | **-**      |
| **Reso da Cliente**       |    **-**    |   **SI**   | **Reso da Cliente (RDC)** | **Reso**                 | **-**    | **-**      |


- [ ] **test**
- [ ] **sdfsdf**
- [x] **sdf**

**1**


## Tariffa Doganale
[{{< figure src="/image/TariffaDoganale0.png"  width="850"  >}}](/image/TariffaDoganale0.png)


## Genera Spedizione Kit da Ordine
QuotetoInvoice - Genera spedizione da ordine riga x kit https://youtu.be/KVIrFFy71yc

## Riaprire DDT Chiuso da Ordine Magazzino 

Non è possibile riaprire un documento DDT se l'ordine è stato chiuso.
Contattare il supporto tecnico per eseguire una modifica specifica

Per evitare un eventuale errore è possibile iimpostare la conferma nei seguenti casi

* conferma su azione Chiudi

* conferma su azione Annulla

![ClientConfermaChiudi](/image/ClientConfermaChiudi.jpg)

# Plugin: Shipment Custom

---

## Descrizione Plugin

---

## Funzionalità supportate

---

## Installazione Plugin

---

## Parametrizzazione Plugin

---

## Istruzioni Plugin

---

## Documentazione Tecnica Plugin

### Modifiche all'AD

#### Existing Tables / Windows

#### New Tables /Windows

#### Removed Tables /Windows

---

## Funzionalità Future

---

## Test

Prova d'inserimento manuale di DDT (Shipment Customer):
creato un nuovo Document Type "MM Shipment_Custom", uguale identico al "MM Shipment" ma con il flag attivo su 'Create Negative Movement' e il 'Document Type To Be Created'( --> ID impostato a C_DocType_ID) impostato su "Internal Use Inventory"(value_Key: 200000); inserito un prodotto con quantità a 1 e avviato il processo di COMPLETE. Completa il DDT e in più, intercettando l'evento con il plug-in, viene creato un movimento dello stesso prodotto (M_Inventory/M_InventoryLine) e viene Completato anche questo; il risultato GIUSTO viene visualizzato sulla sottoTab "Transaction" della Window 'Product': una riga con -1 relativa al DDT (Shipment Customer) e una riga con +1 relativa all'Inventario (Inventory In)

---

## Errori e bug

---

---
## Report Spedizione





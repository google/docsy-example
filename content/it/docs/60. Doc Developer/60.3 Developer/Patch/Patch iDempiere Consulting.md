# Patch iDempiere Consulting

---

**FRAGMENT IDEMPIERE**

Elenco delle patch applicate direttamente su il core di iDempiere: LINK REPOSITORY: <https://bitbucket.org/consulnet/idempiere_patch_cnet>

  Contents  [[hide](http://192.168.178.102/index.php/Patch_iDempiere_Consulting#)]   [1 09/05/2016 - Bill location](http://192.168.178.102/index.php/Patch_iDempiere_Consulting#09.2F05.2F2016_-_Bill_location) [2 30/06/2016 - Genera Spedizioni (manuale) e Genera Fatture (manuale)](http://192.168.178.102/index.php/Patch_iDempiere_Consulting#30.2F06.2F2016_-_Genera_Spedizioni_.28manuale.29_e_Genera_Fatture_.28manuale.29) [3 19/10/2016 - add patch per annullare il problema di salvataggio dopo l'inserimento di un attributo di istanza nella orderline](http://192.168.178.102/index.php/Patch_iDempiere_Consulting#19.2F10.2F2016_-_add_patch_per_annullare_il_problema_di_salvataggio_dopo_l.27inserimento_di_un_attributo_di_istanza_nella_orderline) [4 29/12/2016  - Salto controllo PAYMENTRULE_DirectDeposit e PAYMENTRULE_DirectDebit  per visualizzazione completa dei metodi di pagamento](http://192.168.178.102/index.php/Patch_iDempiere_Consulting#29.2F12.2F2016_-_Salto_controllo_PAYMENTRULE_DirectDeposit_e_PAYMENTRULE_DirectDebit_per_visualizzazione_completa_dei_metodi_di_pagamento) [5 21/04/2017 - Overwrite del PostingType sul GL + controllo 'Any Account' flaggato su GL Distribution](http://192.168.178.102/index.php/Patch_iDempiere_Consulting#21.2F04.2F2017_-_Overwrite_del_PostingType_sul_GL_.2B_controllo_.27Any_Account.27_flaggato_su_GL_Distribution) [6 17/05/2017 - Gestione IVA indetraibile](http://192.168.178.102/index.php/Patch_iDempiere_Consulting#17.2F05.2F2017_-_Gestione_IVA_indetraibile) [7 23/05/2017 - Messaggi di Errore - popup completa e scompare con chiusura manuale](http://192.168.178.102/index.php/Patch_iDempiere_Consulting#23.2F05.2F2017_-_Messaggi_di_Errore_-_popup_completa_e_scompare_con_chiusura_manuale) [8 23/05/2017 - Messaggio "No inventory available" rimosso in base a variabile di sistema LIT_DisableMessageNoInventory=Y](http://192.168.178.102/index.php/Patch_iDempiere_Consulting#23.2F05.2F2017_-_Messaggio_.22No_inventory_available.22_rimosso_in_base_a_variabile_di_sistema_LIT_DisableMessageNoInventory.3DY) [9 01/08/2017 - Creazione di nuovo listino prezzi in base a variabile di sistema IDIT_PO_PriceList](http://192.168.178.102/index.php/Patch_iDempiere_Consulting#01.2F08.2F2017_-_Creazione_di_nuovo_listino_prezzi_in_base_a_variabile_di_sistema_IDIT_PO_PriceList) [10 01/08/2017 - Nuova gestione termini di pagamento](http://192.168.178.102/index.php/Patch_iDempiere_Consulting#01.2F08.2F2017_-_Nuova_gestione_termini_di_pagamento) [11 09/10/2017 - Processo adattato alla T_Selection delle infoWindow, per le tabelle che prevedono il "posted"](http://192.168.178.102/index.php/Patch_iDempiere_Consulting#09.2F10.2F2017_-_Processo_adattato_alla_T_Selection_delle_infoWindow.2C_per_le_tabelle_che_prevedono_il_.22posted.22) [12 23/11/2017 - Parametrizzazione contenuto cssStyle](http://192.168.178.102/index.php/Patch_iDempiere_Consulting#23.2F11.2F2017_-_Parametrizzazione_contenuto_cssStyle) [13 06/12/2017 - Utilizzo del campo "Peso", se valorizzato al completamento del documento Shipment](http://192.168.178.102/index.php/Patch_iDempiere_Consulting#06.2F12.2F2017_-_Utilizzo_del_campo_.22Peso.22.2C_se_valorizzato_al_completamento_del_documento_Shipment) [14 06/02/2018  - Inserito Errore durante il salavataggio nel caso che la data  Registrazione Fattura sia antecedente all'ultima data della fattura  registrata (sia di vendita che d'acquisto)](http://192.168.178.102/index.php/Patch_iDempiere_Consulting#06.2F02.2F2018_-_Inserito_Errore_durante_il_salavataggio_nel_caso_che_la_data_Registrazione_Fattura_sia_antecedente_all.27ultima_data_della_fattura_registrata_.28sia_di_vendita_che_d.27acquisto.29)  


 **File:**org.adempiere.base__org.compiere.model.Tax20160509.patch

![Patch 1.png](http://192.168.178.102/images/5/5b/Patch_1.png)
 

### 30/06/2016 - Genera Spedizioni (manuale) e Genera Fatture (manuale)

 **File:**org.adempiere.webui.apps.form__WInvoiceGen-WInOutGen20160630.patch

![Patch 2.png](http://192.168.178.102/images/a/a2/Patch_2.png)
 

### 19/10/2016 - add patch per annullare il problema di salvataggio dopo l'inserimento di un attributo di istanza nella orderline

 **File:**org.adempiere.base_org.compiere.model.MOrderLine_AttributeFree.patch

Modifiche effettuate ![Patch 3.png](http://192.168.178.102/images/c/cd/Patch_3.png)

### 29/12/2016  - Salto controllo PAYMENTRULE_DirectDeposit e PAYMENTRULE_DirectDebit  per visualizzazione completa dei metodi di pagamento

**File:**org.compiere.model.MPaymentLookup20161229.patch

Modifiche effettuate ![Patch 4.png](http://192.168.178.102/images/2/2d/Patch_4.png)

### 21/04/2017 - Overwrite del PostingType sul GL + controllo 'Any Account' flaggato su GL Distribution

**PACK-IN:**Patch_2pack_GLDistribution.zip
 **File:**org.adempiere.base_org.compiere.act.Fact20170421.patch

Modifiche effettuate![Patch 5.png](http://192.168.178.102/images/2/29/Patch_5.png)

IMPORTANTE: APPLICARE IL PACK-IN PRESENTE NELLA CARTELLA DEL  "Patch_2pack_GLDistribution.zip" prima dell'utilizzo della patch;  aggiunti i campi "LIT_OverwritePostingType" e "PostingType" --- Table  'GL_DistributionLine'

### 17/05/2017 - Gestione IVA indetraibile


 **File:**org.adempiere.base_org.compiere.acct.Doc_Invoice20170517.patch

Modifiche effettuate ![Patch 6.png](http://192.168.178.102/images/a/a1/Patch_6.png)



###  23/05/2017 - Messaggi di Errore - popup completa e scompare con chiusura manuale

**File:**org.adempiere.ui.zk_org.adempiere.webui.adwindow.StatusBar20170523.patch

![Patch 7.png](http://192.168.178.102/images/3/31/Patch_7.png)



###  23/05/2017 - Messaggio "No inventory available" rimosso in base a variabile di sistema LIT_DisableMessageNoInventory=Y

**File:**org.adempiere.base.callout_org.compiere.model.CalloutOrder-CalloutMovement20170523.patch

![Patch 8 1.png](http://192.168.178.102/images/e/e7/Patch_8_1.png)


 

### 01/08/2017 - Creazione di nuovo listino prezzi in base a variabile di sistema IDIT_PO_PriceList

**File:**org.adempiere.base_org.compiere.model.MOrderLine20170727.patch
 Vedi [Plugin_Base#CREA_LISTINO](http://192.168.178.102/index.php/Plugin_Base#CREA_LISTINO) per il tipo di valorizzazione della variabile

![Patch 8 2.png](http://192.168.178.102/images/0/05/Patch_8_2.png)
 

**ATTENZIONE ERRORE PATCH NELL'INTERCOMPANY**:

Questa Patch darà un Errore di Listino Prezzi in una particolare  casistica dell'Intercompany (Generazione automatica ODA <-->  ODV,...). Vediamo dove, esempio in GardenWorld:

\- Dopo aver collegato i BP all'organization (vedi immagine sotto)

[![Link Org.png](http://192.168.178.102/images/thumb/3/35/Link_Org.png/800px-Link_Org.png)](http://192.168.178.102/index.php/File:Link_Org.png)

Creo un Ordine di Vendita (o di acquisto) al Business Partner "HQ" - Organization "Forniture"

[![Link Org1.png](http://192.168.178.102/images/thumb/e/e1/Link_Org1.png/800px-Link_Org1.png)](http://192.168.178.102/index.php/File:Link_Org1.png)

Se il prodotto è: "Distinta Base" e Tipo "Stock='Y'" allora il  completamento dell'ordine andrà a buon fine, MA nel caso in cui il  prodotto sia "isStocked='N'" allora il completamento dell'ordine andrà  in ERRORE (causato proprio da questa Patch, che ovviamente sarà da  modificare). Con isStock='N' le righe dell'ordine vengono trasformate,  perchè vengono inseriti tutti i figli della distinta base "Assembly Back  Leg", ecco che qui si scatena l'errore

[![Link Org2.png](http://192.168.178.102/images/8/87/Link_Org2.png)](http://192.168.178.102/index.php/File:Link_Org2.png)

### 01/08/2017 - Nuova gestione termini di pagamento

**File:**org.adempiere.base__newPaymentTerm20170731.patch

![Patch 10 1.png](http://192.168.178.102/images/2/2f/Patch_10_1.png)
![Patch 10 2.png](http://192.168.178.102/images/d/d5/Patch_10_2.png)![Patch 10 3.png](http://192.168.178.102/images/4/4f/Patch_10_3.png)![Patch 10 4.png](http://192.168.178.102/images/7/78/Patch_10_4.png)![Patch 10 5.png](http://192.168.178.102/images/8/83/Patch_10_5.png)![Patch 10 6.png](http://192.168.178.102/images/f/f5/Patch_10_6.png)![Patch 10 7.png](http://192.168.178.102/images/1/1f/Patch_10_7.png)

### 09/10/2017 - Processo adattato alla T_Selection delle infoWindow, per le tabelle che prevedono il "posted"

**File:**org.adempiere.base.process_org.adempiere.process.ClientAcctProcessor20171006.patch

![Patch 11 1.png](http://192.168.178.102/images/c/c8/Patch_11_1.png) ![Patch 11 2.png](http://192.168.178.102/images/a/ae/Patch_11_2.png) ![Patch 11 3.png](http://192.168.178.102/images/9/90/Patch_11_3.png)**File:**org.adempiere.base.process_org.compiere.process.FactAcctReset20171009.patch![Patch 11 4.png](http://192.168.178.102/images/7/78/Patch_11_4.png)![Patch 11 5.png](http://192.168.178.102/images/3/39/Patch_11_5.png)
![Patch 11 6.png](http://192.168.178.102/images/8/8f/Patch_11_6.png)

### 23/11/2017 - Parametrizzazione contenuto cssStyle

**File:**org.adempiere.ui.zk_org.adempiere.webui.editor.WEditor20171123.patch![Patch 13 1.png](http://192.168.178.102/images/c/c4/Patch_13_1.png)![Patch 13 2.png](http://192.168.178.102/images/9/9c/Patch_13_2.png)
 ![Patch 13 3.png](http://192.168.178.102/images/6/68/Patch_13_3.png)

### 06/12/2017 - Utilizzo del campo "Peso", se valorizzato al completamento del documento Shipment

**File:**org.adempiere.base_org.compiere.model.MInOut20171206.patch![Patch 14.png](http://192.168.178.102/images/b/b4/Patch_14.png)


 



### 06/02/2018  - Inserito Errore durante il salavataggio nel caso che la data  Registrazione Fattura sia antecedente all'ultima data della fattura  registrata (sia di vendita che d'acquisto)

**File:**org.adempiere.base_org.compiere.model.MInvoice20180206.patch![PatchInvoice.png](http://192.168.178.102/images/1/12/PatchInvoice.png)


 
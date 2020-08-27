# Plugin: RIBA

---

## Riferimenti

- link pubblico  : non applicabile
- link idempeire italia  : <https://bitbucket.org/consulnet/idempiere-ita-plugin>
- link jar  : /opt/repos/idempiere-italia-pugin/it.cnet.impl.LIT_RIBA/
- versione idempiere  : idempiere 5.1

---

## Descrizione Plugin

```
Ogni fattura con regola di pagamento RIBA (addebito diretto) viene registrata in un conto speciale "conto generico RIBA".
Questo genera automaticamente un GL Journal (Prima Nota) quando si completa la fattura (o si modifica la regola di pagamento di una fattura completata da NON-RIBA a RIBA)
```

---

## Parametrizzazione Plugin

- Definiamo un conto "RIBA Generic Account" nella window dello Schema Contabile

[![Riba1.png](http://192.168.178.102/images/thumb/4/49/Riba1.png/1000px-Riba1.png)](http://192.168.178.102/index.php/File:Riba1.png)

- Definiamo un conto "RIBA Bank Account" nella window Banca (il tipo di conto deve essere contrassegnato come "non controllato dal Documento" per consentire le registrazioni Prima Nota)

[![Riba2.png](http://192.168.178.102/images/thumb/3/37/Riba2.png/1000px-Riba2.png)](http://192.168.178.102/index.php/File:Riba2.png)

---

## Documentazione Tecnica Plugin

Requirement:

[![Riba.png](http://192.168.178.102/images/thumb/a/af/Riba.png/900px-Riba.png)](http://192.168.178.102/index.php/File:Riba.png)

RIBA processing has several stages:

Generation

- Each invoice with payment rule RIBA (Direct Debit) is posted in a special account "RIBA Generic Account"
- This is intended to be solved generating automatically a GL Journal when completing the invoice (or changing payment rule of a completed invoice)

Presentation

- Periodically a group of RIBA invoices (or invoice schedules) are selected and presented to the bank
- At this moment a second posting happens moving from the "RIBA Generic Account" to "RIBA Bank Account"
- This functionality will work with:
  - Payment Selection (manual or automatic) for Direct Debit
  - Prepare Payments - this generate the checks
  - From the checks use the "RIBA Generate File and Journal" process to generate the intended file for the bank and the journal for the posting

Collection

- Finally when the bank notifies the invoices collected the payments are created
- An info window "RIBA Generate Payments" will create the payments for the selected check records


Technical:

Generation:

- Add an account in accounting schema window for RIBA Generic Account
- Add an account in bank window for RIBA Bank Account
- Create a model validator on complete invoice to generate a GL Journal posting the A/R to RIBA Generic Account
- Create a model validator on change a completed invoice to reverse or generate a GL Journal posting the A/R to RIBA Generic Account

Presentation:

- Configure sysconfig key PAYMENT_SELECTION_MANUAL_ASK_INVOKE_GENERATE to N
- Use Payment Selection manual or automatic to create the Direct Debit lines
- Use Prepare Payments button to create the checks
- Use the "RIBA Generate File and Journal" to create the file and optionally the journal that transfer the A/R from RIBA Generic to RIBA Bank

Collection:

- Use the info window "RIBA Generate Payments" to mark the checks collected and call the corresponding process to create the payments
- Create a model validator on complete allocation to generate a GL Journal posting the A/R to RIBA Bank Account

Required configuration:

- Define RIBA Generic Account on Accounting Schema / GL Ledger
- Define RIBA Bank Account on Bank
- The customer Accounts Receivable must be marked as non-document controlled to allow GL Journals on that account

- The Bank Account IBAN must start with IT or SM and then the IBAN is written in file as the characters 6 to 10
- The BP Bank Account IBAN is written in file as the characters 6 to 15 - taken from AccountNo

SYSCONFIG variables to configure:

LIT_DOCTYPE_FOR_RIBA_GENERIC_JOURNAL:

- per client or organization to define the document type ID to be used when generating RIBA GL Journal generic invoice
- if not set the system will use the default doctype ID for GL Journal

LIT_DESCRIPTION_FOR_RIBA_GENERIC_JOURNAL:

- per client or organization to define the template description to be used when generating RIBA GL Journal generic invoice
- you can use context variables related to invoice fields, example:

"RIBA Generic posting for invoice @DocumentNo@ from BP @C_BPartner_ID<Name>@ at @DateInvoiced<MMMMM dd/yyyy>@"

LIT_DESCRIPTION_FOR_RIBA_BANK_JOURNAL:

- per client or organization to define the template description to be used when generating header RIBA GL Journal bank invoice

LIT_DESCRIPTION_FOR_RIBA_BANK_JOURNAL_LINE:

- per client or organization to define the template description to be used when generating line RIBA GL Journal bank invoice

LIT_SIA_CODE: (variabile di sistema)

- per client to define the SIA code to be put in the RIBA file

[Technical info](http://192.168.178.102/index.php?title=Technical_info&action=edit&redlink=1)

Window : Payment /Payment Process on Toolbar it.cnet.impl.process.LIT_ProcessRIBABatch

### InfoWindow "RIBA Generate Payments"

- Select infoWindow:
  - **SQL From**:

```
C_PaySelectionCheck psc 
JOIN C_BPartner bp ON (psc.C_BPartner_ID=bp.C_BPartner_ID)
JOIN C_BP_BankAccount bba ON (bba.C_BP_BankAccount_ID=psc.C_BP_BankAccount_ID)
JOIN C_Bank b ON (bba.C_Bank_ID=b.C_Bank_ID)
```

- - **Sql WHERE**:

```
psc.C_Payment_ID IS NULL AND psc.C_PaySelection_ID IN (
SELECT C_PaySelection_ID from C_PaySelection
WHERE
EXISTS (SELECT 1 from C_PaySelectionLine psl WHERE PaymentRule='D' AND C_PaySelectionCheck_ID IS NOT NULL AND  
psl.C_PaySelection_ID=C_PaySelection.C_PaySelection_ID)
AND NOT EXISTS (SELECT 1 from C_PaySelectionLine psl WHERE PaymentRule!='D' AND psl.C_PaySelection_ID=C_PaySelection.C_PaySelection_ID)
AND EXISTS (SELECT 1 from c_payselectioncheck psc WHERE C_Payment_ID IS NULL AND psc.C_PaySelection_ID=C_PaySelection.C_PaySelection_ID)
) 
```

- - Sql ORDER BY:

```
bp.Name
```

[![testo alternativo](http://192.168.178.102/images/thumb/8/84/Payselect.png/800px-Payselect.png)](http://192.168.178.102/index.php/File:Payselect.png)

---

## Riferimenti Utili

```
http://www.economiaziendale.net/scritture/incasso_ricevute_bancarie_sbf.htm
https://www.gruppobancasella.it/bsh/documenti_statici/pdf/psd/manuale-per-impostare-il-tracciato-cbi-arricchito-ai-fini-sepa.pdf
http://www.mobilefish.com/services/sepa_xml/sepa_xml.php
```

---
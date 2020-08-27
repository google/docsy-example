---
title: "Tabella con Translation"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 40
pre: "<b> </b>"
---


## Traduzione Tabelle (Table_Trl)

Vogliamo tradurre il contenuto del nuovo campo in italiano o in altre lingue. Supponiamo che la nuova finestra sia dotata di due campi da tradurre: nome e descrizione.

Vediamo i seguenti passaggi:

(1) Creo la tabella. Sto usando un tabella molto semplice con nome e descrizione dei campi.

```
CREATE TABLE c_bambam (
c_bambam_id numeric(10,0) PRIMARY KEY NOT NULL,
ad_client_id numeric(10,0) NOT NULL,
ad_org_id numeric(10,0) NOT NULL,
isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
created timestamp without time zone DEFAULT now() NOT NULL,
createdby numeric(10,0) NOT NULL,
updated timestamp without time zone DEFAULT now() NOT NULL,
updatedby numeric(10,0) NOT NULL,
name character varying(60) NOT NULL,
description character varying(255),
c_bambam_uu character varying(36) DEFAULT NULL::character varying,
CONSTRAINT c_bambam_isactive_check CHECK ((isactive = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))));
```

(2) Creo la tabella di traduzione. Notare che cambia una colonna e ne aggiungo altre due

```
CREATE TABLE c_bambam_trl (
c_bambam_trl_uu character varying(36) DEFAULT NULL::character varying, --changed
ad_language character varying(6) NOT NULL, --added
istranslated character(1) DEFAULT 'N'::bpchar NOT NULL, --added
c_bambam_id numeric(10,0) NOT NULL,
ad_client_id numeric(10,0) NOT NULL,
ad_org_id numeric(10,0) NOT NULL,
isactive character(1) DEFAULT 'Y'::bpchar NOT NULL,
created timestamp without time zone DEFAULT now() NOT NULL,
createdby numeric(10,0) NOT NULL,
updated timestamp without time zone DEFAULT now() NOT NULL,
updatedby numeric(10,0) NOT NULL,
name character varying(60) NOT NULL,
description character varying(255),
CONSTRAINT c_bambam_isactive_check CHECK ((isactive = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))),
CONSTRAINT c_bambam_istranslated_check CHECK ((istranslated = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))));
```

(3) Dal momento che la tabella di traduzione non dispone di una chiave primaria naturale, dobbiamo aggiungerla.(Necessaria per consentire a PostgreSQL di salvare un record)

```
ALTER TABLE c_bambam_trl ADD PRIMARY KEY (ad_language, c_bambam_id);
```

(4) Importare la tabella C_BamBam in iDempiere (dal processo "Create Column from DB"). Spuntare sia il nome e la descrizione delle colonne come "translated". La casella "translated" è nella parte inferiore della scheda => nella sezione tecnica (Technical).

(5) Importare la tabella C_BamBam_Trl in iDempiere (dal processo "Create Column from DB").. Assicurarsi che la colonna C_BamBam_ID sia contrassegnata come "Parent Link Column"

(6) Costruire la window. Assicurarsi di creare una scheda denominata TRanslation in cui il livello di scheda = 1 e la scheda sia contrassegnata come isTranslation.
aso).

(7) Prova!! Ricorda di spuntare dalla window Client il campo "Multi Lingual Document"



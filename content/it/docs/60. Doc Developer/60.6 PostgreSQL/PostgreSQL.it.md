---
title: "PostgreSQL"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 500
pre: "<b> </b>"
---

## TRIGGERS

```
http://www.thegeekstuff.com/2010/10/postgresql-trigger-tutorial-with-emp-table-examples/
http://technobytz.com/sql-trigger-example-in-postgresql.html 
http://www.postgresqltutorial.com/creating-first-trigger-postgresql/
http://www.w3resource.com/PostgreSQL/postgresql-triggers.php
http://solaimurugan.blogspot.it/2010/08/cross-database-triggers-in-postgresql.html
```

Vediamo un esempio di come utilizzare un Trigger nella window Business Partner. 
Vogliamo fare in modo che ad ogni aggiornamento di un record venga copiato il campo Name nel campo Name2

![image](/image/PostgreSQL-Trigger.png)

Vediamo il codice compilato in PgAdmin:

![image](/image/PostgreSQL-Gantt1.png)

```
--DROP  FUNCTION  test() CASCADE;
CREATE  or replace function test() RETURNS TRIGGER AS '
BEGIN
IF tg_op=''UPDATE'' THEN
new.Name2 := new.Name;
END IF;  
RETURN new;
END;
'
language 'plpgsql';
```

```
CREATE TRIGGER c_bpartner_test_trig
BEFORE INSERT or UPDATE
ON c_bpartner
FOR EACH ROW 
execute procedure test();
```

---

## Estensione DBLINK (linkare su un altro database)

Prima di tutto dobbiamo avere il contrib installato. Dopodichè dobbiamo lanciare questo comando da postgres (pgAdmin)

```
CREATE EXTENSION dblink;
```

Adesso possiamo provare il test di connessione al database

```
SELECT DBLINK_CONNECT('dbname=idempiere host=192.168.0.63' );
```

Possiamo quindi creare un trigger tra un database e l'altro

---

## Estensione uuid-ossp (funzioni varie)

```
CREATE EXTENSION "uuid-ossp";
```

---

## Linguaggio PLSH (per utilizzare comandi linux)

```
sudo apt-get update
sudo apt-get install postgresql-9.3-plsh
```

Da PgAdmin lanciamo il seguente comando:

```
CREATE EXTENSION plsh;
```

---

## DATA WRAPPERS

```
https://www.enterprisedb.com/postgresql-91-meet-mysql
https://www.codeweavers.com/store
https://github.com/cyga/www_fdw/wiki/Examples
```

---

## DHTMLX GANTT

Prima di tutto dobbiamo installare Apache e php5

```
apt-get install apache2
apt-get install php5
apt-get install php5-pgsql
apt-get install libapache2-mod-php5
```

Scaricare il pacchetto dhtmlxGantt_4.1.0 (link: https://dhtmlx.com/x/download/regular/dhtmlxGantt.zip)

Scompattarlo all'interno della seguente directory:

```
/var/www/html/
```

Adesso possiamo aprire qualsiasi pagina di questa cartella, vediamo un esempio:

```
localhost/dhtmlxGantt_v4.1.0/samples/index.html
```

### Collegamento con iDempiere

Apriamo il file "config.php" all'interno della seguente directory /var/www/html/dhtmlxGantt_v4.1.0/samples/common/ e impostiamo il database PostgreSQL (di default è impostato il db_sqlite3). Vediamo le impostazioni:

![image](/image/PostgreSQL-Gantt2.png)

Dopo aver impostato la connessione a PostgreSQL, dobbiamo fare una piccola modifica al file "db_postgre.php" situato nella directory /var/www/html/dhtmlxGantt_v4.1.0/codebase/connector/  

Dobbiamo modificare il nome dello schema da "public" ad "adempiere". Vedi immagine:

![image](/image/PostgreSQL-Gantt3.png)

Idem per lo stesso file presente nella directory /var/www/html/dhtmlxGantt_v4.1.0/samples/common/

Sempre nella directory /sample/common possiamo vedere vari connettori che fanno riferimento alle pagine html. Ad esempio "connector_enddate.php" fa riferimento alla pagina "15_connector_json_enddate.html" presente nella directory /var/www/html/dhtmlxGantt_v4.1.0/samples/01_initialization/

In questo file "connector_enddate.php" si fa riferimento alla tabella di postgres (anche negli altri file richiamiamo la tabella che ci interessa)

![image](/image/PostgreSQL-Gantt4.png)

Come possiamo vedere dalla foto si fa riferimento alla tabella "gantt_tasks_enddate", quindi verrà richiamata questa tabella, il suo id ed i suoi campi. Creiamo questa tabella adesso su postgreSQL e successivamente su idempiere. Vediamo l'esempio nella sezione successiva

### Esempio

Adesso dobbiamo creare la tabella "gantt_tasks_enddate"

```
-- DROP TABLE gantt_tasks_enddate;
```

```
CREATE TABLE gantt_tasks_enddate
(
gantt_tasks_enddate_id numeric(10,0) NOT NULL,
gantt_tasks_enddate_uu character varying(36) DEFAULT NULL::character varying,
ad_client_id numeric(10,0) NOT NULL,
ad_org_id numeric(10,0) NOT NULL,
isactive character(1) NOT NULL DEFAULT 'Y'::bpchar,
created timestamp without time zone NOT NULL DEFAULT now(),
createdby numeric(10,0) NOT NULL,
updated timestamp without time zone NOT NULL DEFAULT now(),
updatedby numeric(10,0) NOT NULL,
id integer NOT NULL,
text character varying(255) NOT NULL,
start_date timestamp without time zone,
end_date timestamp without time zone,
progress character varying(10) NOT NULL,
sortorder numeric NOT NULL DEFAULT (0)::numeric,
parent integer NOT NULL,
CONSTRAINT gantt_tasks_enddate_pkey PRIMARY KEY (id)
)
WITH (
OIDS=FALSE
);
  ALTER TABLE gantt_tasks_enddate
  OWNER TO adempiere;
```

Andiamo su

``` 
http://localhost/dhtmlxGantt_v4.1.0/samples/01_initialization/15_connector_json_enddate.html
```

e adesso possiamo fare tutte le modifiche che vogliamo, DataWrappers funzionante

![image](/image/PostgreSQL-Gantt3.png)Tools

Sql onlin formatting http://www.dpriver.com/pp/sqlformat.htm

---

## Tutorial completi online

```
http://www.postgresqltutorial.com/
http://www.tutorialspoint.com/postgresql/
```

### NOZIONI

JOIN LEFT RIGHT AND OUTER http://javarevisited.blogspot.it/2013/05/difference-between-left-and-right-outer-join-sql-mysql.html

                          ```
https://www.codeproject.com/Articles/33052/Visual-Representation-of-SQL-Joins
                          ```

### PERFORMANCE & TUNING

```
Calcolo online parametri postres http://pgtune.leopard.in.ua/
```

### SQL on JSON

```
https://www.citusdata.com/blog/2013/05/30/run-sql-on-json-files-without-any-data-loads/
```

---

## Book Postgresql High Performance

```
CREATE TABLE accounts(owner text, balance numeric);
INSERT INTO accounts VALUES ('Bob',100);
INSERT INTO accounts VALUES ('Mary',200);
```

```
UPDATE accounts SET balance = balance - 14.00 WHERE owner = 'Bob';
UPDATE accounts SET balance = balance + 14.00 WHERE owner = 'Mary';
```

``` 
CREATE OR REPLACE FUNCTION transfer(i_payer text,i_recipient text,i_amount numeric(15,2))
RETURNS text AS $$
DECLARE
payer_bal numeric;
BEGIN
SELECT balance INTO payer_bal
FROM accounts
WHERE owner = i_payer FOR UPDATE;
IF NOT FOUND THEN RETURN 'Payer account not found';

END IF;

IF payer_bal < i_amount THEN  RETURN 'Not enough funds';
END IF;
UPDATE accounts
SET balance = balance + i_amount
WHERE owner = i_recipient;
IF NOT FOUND THEN  RETURN 'Recipient does not exist';
END IF;
UPDATE accounts
SET balance = balance - i_amount
WHERE owner = i_payer;
RETURN 'OK';
END;
$$ LANGUAGE plpgsql;
```

```
CREATE TYPE FRUIT_QTY as (name text, qty int);
Select '("APPLE",3'::FRUIT_QTY;
```

``` 
CREATE FUNCTION fruit_qty_larger_than(left_fruit FRUIT_QTY,right_fruit FRUIT_QTY)
RETURNS BOOL
AS $$
BEGIN
IF (left_fruit.name = 'APPLE' AND right_fruit.name = 'ORANGE')
THEN
RETURN left_fruit.qty > (1.5 * right_fruit.qty);
END IF;
IF (left_fruit.name = 'ORANGE' AND right_fruit.name = 'APPLE' )
THEN
RETURN (1.5 * left_fruit.qty) > right_fruit.qty;
END IF;
RETURN left_fruit.qty > right_fruit.qty;
END;
$$
LANGUAGE plpgsql; 
```

---

## Book Postgresql High Performance

1. Postgresql Versions = pag. 7/28

```
Perfomance 8.0 Peak 
 8.021Read-only TPS 1256 write 361  # of clients at pead 4 / write 2
 8.4.1              13546       2713                 22  / write 12
 postgresql contrib  https://www.postgresql.org/docs/9.5/static/contrib.html
 pgbench -V   [ check version of pgbench ]
```

2. Database Hardware = pag 21/42

```
Raid ...
```

3. Database Hardware Benchmarking = pag 41/62

```
- ram testing 
- cpu benchmerking 
```

### timing

```
\timing
SELECT sum(generate_series) FROM generate_series(1,1000000);
```

```
\timing
CREATE TABLE test (id INTEGER PRIMARY KEY);
INSERT INTO test VALUES (generate series(1,100000));
EXPLAIN ANALYZE SELECT COUNT(*) FROM test;
```

### dd

```
blocks = 250,000 * (gigabytes of RAM)
time sh -c "dd if=/dev/zero of=bigfile 
time dd if=bigfile of=/dev/null bs=8k
```

### 4 Disk Setup

## 5 Memory for DB caching =

for postgresql.conf -

```
wal_buffers = 64 KB
```


# How to Postgres & SQL

---

### Tools

```
https://wiki.postgresql.org/wiki/Lock_Monitoring 
jdbc driver https://jdbc.postgresql.org/download.html
http://www.sqlines.com/online
http://www.aquafold.com/
http://apgdiff.com/how_to_use_it.php
```

### Tutorial

```
http://www.postgresql.org/docs/manuals/
http://www.postgresqltutorial.com/
http://momjian.us/main/presentations/overview.html
http://www.faqs.org/docs/ppbook/book1.htm
http://www.tutorialspoint.com/postgresql/
http://www.postgresqlforbeginners.com/
http://www.postgresguide.com/
```

### Admin stuff

```
Backup http://www.thegeekstuff.com/2009/01/how-to-backup-and-restore-postgres-database-using-pg_dump-and-psql/
Backup https://wiki.postgresql.org/wiki/Automated_Backup_on_Linux
Drop Schema  Select 'drop table if exists idempiere."' || tablename  '" cascade;' from pg_tables where schemaname ='idempiere';
```

### Codice sql

```
https://wiki.postgresql.org/wiki/First_steps
http://www.thegeekstu0ff.com/2009/04/15-practical-postgresql-database-adminstration-commands/
===reset user password ===codecademy.com/en/courses/learn-java/lessons/introduction-to-java/exercises/data-types-1?action=resume
```

### Tips & Tricks

Date and Time <http://www.postgresql.org/docs/8.2/static/functions-datetime.html>

<http://www.codeproject.com/Articles/271580/Repeating-a-SQL-row-based-on-a-value-in-a-differen>

```
pg_dump -U adempiere idempiere -f dump.sql
sudo su - postgres 
psql -f "dump.sql"
/etc/init.d/postgresql start!stop!restart
```

## SQL by example

ALTER TABLE c_BPartner ALTER COLUMN code TYPE numeric(10,0);

Creazione tabella con due righe:

```
CREATE TABLE accounts (owner text, balance numeric);
INSERT INTO accounts VALUES ('Bob',100);
INSERT INTO accounts VALUES ('Mary',200);
```


Creo una funzione

```
CREATE OR REPLACE FUNCTION transfert(
                i_payer text,
```

i_recipient text, i_amount numeric(15,2))

```
RETURNS text
AS
$$
DECLARE
payer_bal numeric;
BEGIN
SELECT balance INTO payer_bal
FROM accounts
```

Note. Creo una funzione di nome “transfer” e creo tre variabili “i_payer text”, “i_recipent text”, “i_amount numeric (15,2)”.

Lanciare esecuzione della Funzione

postgres=# SELECT * FROM transfer('Bob','Mary',14.00);

Lui ritorna :

transfer

------

OK (1 row)


CREATE ROLE name; SELECT rolname FROM pg_roles;

### SQL

3.0 SQL TIPS Ricerca di intervalli di giorni, ore, minuti, etc… Esempio: (classe java: it.cnet.impl.webui.apps.form.ResAtt_Prod)

"and (s_resourceattendance.assigndatefrom > (now() - interval '"+ m_timeInterval +" minutes') or ……”


update c_bpartner set nationalidnumber = (select lit_nationalidnumber_id from lit_nationalidnumber where c_bpartner.nationalidnumber=lit_nationalidnumber.nationalidgenerate and c_bpartner.description is not null group by lit_nationalidnumber_id )



### UPDATE SQL FROM OTHER TABLE

update c_bpartner set nationalidnumber = (select lit_nationalidnumber_id from lit_nationalidnumber where c_bpartner.nationalidnumber=lit_nationalidnumber.nationalidgenerate and c_bpartner.description is not null group by lit_nationalidnumber_id )

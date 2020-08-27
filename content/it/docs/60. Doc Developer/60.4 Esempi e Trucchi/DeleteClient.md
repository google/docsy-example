---
title: "Delete Client"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 500
pre: "<b> </b>"
---



---

Per cancellare un Client da Idempiere (es:GardenWorld) dobbiamo lanciare il seguente script da Pg_Admin:

<https://bitbucket.org/CarlosRuiz_globalqss/idempiere-stuff/src/519bb7009da70846eb58d00e9982ec9c69a4ae9e/DeleteAdempiereClient_pg.SQL?at=stuff&fileviewer=file-view-default>

```
CREATE OR REPLACE FUNCTION drop_client(db_name text, client_id integer) 
RETURNS integer AS 
$BODY$ 
DECLARE 
   db_name text := $1; 
   c_id integer := $2; 
   r_table RECORD; 
BEGIN 
   RAISE NOTICE 'Setting search_path=%', db_name; 
   EXECUTE 'SET search_path=' || db_name; 
   RAISE NOTICE 'Deleting %.Client Where AD_Client_ID=%', db_name, c_id; 
   RAISE NOTICE 'Disable triggers and constraints';
   update pg_trigger set tgenabled = 'D' where oid in ( 
       select tr.oid from pg_class cl, pg_trigger tr, pg_namespace ns 
           where tr.tgrelid = cl.oid 
               and  cl.relnamespace = ns.oid 
               and ns.nspname = db_name);  
   RAISE NOTICE 'Removing records belonging to client %', c_id; 
   FOR r_table IN 
       SELECT tablename, 'AD_Client_ID' AS columnname
           FROM AD_TABLE a
           WHERE a.isview = 'N' AND a.isactive = 'Y'
               AND EXISTS (
                   SELECT ad_column_id
                       FROM AD_COLUMN c
                       WHERE a.ad_table_id = c.ad_table_id
                       AND UPPER (c.columnname) = 'AD_CLIENT_ID')
```

-- TO DO Assure that the table is really a table in database -- AND EXISTS (SELECT 1 FROM user_objects dbo WHERE UPPER(dbo.object_name)=UPPER(a.TableName) AND dbo.object_type='TABLE')

```
       UNION
       SELECT tablename, columnname
           FROM AD_COLUMN c, AD_TABLE t
           WHERE ad_reference_value_id = 129
               AND UPPER (columnname) <> 'AD_CLIENT_ID'
               AND t.ad_table_id = c.ad_table_id
               -- TO DO Assure that the table is really a table in database
               -- AND EXISTS (SELECT 1 FROM user_objects dbo WHERE UPPER(dbo.object_name)=UPPER(t.TableName) AND dbo.object_type='TABLE')
   LOOP 
       RAISE NOTICE 'Removing items from table - %', r_table.tablename; 
       EXECUTE 'DELETE FROM ' || r_table.tablename || ' WHERE ' || r_table.columnname || ' = ' || c_id;
   END LOOP; 
   RAISE NOTICE 'Enable triggers & constraints'; 
   update pg_trigger set tgenabled = 'O' where oid in ( 
       select tr.oid from pg_class cl, pg_trigger tr, pg_namespace ns 
           where tr.tgrelid = cl.oid 
               and  cl.relnamespace = ns.oid 
               and ns.nspname = db_name); 
   RAISE NOTICE 'Done'; 
   RETURN 1; 
END; 
$BODY$ 
LANGUAGE 'plpgsql' VOLATILE 
COST 100; 
ALTER FUNCTION drop_client(text, integer) OWNER TO postgres;
```

Dopo aver lanciato questo script posso specificare il mio client da eliminare tramite il seguente comando SQL:

```
SELECT <db_name>.drop_client('<db_name>', <client_id>); 
e.g. SELECT drop_client('adempiere', 11); --> Rimuovi GardenWorld
```

 

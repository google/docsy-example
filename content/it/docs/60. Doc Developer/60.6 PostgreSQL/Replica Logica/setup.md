Replica logica (non pglogical, simile ma incompatibile) 
Master-Slave PostgreSQL 10+

parole chiave:
 - WAL
passi fondamentali:
 1- impostare sul provider la chiave wal_level = logical  (= replica non molto diverso ma meno efficiente?) ( tutte le altre chiavi vanno bene i default, prima erano tutti a zero)
 2- impostare sul provider una pubblicazione (una o + insiemi di tabelle da replicare, ricordo che adesso la replica può essere selettiva
 3- impostare sul subscriber la sottoscrizione

(ovviamente lo schema di arrivo deve essere uguale a quello di partenza)

pronti via!


dettagli:
1- pg_conftool set wal_level logical

2- (previa configurazione per cui possa accettare connessioni esterne)
   ( SQL NON standard ma molto simile)
   CREATE PUBBLICATION  mypub1
     FOR TABLE tablename1,tablename2;   oppure
     FOR ALL TABLES;                    oppure
     + eventuali opzioni
       WITH (publish= 'insert,update'); ....
    
    RTFM
    (altri comandi utili)

     ALTER PUBBLICATION nome
        - ADD TABLE tab1,tab2....
        - DROP TABLE tab1,tab2...
        - SET TABLE tab1,tab2...
    again  RTFM
3- (previa configurazione per cui possa accedere a pg su host provider)
   CREATE SUBSCRIPTION mysub1
    CONNECTION 'host=providerhost'
      'dbname=mydb'
      'user=repuser'
    PUBBLICATION mypub1,mypub2...
    + eventuali opzioni
      WITH (enabled = false,  <-- di default quando crea esegue immediatamente* 
            create_slot = false,
            slot_name = 'myslot',
            copy_data = false, <-- utile in caso di accentratore**
            .... )
            
            * praticamente obbligatorio se su stesso db
            ** di default svuota la tabella di destinazione e poi copia
            
            
    (altri comandi utili)
    ALTER SUBSCRIPTION sub1
       - ENABLE/DISABLE
       - CONNECTION 'host=newhost'
       - SET (slot_name = 'myslot2',...)
       - SET PUBBLICATION pub REFRESH
       - REFRESH PUBBLICATION   <-- fondamentale perchè se la pubblicazione cambia la sottoscrizione, da sola, non se ne accorge
       
    DROP SUBSCRIPTION sub1
    
-----------   FINE  ---------------------

- ----- MONITORAGGIO:
tramite viste di sistema:
  - pg_stat_replication
  - pg_replication_slots
  - pg_stat_subscription   (nuova da 10)
  - pg_stat_activity       ( tutto fare)
oppure il log standard di pg
solo in un caso particolare non scrive:
voglio una subscription ma non ci sono abbastanza worker per attivarla
  
    
-----   NOTE DOLENTI :   

1- replication slot abbandonati
     DROP SUBSCRIPTION si preoccupa di eliminare gli slot ma se tiro giù la macchina o il db o... allora le slot restano appese gonfiando pg fino alla morte!
     (soluzione: usare vista pg_replication_slots e la funzione pg_xlog_location_diff(...) )
     monitoraggio spazio disco consigliato in qualunque caso!!
2- NO DDL (per la 10, non so poi..) quindi evitare di usare replica logica su tabelle che cambiano forma molto spesso
3- latenza con transazioni grandi (esegue la replica SOLO alla fine del commit)
      soluzione: dividere la transazione in molte più piccole
4- non trasmette le sequenze  (forse pg12+ ma 11 sicuramente no ) <---  problema??
    ovviamente i dati, quindi gli ID generati da quelle sequenze, vengono copiati normalmente
    quindi prima dello switch (zero downtime) aggiornare tutte le sequenze a mano altrimnenti se INSERT sulla Replica la sequenza comincerà da 0!!!!
5- NO TRUNCATE ( ma disponobile per pg11+)    
    
    
--- PGLOGICAL

risolve alcune limitazione di replica logica:
1- DDL replication helpers
2- sequenze
3- pluggable writers



----------------- usare logical decoding da Python  (40:00) fuori dalla mia portata attuale?
requisiti:
1- psycopg2 >= 2.7
2- pg9.4+
3- output plugin   (wal2json consigliato invece che binario o testo)


    
    
    
    
    

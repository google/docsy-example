---
title: "Plugin Geo Idempiere"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b>732. </b>"
---

## link esterni

```
http://twiav-tt.blogspot.it/
http://www.geonames.org/export/
http://postgis.net/docs/reference.html#Geometry_Constructors
https://github.com/fulcrumapp/geojson-dashboard
http://overpass-api.de/
```



## Obiettivi

Realizzare una pagina web che possa costruire una mappa interrogabile a partire dai dati di idempiere in base a parametri che vengono passati via Get o Post

- Road Map

```
a- inserimento scheda nuova  from map
b- isnerimento scheda nuova from idempiere 
c- inserimento scheda (creazione lit_geao object ) dai dati 
d- select are data from map 
e- load data from map
f- visualizzazione different layer
```

## Strumenti software

- estensione geografica Postgis [[1\]](http://postgis.net/)
- webservice php che effettua una select sul DB e restituisce la geometrie richieste in formato geojSON
  - nel db vanno predisposte opportune viste in base alla chiave che associa gli elementi ad una geometria
- Librerie cartografiche lato client (javascript) che effettuano il rendering della mappa con overlay e livelli si sfondo a scelta tra
  - Leaflet.js [[2\]](http://leafletjs.com/)
  - OpenLayers [[3\]](http://openlayers.org/)
  - Geoext [[4\]](http://geoext.org/)

La scelta è Leaflet.

## Dati in ingresso

Livelli di Overlay: inseriti direttamente in DB postgresql con estensione Postgis

- Limiti amministrativi di Comuni, Province, Regioni forniti da ISTAT [[5\]](http://www.istat.it/it/archivio/104317)
- Aree geografiche che corrispondono a aggregazioni degli oggetti di cui sopra
- Aree geografiche disegnate dall'utente in QGIS ed esportate i geojson da caricare nel DB con una pagina di upload
- Aree geografiche disegnate dall'utente direttamente nell'interfaccia web.

livelli di sfondo

- livelli di sfondo generici disponibili da server pubblici (openstretmap, Bing, google, WMS ministero dell'ambiente, regionoe etc...)
- livelli di sfondo personalizzati (per i quali è opportuno un server WMS [[6\]](https://en.wikipedia.org/wiki/Web_Map_Service) interno)



## Metodi di query

È opportuno decidere quale metodo di query del db utilizzare per restituire i dati

1. predisporre una serie di query preimpostate (ad esempio numero di clienti per comune, per provincia etc.) e passare come unico parametro il nome della query
2. passare al webservice che interroga il database una serie di coppie di parametri (nomecampo; nomevalore) che andranno a costituire la condizione "where" parametri aggiuntivi potrebbero essere la tabella da interrogare e le condizioni di aggregazione
3. ...

## Routing

Il routing con una singola destinazione può essere abbastanza agevole dopo aver selezionato gli elementi sulla mappa: si tratta di effettuare una chiamata ad un servizio esterno che lavora su dati openstreetmap, il quale restituisce una geometria in geojson da visualizzare in mappae una lista delle driving directions. Il routing con una serie di punti intermedi è più complicato e probabilmente serve un servizio a pagamento ma fattibile con lo stesso sistema.

<references group="footnotes" />

## Installazione

verificare che apache abbia il driver PDO per Postgresql

```
sudo apt-get install php5-pgsql
```

installare estensione geografica postgis

```
sudo apt-get install postgis
apt-get install postgresql-9.4-postgis-2-2
sudo su - postgres
psql -U postgres -c  "CREATE EXTENSION postgis;"
sudo aptget install apache2
```

in /etc/apache2/ports.conf::

```
 Listen 8081
```

e in /etc/apache2/sites-enabled/000-default.conf ::

```
 Virtualhost: *:8081
```

Errori :

```
- ERRORE:  apertura del file di controllo dell'estensione "/usr/share/postgresql/9.4/extension/postgis.control" fallita: File o directory non esistente
```

Poi è necessario installare apache [apache](http://192.168.178.102/index.php/Apache)

## Struttura del progetto

Le cartelle e i file più rilevanti del progetto sono le seguenti

```
Leaflet0-5 (librerie leaflet)
|_Plugins    (plugin aggiuntivi Google, Bing, Locate Geosearch)
-js          (file javascript)
|_mappa.js   (file principale con le impostazioni di mappa)
```

## **Parametrizzazione Idempiere**

## Import CSV "Lead"

Per importare il Dataset di Farmacie, Hotel, ecc... basta prendere il modello presente sulla window "Import CSV".

**Attenzione!!!** Importare il csv entrando in idempiere lingua "ITALIANA" altrimenti la Latitudine e Longitudine verranno caricate in modo errato (in italiano con la virgola, in inglese il punto).

Quando si salva il csv, attenzione che La Latitudine e Longitudine non vengano troncate al momento del salvataggio del file

## Maschera "Lead"

Maschera Lead di dove andremo ad inserire i nostri dati, ad esempio farmacie,hotel, ecc... Sono state aggiunte 2 Tab, una riguardante i Dati Georeferenziali (inserimento Lat, Lon e trigger che genera automaticamente il PoinGeom) + Dettaglio Viaggio (es: associo a questo Lead viaggio1, viaggio 2, ecc....)

![Lead1.png](/image/PluginGeoIdempiereLead1.png)

## Maschera "Geographic Select" + "Lead Info" (Info Window)

In questa maschera inizialmente creo un modello/modelli (setaggio di varie impostazione che andrò poi a visualizzare sulla mappa,es: immagini, campi, ecc..).

![GeoSelect.png](/image/PluginGeoIdempiereSelect.png)

Dopo che ho creato il modello/modelli, posso andare nella Info Window "Lead Info" e creare la query di ricerca che desidero

![LeadInfo.png](/image/PluginGeoIdempiereLead1.png)

Bene, ho appena creato un record nella Maschera "Geographic Select", basato sulla query appena effettuata dalla Info Window. Vediamo il risultato:

![GeoSelect1.png](/image/PluginGeoIdempiereGeoSelect1.png)

## Info Ricerche Geo" (Info Window)

In questa Info Window posso visualizzare tutti i miei Geographic Object creati e visualizzare tutte le informazioni Geografiche

![GeoSearch.png](/image/PluginGeoIdempierech.png/800px-GeoSearch.png)

## Crea Itinerario -Maschera "Trip" (Viaggio)

![Trip.png](/image/PluginGeoIdempiereTrip.png)

## Versione OLD

### Riferimenti Tecnici - Tabella con oggetti geografici

Una volta installato Postgis e abilitato nel db di Idempiere con il comando CREATE EXTENSION Postgis, possiamo inserire le geometrie come semplice attributo : tipo campo geometry

- come si creano


Tabella Con questo codice SQL si crea una tabella che contenga le geometrie per tutto il sistema

-- Table: adempiere.lit_geographicobject

```
DROP TABLE adempiere.lit_geographicobject;
CREATE TABLE adempiere.lit_geographicobject
(
 ad_client_id numeric(10,0) NOT NULL,
 ad_org_id numeric(10,0) NOT NULL,
 created timestamp without time zone NOT NULL DEFAULT statement_timestamp(),
 createdby numeric(10,0) NOT NULL,
 description character varying(255) DEFAULT NULL::character varying,
 isactive character(1) NOT NULL DEFAULT 'Y'::bpchar,
 lit_geographicobject_id numeric(10,0) NOT NULL,
 lit_geographicobject_uu character varying(36) DEFAULT NULL::character varying,
 name character varying(60) NOT NULL,
 updated timestamp without time zone NOT NULL DEFAULT statement_timestamp(),
 updatedby numeric(10,0) NOT NULL,
 position_type character varying(50),
 lat double precision,
 lon double precision,
 abs_alt double precision, -- altitudine assoluta (sul livello del mare) in metri
 rel_alt double precision, -- altitudine relativa in metri (ad es. 3 piano = 6 metri)
--point_geom geometry(Point,4326),
--line_geom geometry(LineString,4326),
--poly_geom geometry(Polygon,4326),
 CONSTRAINT lit_geographicobject_key PRIMARY KEY (lit_geographicobject_id),
 CONSTRAINT adclient_lit_geographicobject FOREIGN KEY (ad_client_id)
     REFERENCES adempiere.ad_client (ad_client_id) MATCH SIMPLE
     ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED,
 CONSTRAINT adorg_lit_geographicobject FOREIGN KEY (ad_org_id)
     REFERENCES adempiere.ad_org (ad_org_id) MATCH SIMPLE
     ON UPDATE NO ACTION ON DELETE NO ACTION DEFERRABLE INITIALLY DEFERRED,
 CONSTRAINT lit_geographicobject_uu_idx UNIQUE (lit_geographicobject_uu),
 CONSTRAINT lit_geographicobject_isactive_check CHECK (isactive = ANY (ARRAY['Y'::bpchar, 'N'::bpchar]))
)
WITH (
 OIDS=FALSE
);
ALTER TABLE adempiere.lit_geographicobject
 OWNER TO adempiere;
COMMENT ON TABLE adempiere.lit_geographicobject
 IS 'link table element to geometric object to LAT and LONG reference, point , line ,area';
COMMENT ON COLUMN adempiere.lit_geographicobject.abs_alt IS 'altitudine assoluta (sul livello del mare) in metri';
COMMENT ON COLUMN adempiere.lit_geographicobject.rel_alt IS 'altitudine relativa in metri (ad es. 3 piano = 6metri)'; 
```

-- COLONNE GEOMETRICHE

```
select addgeometrycolumn ('adempiere','lit_geographicobject','point_geom',4326,'POINT',3)
select addgeometrycolumn ('adempiere','lit_geographicobject','line_gem',4326,'LINESTRING',3)
select addgeometrycolumn ('adempiere','lit_geographicobject','ply_geom',4326,'POLYGON',3)
```

### Repository

[GeoIdempiere <https://gitlab.com/Amefad/geoidempiere.git>]

```
LIT_Lead 
-import file csv 
POINT (12.8417476 45.6467225) -> point_geom 
update adempiere.lit_geographicobject set point_geom=st_geomfromtext(description,4326)
update adempiere.lit_geographicobject set lon=ST_X(point_geom)
update adempiere.lit_geographicobject set lat=ST_Y(point_geom)
invece se ho lat long
update adempiere.lit_geographicobject set point_geon=ST_makepoint(lon,lat)
update adempiere.lit_geographicobject set point_geom=st_force3d(st_geomfromtext(description,4326))
```

```
Primo Step
http://localhost/geoidempiere/index.html?user=GardenAdmin

Secondo Step
http://localhost/geoidempiere/index.html?user=GardenAdmin&layers=1+2+3
http://localhost/geoidempiere/index.html?user=Pippo&layers=1+2+3
```

### TRIGGER su tabella LIT_Geographicobject

[![GeoTrigger.png](http://192.168.178.102/images/thumb/4/43/GeoTrigger.png/600px-GeoTrigger.png)](http://192.168.178.102/index.php/File:GeoTrigger.png)

```
--DROP  FUNCTION  autogenerate_PointGeom() CASCADE; 
CREATE  or replace function autogenerate_PointGeom() RETURNS TRIGGER AS '
BEGIN
      set search_path to adempiere,public;
      NEW.point_geom= st_point(NEW.lon,NEW.lat);
RETURN new;
END;
'
language 'plpgsql';
CREATE TRIGGER LIT_Geographicobject_autogenerate_PointGeom
before INSERT or UPDATE
ON LIT_Geographicobject 
FOR EACH ROW 
execute procedure autogenerate_PointGeom();
```

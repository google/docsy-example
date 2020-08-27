---
title: "Apache"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b></b>"
---
# Installazione standard di apache2

## **update dei pacchetti e installazione**

```
root@localhost:/# apt-get update
root@localhost:/# apt-get install apache2
```

La cartella di default per i file web è /var /www, è possibile aggiungere un alias in un file di configurazione dentro 
/etc/apache2/sites-available/000-default.conf 
per pubblicare un altra directory (ad esempio /home/amefad/geoidempiere

    Alias geoidempiere /home/amefad/geoidempiere
    <Directory /home/amefad/geoidempiere>
            Options Indexes FollowSymLinks
            AllowOverride None
            Require all granted
    </Directory>

e ovviamente vanno impostati i permessi necessari:

```
root@localhost:/#chgrp -R www-data /home/amefad/geoidempiere/
root@localhost:/#chmod -R 755 /home/amefad/geoidempiere/
```

e poi avvio di apache

```
root@localhost:/#service apache2 start
```

<h2><a name="module_PDO">PDO</a></h2>

---

<table>
<tr class="h"><th>PDO support</th><th>enabled</th></tr>
<tr><td class="e">PDO drivers </td><td class="v">pgsql </td></tr>
</table>

<h2><a name="module_pdo_pgsql">pdo_pgsql</a></h2>
---
<table>
<tr class="h"><th>PDO Driver for PostgreSQL</th><th>enabled</th></tr>
<tr><td class="e">PostgreSQL(libpq) Version </td><td class="v">9.4.8 </td></tr>
<tr><td class="e">Module version </td><td class="v">1.0.2 </td></tr>
<tr><td class="e">Revision </td><td class="v"> $Id: 0e858dd2051ca8c2fd3c781909a0670ab5fecd36 $  </td></tr>
</table>


<h2><a name="module_pgsql">pgsql</a></h2>
---
<table>
<tr class="h"><th>PostgreSQL Support</th><th>enabled</th></tr>
<tr><td class="e">PostgreSQL(libpq) Version </td><td class="v">9.4.8 </td></tr>
<tr><td class="e">PostgreSQL(libpq)  </td><td class="v">PostgreSQL 9.4.8 on x86_64-unknown-linux-gnu, compiled by gcc (Debian 4.9.2-10) 4.9.2, 64-bit </td></tr>
<tr><td class="e">Multibyte character support </td><td class="v">enabled </td></tr>
<tr><td class="e">SSL support </td><td class="v">enabled </td></tr>
<tr><td class="e">Active Persistent Links </td><td class="v">0 </td></tr>
<tr><td class="e">Active Links </td><td class="v">0 </td></tr>
</table>
<table>
<tr class="h"><th>Directive</th><th>Local Value</th><th>Master Value</th></tr>
<tr><td class="e">pgsql.allow_persistent</td><td class="v">On</td><td class="v">On</td></tr>
<tr><td class="e">pgsql.auto_reset_persistent</td><td class="v">Off</td><td class="v">Off</td></tr>
<tr><td class="e">pgsql.ignore_notice</td><td class="v">Off</td><td class="v">Off</td></tr>
<tr><td class="e">pgsql.log_notice</td><td class="v">Off</td><td class="v">Off</td></tr>
<tr><td class="e">pgsql.max_links</td><td class="v">Unlimited</td><td class="v">Unlimited</td></tr>
<tr><td class="e">pgsql.max_persistent</td><td class="v">Unlimited</td><td class="v">Unlimited</td></tr>
</table>

## installazione PHP5

---

```
root@localhost:/etc/apache2# apt-get install php5
service apache2 restart
```

## Driver postgresql pdo

---

```
root@localhost:/etc/apache2# apt-get install php5-pgsql
```



* (lista)

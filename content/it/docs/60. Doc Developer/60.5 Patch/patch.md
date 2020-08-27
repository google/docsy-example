# Patch

---

## Creare la Patch da Eclipse

---

Dopo aver modificato la parte di codice del Core, dobbiamo creare il "server installer" in modo che possiamo fare l'update della parte appena aggiornata.

Procedimento da Eclipse:

```
- Fare clic destro su org.adempiere.server-feature
- Vai su Buckminster > Invoke Action
- Nella finestra pop-up selezionare create.product.zip 
- Nella casella "Properties file" scegliere il file corretto che descriva il sistema         operativo di destinazione e l'architettura 
  (nel Workspace --> org.adempiere.server-feature selezioniamo                               bukminster_linux_gtk_x86_64.properties )
- Compila il progetto 
- Alla fine è possibile trovare il file di installazione nella home                         $HOME/buckminster.output/org.adempiere.server_3.1.0-                                       eclipse.feature/idempiereServer.gtk.linux.x86_64.zip
```

Per l'update (vedi paragrafo successivo) a noi interessa la seguente directory:

```
$HOME/buckminster.output/org.adempiere.server_3.1.0-eclipse.feature/site.p2/
```

## Update Patch Idempiere-Server

---

Due modi: 

1) Scaricare il repository nel PC locale 

```
hg clone https://bitbucket.org/consulnet/idempiere-italia-build/src
```

​	ed eseguire lo script di aggiornamento della patch (posizionarsi nella directory principale di idempiere-server). Vedi 	esempio:

```
./update.sh file:/directory_di_download_del_repository/site.p2/
```

2) Update direttamente da Bitbucket (ATTUALMENTE NON FUNZIONANTE)

```
/update.sh https://bitbucket.org/consulnet.....
```
# Developer Message

---

Creazione messaggi.

Maschera Messaggi….. utente come System…. TAble: Ad_Message

![image](/image/DeveloperMessage.jpeg)

Possibilità di passare dei parametri: i parametri si identificano con {0}.... {1}.... {2}.... etc.

A livello di codice java:

```
Msg.getMsg(Env.getAD_Language(ctx), "Check_taxTypeBPartner", new String[] {mField.getColumnName()})
```

oppure

```
Msg.getMsg(Env.getCtx(), "TaxCode_NoValidCharacters2", true);
```

I metodi “getMsg” presenti nella classe Msg.java variano a seconda se si vuole passare o meno i parametri; nei metodi stessi si settano i nomi della Search Key presenti sulla maschera Messaggio

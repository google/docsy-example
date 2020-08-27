---
title: "Debug Remoto da Eclipse"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 20
pre: "<b> </b>"
---

# Debug remoto da Eclipse su idempiere-server

---

Per far funzionare il debug remoto da Eclipse, bisogna far partire l'istanza di idempiere-server in questo modo:

```
       /../../idempiere-server/idempiere-server.sh debug
```

Poi andare su Eclipse *Run* > *Debug Configurations* : doppio click sulla voce "*Remote Java Application*"

**Name**: nome del debug

**TAB 'Connect'**

==> **Project**: *immettere il plug-in project su cui voler debuggare*

==> **Connection Type**: *Standard (Socket Attach)*

==> **Host**: *ip della macchina --- E' consigliabile collegarsi PRIMA in VPN e utilizzare gli ip come 10.10.2.41 etc.*

==> **Port**: *4554*

Infine "Apply" e "Debug"

 A questo punto, mettere i punti di breakpoints su codice, dove servono.......

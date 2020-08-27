---
title: "Iptables"
date: 2020-04-24T22:47:10+02:00
draft: false
weight : 10
pre: "<b></b>"
--- 


(mostra tutte le regole di NAT:   iptables -t nat -n --list ) -n serve per NON tradurre ip in altro (hostname, net-name,service)


echo 1 > /proc/sys/net/ipv4/ip_forward      #attivare la comunicazione tra "fuori e dentro"
iptables -F                                 # ripulisce le configurazione precedenti, "azzera" tutto
configurazione di default:
iptables -P INPUT ACCEPT                    # (-P = --policy)
iptables -P OUTPUT ACCEPT
iptables -P FORWARD DROP

# attivazione del masquerading (la traduzione da ip-dentro con ip-fuori e viceverse):
iptables -t nat -A POSTROUTING -s '192.168.0.0/24' -o eth0 -j MASQUERADE                        -j definisce obiettivo(comportamento)
(quindi fino a qui configurato come un "firewall minimale" il comportamento è determinato dalla tabella di appoggio
 infatti iptables -P INPUT ACCEPT = iptables -t filter -P INPUT ACCEPT )

# finalmente accesso DA fuori a macchina locale tramite porta adeguata
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 222 -j DNAT --to 192.168.0.2:22
iptables -t nat -A PREROUTING -i eth0 -p tcp --dport 222 -j REDIRECT --to-port 22


  prerouting obbliga a configurare ingresso (-i) 
  --to obbligatorio dopo -j DNAT 
  
# transparent proxy funziona come un Man In the Middle  ( il proxy appunto)
permetto entrata ed uscita ma non il passaggio da una rete all'altra
-----netfilter-------- modulo kernel stack rete tcp/ip
---iptables   suua interfaccia comandi
serve per scrivere le regole di valutazione dei pacchetti che transitano

tre catene (basilari STANDARD) di appartenenza del pacchetto (mutuamente esclusive)
- INPUT         in arrivo dall'esterno (fuori rispetto a localhost) e diretti qui                                       IN
- OUTPUT        da qui a tutto il mondo esterno                                                                         OUT
- FORWARD       attraversano due adattatori (da modem a LAN, da LAN1 a LAN2..)                                          FWN
due catene avanzate
- PREROUTING                  (port-forwarding , transparent proxy ..)                                                  PRER
- POSTROUTING   permette di alterare un indirizzo tramite protocollo NAT appena prima di uscire da localhost     (nat)  PSTR
- n catene personalizzate (iptables -N miacatena)

due logiche di comportamento (mutuamente esclusive):
- ACCEPT
- DROP 

più tabelle di traduzione:
- filter    : default                                                   ( IN OUT FWD )              firewall
- nat       : quando un pacchetto "crea" una connessione                  ( IN OUT PRER PSTR )        
- mangle    : alterazione pacchetti specializzato                      [( PRER OUT) IN FWD OUT]                                                          
- raw       : configurare le esenzioni dal tracciamento delle connessioni in combinazione con l'obiettivo NOTRACK   ( PRER OUT )
- security  : per (MAC mandatory access control)                          ( IN OUT FWD )

regole valutate in sequenza:
la prima che "matcha" fa "uscire" il pacchetto dalla valutazione


---------------------------------------------------
Le regole non sono persistenti, una volta effettuayo il reboot esse sarnno cancellate. Se le vogliamo fisse dobbiamo salvarle
dove è possibile scrivere le regole?
- uno o più file qualsiasi che poi verranno richiamate dal comando iptables
- direttamente il comando iptables dentro a network/interfaces
- dentro a file nelle directory sotto a network/ dipendentemente dal momento in cui vogliamo attivarle

- oppure usare il pacchetto (debian) iptables-persistent

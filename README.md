## Script de récolte des stats d'impression des copieurs Kyocera (demande équipe bureautique)
### Prerequis

- ruby 1.9.3.484-2ubuntu1.5 (fonctionne sur 2.7.0p0) ;
- snmpwalk ;
- accès et autorisations réseau nécessaires au bind SNMP.

### Fonctionnement

> ruby walktoncopieur.rb

### Etat

Il envoie les statistiques d'impression sous forme de csv ; les compteurs (OIDs spécifiques) sont relevés via le protocole SNMP, un CSV est constitué, archivé, compressé et enfin envoyé aux personnes et équipes concernées (via mail et webhooks).

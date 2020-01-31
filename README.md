## Script de récolte des stats d'impression des copieurs Kyocera (demande équipe bureautique)
### Prerequis

- ruby
- client snmp
- accès et autorisations réseau nécessaires au bind snmp

### Fonctionnement

> ruby walktoncopieur.rb

### Etat

Actuellement en production sur la machine rac3. Il envoie les statistiques précises d'impression sous forme de csv, récoltées en snmp et à destination des personnes et équipes concernées : mail et webhooks.

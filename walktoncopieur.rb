#!/usr/bin/ruby -w
# copieurs.rb

# walk ton copieur	v1
# thomas.gratton@ac-amiens.fr

# todo : OID pour les compteurs des pages imprimees en couleur
# le pourcentage de remplissage du toner se calcule de la sorte :
# (toner1-numerateur/toner2-denominateur)x100

require 'csv'

array =[
'172.30.182.20',
'172.30.182.5',
'172.30.181.147',
'172.30.180.28',
'172.30.180.75',
'172.30.182.188',
'172.30.178.141',
'172.30.178.138',
'172.30.183.64',
'172.30.181.47',
#'172.30.177.88',
'172.30.178.93',
'172.30.179.199',
'172.30.179.200',
'172.30.183.233',
'172.30.180.161',
'172.30.182.190',
'172.30.182.179',
#'172.30.183.115',
'172.30.185.101',
'172.30.185.98',
'172.30.185.104',
#'172.30.185.103',
'172.30.189.95'
]

oid = [
  'iso.3.6.1.2.1.1.6.0',			# nom imprimante
  'iso.3.6.1.2.1.43.5.1.1.17.1',		# serial
  'iso.3.6.1.2.1.43.5.1.1.16.1',		# modele
  'iso.3.6.1.2.1.43.10.2.1.4.1.1',		# total de pages vrai compteur
						# OID A3 couleur
						# OID  A3 couleur niveau 2
						# OID  A3 couleur niveau 3
						# OID  A4 couleur
						# OID  A4 couleur niveau 2
						# OID  A4 couleur niveau 3
  'iso.3.6.1.4.1.1347.42.2.1.1.1.6.1.1',	# nb copies
# 'iso.3.6.1.2.1.43.10.2.1.5.1.1'		# session - correspond a quoi ?
  'iso.3.6.1.4.1.1347.42.2.1.1.1.6.1.3',	# totala4
  'iso.3.6.1.2.1.43.11.1.1.9.1.1',		# toner1-numerateur
  'iso.3.6.1.2.1.43.11.1.1.8.1.1'		# toner2-denominateur
]

CSV.open("stats-copieurs.csv", "wb") do |csv|
  csv << ["nom_imprimante", "num_serie", "modele", "total_pages", "nb_copies", "totala4", "toner1-numerateur", "toner2-denominateur"]
  array.each do |ipcopieur| 
    v = []
    oid.each do |chaqueoid|
      snmpwalk = `snmpwalk -c public -v2c #{ipcopieur} #{chaqueoid}`
      values = snmpwalk.partition(': ').last
      v << values.to_s.strip
    end 
    csv << v
  end
end

time = Time.new
date = time.strftime("%d-%m-%Y @ %H:%M:%S")

#command2 = `sed -i -e "s/\"\"\"//g" stats-copieurs.csv`
command = `cat stats-copieurs.csv | mail -s "Stats copieurs - #{date}" tg@ac-amiens.fr`

# """,""" par ","
#remplacer1 = `sed -i -e "s/\"\"\"/\"/g" stats-copieurs.csv`
#remplacer2 = `sed -i -e "s/,/\",\"/g" stats-copieurs.csv`

resultat = `cat /etc/collectd/scripts/stats-copieurs.csv`
puts date
puts resultat

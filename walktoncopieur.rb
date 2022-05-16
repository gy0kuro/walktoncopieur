#!/usr/bin/ruby -w
# copieurs.rb
#
# Copyright (c) 2020 - Thomas GRATTON <thomas.gratton@ac-amiens.fr>
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

require 'csv'
require 'json'

# ip des copieurs
array =[
'172.30.182.20',				#CAB-RECTEUR
'172.30.182.5',					#SG
'172.30.181.147',				#DAF-DPS
'172.30.180.28',				#DEC-Secretariat
'172.30.180.75',				#DEC
'172.30.182.188',				#Santé Scolaire 6ème
'172.30.178.141',				#1er etage DLSa
'172.30.178.138',				#DEPP
'172.30.183.64',				#DESR
'172.30.181.47',				#DAJ-DOS
'172.30.177.88',				#Secretariat DSIN
'172.30.178.93',				#DPAE
'172.30.179.199',				#DPE-4-5
'172.30.179.200',				#Dpe-2-3
'172.30.183.233',				#DAFPEN-14AL
'172.30.180.161',				#IPR 400
'172.30.182.190',				#DAET
'172.30.182.179',				#SAIO
'172.30.185.101',				#IEN 80 E cote dalle
'172.30.185.98',				#IEN 80 - F - Cote Rue
'172.30.185.104',				#DSDEN 80 - Staff
'172.30.189.95',				#DANE
'10.80.101.10',					#CIO Abbeville
'10.80.103.11',					#CIO AMIENS SUD
'10.80.104.10',					#Paio FRIVILLE-ESCARBOTIN
'10.60.104.10',					#CIO CLERMONT
'10.60.101.220',				#CIO COMPIEGNE
'10.60.102.10',					#CIO CREIL
'10.80.106.50',					#Paio Albert
'10.2.104.10',					#CIO ST QUENTIN
'10.2.101.10.',					#CIO Château-Thierry
'10.80.103.10',					#Cio Amiens Nord
'10.60.105.10',					#Cio Noyon
'10.80.81.10',					#Cio Soissons
'192.168.1.10',					#Cio Beauvais
'10.64.128.55',					#Cio Péronne
'10.2.103.10',					#Cio Laon
'10.64.128.55',					#Circonscription Péronne
'192.168.1.50',					#Circonscription Abbeville
'172.26.184.29',				#Sdjes 80
'172.26.184.114',				#Drajes 80
'172.26.184.122',				#Drajes 80-1
'172.26.184.123',				#Drajes 80-2
'172.26.184.124',				#Drajes 80-3
'172.30.178.50',				#DPAE-Secretariat
'172.30.185.20'					#DSDEN 80 - Lecul
]

array_eco =[
'172.30.179.181',				# Dpe1-prive
'172.30.179.182',				# Secretariat & Direction DPE
'10.80.104.12',					# Circonscription Abbeville
'192.168.1.50',					# Circonscription Doullens
'10.64.128.200'					# Circonscription Montdidier
]

# oids a recuperer
oid = [
  'iso.3.6.1.2.1.1.6.0',			# nom imprimante
  'iso.3.6.1.2.1.4.20.1.1',			# ip
  'iso.3.6.1.2.1.43.5.1.1.17.1',		# serial
  'iso.3.6.1.2.1.43.5.1.1.16.1',		# modele
  'iso.3.6.1.4.1.1347.43.10.1.1.12.1.1',	# total tout cumul
  'iso.3.6.1.4.1.1347.42.2.1.1.1.7.1.1',	# A3 noir et blanc
  'iso.3.6.1.4.1.1347.42.2.1.1.1.10.1.1',	# A3 couleur
  'iso.3.6.1.4.1.1347.42.2.1.1.1.7.1.3',	# A4 noir et blanc
  'iso.3.6.1.4.1.1347.42.2.1.1.1.10.1.3',	# A4 couleur
  'iso.3.6.1.4.1.1347.42.2.1.1.1.6.1.3',	# totala4
  'iso.3.6.1.4.1.1347.42.2.1.1.1.6.1.1'		# totala3
#  'iso.3.6.1.2.1.43.11.1.1.9.1.1',		# toner1-numerateur
#  'iso.3.6.1.2.1.43.11.1.1.8.1.1',		# toner2-denominateur
#  'iso.3.6.1.4.1.1347.42.3.1.1.1.1.1',		# A4 imprimees imprimante
#  'iso.3.6.1.4.1.1347.42.3.1.1.1.1.2',		# A4 imprimees copier
#  'iso.3.6.1.4.1.1347.42.3.1.1.1.1.4',		# A4 imprimees fax
#  'iso.3.6.1.4.1.1347.42.3.1.3.1.1.2',		# pages numerisees copier
#  'iso.3.6.1.4.1.1347.42.3.1.3.1.1.4'		# pages numerisees fax
]

oid_eco = [
  'iso.3.6.1.2.1.1.6.0',			# nom imprimante
  'iso.3.6.1.2.1.4.20.1.1',			# ip
  'iso.3.6.1.2.1.43.5.1.1.17.1',		# serial
  'iso.3.6.1.2.1.43.5.1.1.16.1',		# modele
  'iso.3.6.1.4.1.1347.43.10.1.1.12.1.1',	# total tout cumul
  'iso.3.6.1.4.1.1347.42.2.1.1.1.7.1.1',	# A3 noir et blanc
  'iso.3.6.1.4.1.1347.42.2.1.1.1.10.1.1',	# A3 couleur
  'iso.3.6.1.4.1.1347.42.2.1.1.1.7.1.3',	# A4 noir et blanc
  'iso.3.6.1.4.1.1347.42.2.1.1.1.10.1.3',	# A4 couleur
  'iso.3.6.1.4.1.1347.42.2.1.1.1.6.1.3',	# totala4
  'iso.3.6.1.4.1.1347.42.2.1.1.1.6.1.1'		# totala3
#  'iso.3.6.1.4.1.1347.42.2.1.1.1.7.1.1',	# A3 noir et blanc
#  'iso.3.6.1.4.1.1347.42.2.1.1.1.10.1.1',	# A3 couleur niveau 1
#  'iso.3.6.1.4.1.1347.42.2.1.1.1.11.1.1',	# A3 couleur niveau 2
#  'iso.3.6.1.4.1.1347.42.2.1.1.1.12.1.1',	# A3 couleur niveau 3
#  'iso.3.6.1.4.1.1347.42.2.1.1.1.10.1.3',	# A4 couleur niveau 1
#  'iso.3.6.1.4.1.1347.42.2.1.1.1.11.1.3',	# A4 couleur niveau 2
#  'iso.3.6.1.4.1.1347.42.2.1.1.1.6.1.3',	# totala4
#  'iso.3.6.1.4.1.1347.42.2.1.1.1.6.1.1',	# totala3
#  'iso.3.6.1.2.1.43.11.1.1.9.1.1',		# toner1-numerateur
#  'iso.3.6.1.2.1.43.9.2.1.17.1.1',
#  'iso.3.6.1.2.1.43.11.1.1.8.1.1',		# toner2-denominateur
#  'iso.3.6.1.4.1.1347.42.3.1.1.1.1.1',		# A4 imprimees imprimante
#  'iso.3.6.1.4.1.1347.42.3.1.1.1.1.2',		# A4 imprimees copier
#  'iso.3.6.1.4.1.1347.42.3.1.1.1.1.4',		# A4 imprimees fax
#  'iso.3.6.1.4.1.1347.42.3.1.3.1.1.2',		# pages numerisees copier
#  'iso.3.6.1.4.1.1347.42.3.1.3.1.1.4'		# pages numerisees fax
]

def notify_slack(webhook_url, channel, username, text, image)
  payload = {
    :channel  => channel,
    :username => username,
    :text     => text,
    :icon_url => image
  }.to_json
  cmd = "curl -X POST --data-urlencode 'payload=#{payload}' #{webhook_url}"
  system(cmd)
end

CSV.open("stats-copieurs.csv", "wb", {:col_sep => ";"}) do |csv|
  csv << ["nom_imprimante", "adresse_ip", "num_serie", "modele", "total_cumul", "a3_nb", "a3_couleur", "a4_nb", "a4_couleur", "totala4", "totala3"]
  csv << []
  array.each do |ipcopieur| 
    v = []
    oid.each do |chaqueoid|
      snmpwalk = `snmpwalk -c public -v2c #{ipcopieur} #{chaqueoid}`
      values = snmpwalk.partition(': ').last
      v << values.to_s.strip
    end 
    csv << v
  end
  array_eco.each do |ipcopieur| 
    v = []
    oid_eco.each do |chaqueoid|
      snmpwalk = `snmpwalk -c public -v2c #{ipcopieur} #{chaqueoid}`
      values = snmpwalk.partition(': ').last
      v << values.to_s.strip
    end 
    csv << v
  end
end

time = Time.new
date = time.strftime("%d-%m-%Y @ %H:%M:%S")
command = `sed -i -e 's/\"\"\"//g' stats-copieurs.csv`
command1 = `zip stats-copieurs.zip stats-copieurs.csv`
command2 = `uuencode stats-copieurs.zip stats-copieurs.zip | mail -s "Stats copieurs - #{date}" tg@ac-amiens.fr`

notify_slack(
  'https://ratatouille.in.ac-amiens.fr:8065/hooks/dc8d79ju4pdz7jk3sraxjtpj4h',
  'rapport-conso-kyocera',
  'kyocera',
  'Rapport de consommation des copieurs généré et envoyé à TG.',
  'https://ratatouille.in.ac-amiens.fr:8065/static/stats1.png',
)

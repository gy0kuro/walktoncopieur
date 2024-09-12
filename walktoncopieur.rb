#!/usr/bin/ruby -w
# copieurs.rb
#
# Créé par - Thomas GRATTON <gratton.thomas@gmail.com>
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
'IP_1',				#DESCRIPTION1
'IP_2'				#DESCRIPTION2

]

# ip des copieurs eco

array_eco =[
'IP_1',				#DESCRIPTION1
'IP_2'				#DESCRIPTION2
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
command2 = `uuencode stats-copieurs.zip stats-copieurs.zip | mail -s "Stats copieurs - #{date}" yourname@yourcompany.com -a stats-copieurs.zip`

notify_slack(
  'https://youradress.com/hooks/youralfanumeric',
  'rapport-conso-kyocera',
  'kyocera',
  'Rapport de consommation des copieurs généré et envoyé à YOURNAME.',
  'https://youradress.com/hooks/youralfanumeric/static/stats1.png',
)

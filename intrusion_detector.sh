#!/bin/bash

port=$1
update_frequency=5s
file=.tmp_file.txt
nmap_file=nmap_log.txt
touch $file $nmap_file
chown $(whoami) $file $nmap_file


#Gets current network interface
network_interface=$(ip addr | awk '/state UP/ {print $2}' | sed 's/.$//')

#Check for logins on network interface and port 22
while [ 0 == 0 ]
do
	timeout ${update_frequency} tcpdump -i $network_interface tcp port $port >> $file
	
	#Cheks if file contains empty lines
	if [ -z "$(grep . "$file")" ]
	then
		>$file
	else
		#Gets IP from attacker
		attack_ip=$(cat $file | grep -o '[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*' | awk '!seen[$0]++')
		>$file
		#Runs nmap on IP from attacker
		nmap -A -oN $nmap_file $attack_ip
		#Creates a pdf from the nmap output
		cupsfilter $nmap_file > Intrusion_Report__$(date +"%d-%m-%y")__IP_${attack_ip}__ID$(shuf -i 100000-999999 -n 1).pdf
		rm -rf $nmap_file
	fi
	
done

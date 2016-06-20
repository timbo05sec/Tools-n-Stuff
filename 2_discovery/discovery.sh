#!/bin/bash

export DATE=$(date +%Y%m%d)
sudo masscan -iL ./targets.txt -p T:0-65535 --rate 500 --banners -oB $DATE\_masscan_targets.bin --interface eth0
masscan --readscan $DATE\_masscan_targets.bin -oG $DATE\_masscan_results.grep.txt

export PORTS=$(grep -Eo '[0-9]{1,5}\/open' $DATE\_masscan_results.grep.txt | sort -u | sed -r -e ':a;N;$!ba;s/\/open(\n)?/,/g' -e 's/,$//g')

grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' $DATE\_masscan_results.grep.txt | sort -u > $DATE\_masscan_tcp_results-targets.txt

sudo nmap -sS -Pn -n -p $PORTS --open --reason --script safe -A -oA $DATE\_nmap_tcp_masscan-targets -iL $DATE\_masscan_tcp_results-targets.txt

sudo nmap -sU -Pn -n --top-ports 50 --open --reason --script safe -A -iL targets.txt -oA $DATE\_nmap_udp-top50-targets


#!/bin/bash

for m in $(cat $1 | sort -R)
   do
      # Document when the command is run
      date

      # Document the target
      echo "Testing "$m"..."

      # Get a new exit node
      printf "AUTHENTICATE \"-SOm3_Pass+00[]-\"\r\nSIGNAL NEWNYM\r\n" | nc -w 3 127.0.0.1 9051 > /dev/null

      # Document the tor exit node
      echo -n "SourceAddr: "
      torsocks curl -L -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Firefox/31.0 Iceweasel/31.4.0" http://www.utrace.de | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -n 1

      # Run the command(s) through the tor exit node
      torsocks nmap -sT -n -Pn --max-retries 1 --max-rtt-timeout 500ms --initial-rtt-timeout 500ms -p $(echo -n $m | awk -F ':' ' { print $2 } ') $(echo -n $m | awk -F ':' ' { print $1 } ') -oA $(date +%Y%m%d)_tornmap_$m
   done

#!/bin/bash

for m in $(cat subnet_targets.txt); do (

     whois $m | tee $(date +%Y%m%d)_whois\_$m.txt

); done;

for m in $(cat targets.txt); do (

     host $m | tee -a $(date +%Y%m%d)_host_targets.txt

     echo "Searching Bing for: " $m | tee -a $(date +%Y%m%d)_bing_targets.txt
     BING_RESP=$(curl -s "http://www.bing.com/search?q=ip:$m" | grep -Eio '[0-9]{1,3} results')
     if [ -n "$BING_RESP" ] 
          then
               echo $BING_RESP | tee -a $(date +%Y%m%d)_bing_targets.txt
               ~/downloads/rawr/rawr.py http://www.bing.com/search?q=ip:$m
     fi

); done;


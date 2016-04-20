#!/bin/bash

for m in $(cat targets.txt); do (

     whois $m | tee $(date +%Y%m%d)_whois\_$m.txt

     host $m | tee -a $(date +%Y%m%d)_host_targets.txt

     (echo "Searching Bing for: " $m; curl -s "http://www.bing.com/search?q=ip:$m" | grep -Eio '[0-9]{1,3} results') | tee -a $(date +%Y%m%d)_bing_targets.txt
); done;


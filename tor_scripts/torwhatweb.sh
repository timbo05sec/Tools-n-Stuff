#!/bin/bash

for m in $(cat $1 | sort -R) 
   do 
      # Document when the command is run
      date

      # Document the target
      echo "Testing "$(echo -n $m | awk -F ':' ' { print $1 } ')"..."

      # Get a new exit node
      printf "AUTHENTICATE \"-SOm3_Pass+00[]-\"\r\nSIGNAL NEWNYM\r\n" | nc -w 3 127.0.0.1 9051 > /dev/null

      # Document the tor exit node
      echo -n "SourceAddr: "
      torsocks curl -L -s -A "Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Firefox/31.0 Iceweasel/31.4.0" http://www.utrace.de | grep -E -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -n 1

      # Run the command(s) through the tor exit node

      # Two below are for simple ip address lists
      torsocks whatweb -a 1 --log-brief="./$(date +%Y%m%d)_whatweb_brief-log_$m.txt" --log-verbose="./$(date +%Y%m%d)_whatweb_verbose-log_$m.txt" --log-errors="./$(date +%Y%m%d)_whatweb_errors_$m.txt" --user-agent="Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; AS; rv:11.0) like Gecko" --follow-redirect=always --verbose --open-timeout=5 http://$m

       torsocks whatweb -a 1 --log-brief="./$(date +%Y%m%d)_whatweb_brief-log_$m-443.txt" --log-verbose="./$(date +%Y%m%d)_whatweb_verbose-log_$m-443.txt" --log-errors="./$(date +%Y%m%d)_whatweb_errors_$m-443.txt" --user-agent="Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; AS; rv:11.0) like Gecko" --follow-redirect=always --verbose --open-timeout=5 https://$m

      # Two below are for lists that use hostnames (input file must have hostname:ip)
      #torsocks whatweb -a 1 --log-brief="./$(date +%Y%m%d)_whatweb_brief-log_$(echo -n $m | awk -F ':' ' { print $1 } ').txt" --log-verbose="./$(date +%Y%m%d)_whatweb_verbose-log_$(echo -n $m | awk -F ':' ' { print $1 } ').txt" --log-errors="./$(date +%Y%m%d)_whatweb_errors_$(echo -n $m | awk -F ':' ' { print $1 } ').txt" --user-agent="Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; AS; rv:11.0) like Gecko" --follow-redirect=always --verbose --open-timeout=5 -H "Host: "$(echo -n $m | awk -F ':' ' { print $1 } ') http://$(echo -n $m | awk -F ':' ' { print $2 } ')

      #torsocks whatweb -a 1 --log-brief="./$(date +%Y%m%d)_whatweb_brief-log_$(echo -n $m | awk -F ':' ' { print $1 } ')-443.txt" --log-verbose="./$(date +%Y%m%d)_whatweb_verbose-log_$(echo -n $m | awk -F ':' ' { print $1 } ')-443.txt" --log-errors="./$(date +%Y%m%d)_whatweb_errors_$(echo -n $m | awk -F ':' ' { print $1 } ')-443.txt" --user-agent="Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; AS; rv:11.0) like Gecko" --follow-redirect=always --verbose --open-timeout=5 -H "Host: "$(echo -n $m | awk -F ':' ' { print $1 } ') https://$(echo -n $m | awk -F ':' ' { print $2 } ')
   done


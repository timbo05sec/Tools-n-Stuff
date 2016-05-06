#!/bin/bash

for m in 4433 80
   do
      for n in $(grep $m'\/open' $1 | cut -d ' ' -f 2)
         do
            nikto -host $n:$m -ask no -nointeractive -useragent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:35.0) Gecko/20100101 Firefox/35.0" -Format htm $([[ $m = 443 || $m = 8080 || $m = 4343 ]] && echo "-ssl ") -output ./$(date +%Y%m%d)_nikto_$n\_$m.html
            [[ $m = 4433 || $m = 8080 || $m = 4343 ]] && sed -Ei 's/(set target http)s{0,1}(:\/\/.*)/\1s:\/\/'$n':'$m'\//g' ~/Tools-n-Stuff/2_discovery/w3af/w3af_script.w3af
            [[ $m = 4433 || $m = 8080 || $m = 4343 ]] && sed -Ei 's/(set output_file \.\/.*w3af)(.*_)(Report.html)/set output_file \.\/'$(date +%Y%m%d)'_w3af_'$n'_'$m'_ssl_\3/g' ~/Tools-n-Stuff/2_discovery/w3af/w3af_script.w3af
            [[ $m = 80 || $m = 8009 ]] && sed -Ei 's/(set target http)s{0,1}(:\/\/.*)/\1:\/\/'$n':'$m'\//g' ~/Tools-n-Stuff/2_discovery/w3af/w3af_script.w3af
            [[ $m = 80 || $m = 8009 ]] && sed -Ei 's/(set output_file \.\/.*w3af)(.*_)(Report.html)/set output_file \.\/'$(date +%Y%m%d)'_w3af_'$n'_'$m'_\3/g' ~/Tools-n-Stuff/2_discovery/w3af/w3af_script.w3af          
            w3af -s ~/Tools-n-Stuff/2_discovery/w3af/w3af_script.w3af
            [[ $m = 4433 || $m = 8080 || $m = 4343 ]] && java -jar ~/Tools-n-Stuff/4_exploitation/TestSSLServer.jar $n $m >> $(date +%Y%m%d)_TestSSLServer_$n\_$m.txt
            [[ $m = 4433 || $m = 8080 || $m = 4343 ]] && sslscan --no-failed $n > $(date +%Y%m%d)_sslscan_$n\_$m.txt
            [[ $m = 4433 || $m = 8080 || $m = 4343 ]] && echo 'Q' | openssl s_client -connect $n:$m | openssl x509 -noout -text &> $(date +%Y%m%d)_openssl_x509_cert_$n\_$m.txt
            [[ $m = 4433 || $m = 8080 || $m = 4343 ]] && echo 'Q' | openssl s_client -connect $n:$m &> $(date +%Y%m%d)_openssl_cert_$n\_$m.txt
            [[ $m = 4433 || $m = 8080 || $m = 4343 ]] && echo 'Q' | openssl s_client -connect $n:$m -state -fallback_scsv -ssl3 &> $(date +%Y%m%d)_openssl_scsvfallback_$n\_$m.txt
      done
done

sed -Ei 's/(set target http)s{0,1}(:\/\/.*)/\1:\/\/10.10.10.10:80\//g' ~/Tools-n-Stuff/2_discovery/w3af/w3af_script.w3af

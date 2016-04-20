#!/bin/bash

for m in 443 80
   do
      for n in $(grep $m'\/open' $1 | cut -d ' ' -f 2)
         do
            nikto -host $n -ask no -nointeractive -useragent "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:35.0) Gecko/20100101 Firefox/35.0" -Format htm $([ $m = 443 ] && echo "-ssl ") -output ./$(date +%Y%m%d)_nikto_$n\_$m.html
            [ $m = 443 ] && sed -Ei 's/(set target http)s{0,1}(:\/\/.*)/\1s:\/\/'$n'\//g' ~/tools/discovery/w3af/w3af_script.w3af
            [ $m = 443 ] && sed -Ei 's/(set output_file \.\/.*w3af)(.*_)(Report.html)/set output_file \.\/'$(date +%Y%m%d)'_w3af_'$n'_ssl_\3/g' ~/tools/discovery/w3af/w3af_script.w3af
            [ $m = 80 ] && sed -Ei 's/(set target http)s{0,1}(:\/\/.*)/\1:\/\/'$n'\//g' ~/tools/discovery/w3af/w3af_script.w3af
            [ $m = 80 ] && sed -Ei 's/(set output_file \.\/.*w3af)(.*_)(Report.html)/set output_file \.\/'$(date +%Y%m%d)'_w3af_'$n'_\3/g' ~/tools/discovery/w3af/w3af_script.w3af          
            w3af -s ~/tools/discovery/w3af/w3af_script.w3af
            [ $m = 443 ] && java -jar ~/tools/TestSSLServer.jar $n 443 >> $(date +%Y%m%d)_TestSSLServer_$n.txt
            [ $m = 443 ] && sslscan --no-failed $n >> $(date +%Y%m%d)_sslscan_$n.txt
            [ $m = 443 ] && echo 'Q' | openssl s_client -connect $n:443 | openssl x509 -noout -text &> $(date +%Y%m%d)_openssl_x509_cert_$n.txt
            [ $m = 443 ] && echo 'Q' | openssl s_client -connect $n:443 &> $(date +%Y%m%d)_openssl_cert_$n.txt
            [ $m = 443 ] && echo 'Q' | openssl s_client -connect $n:443 -state -fallback_scsv -ssl3 &> $(date +%Y%m%d)_openssl_scsvfallback_$n.txt
      done  
done 

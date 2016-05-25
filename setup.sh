#!/bin/bash

apt-get install whois
pip install pyip
git clone https://github.com/SpiderLabs/ikeforce.git /home/admin/downloads/ikeforce
git clone https://bitbucket.org/LaNMaSteR53/recon-ng.git /home/admin/downloads/recon-ng
git clone https://bitbucket.org/al14s/rawr.git /home/admin/downloads/rawr

chown -R admin:admin /home/admin/downloads

~/downloads/rawr/install.sh

cp /home/admin/Tools-n-Stuff/1_recon/googlepie/grecce.py /home/admin/downloads/recon-ng/modules/recon/domains-vulnerabilities/
cp /home/admin/Tools-n-Stuff/1_recon/googlepie/sites.txt /home/admin/downloads/recon-ng/data/grecce_sites.txt
cp /home/admin/Tools-n-Stuff/1_recon/googlepie/extentions.txt /home/admin/downloads/recon-ng/data/grecce_extentions.txt
cp /home/admin/Tools-n-Stuff/1_recon/googlepie/bishopfox-google-queries.txt /home/admin/downloads/recon-ng/data/grecce_bishopfox.txt

echo 'set DEBUG False
set VERBOSE True
set USER-AGENT Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:42.0) Gecko/20100101 Firefox/42.0
use recon/domains-vulnerabilities/grecce
set SITES data/grecce_sites.txt
set EXTENTIONS data/grecce_extentions.txt
set BISHOPFOX data/grecce_bishopfox.txt' > /tmp/grecce.rc

service postgresql start
msfdb init

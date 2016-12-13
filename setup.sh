#!/bin/bash

apt-get install whois
apt-get install telnet
pip install pyip
git clone https://github.com/SpiderLabs/ikeforce.git /home/admin/downloads/ikeforce
git clone https://bitbucket.org/LaNMaSteR53/recon-ng.git /home/admin/downloads/recon-ng
git clone https://bitbucket.org/al14s/rawr.git /home/admin/downloads/rawr

chown -R admin:admin /home/admin/downloads

/home/admin/downloads/rawr/install.sh

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

echo '# Added ":\D{%F-%T}~" to the end of the prompt
# Eg. root@kali:~:2015-06-21-07:55:37~#
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]:\D{%F-%T}~\$'
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w:\D{%F-%T}~\$'
fi' >> ~/.bashrc

echo '# Logs all terminal output
# Eg. ~/.terminal-logs/2015-06-02_08:15:25.14622.log
if [ -z "$UNDER_SCRIPT" ]; then
        logdir=$HOME/.terminal-logs
        if [ ! -d $logdir ]; then
                mkdir $logdir
        fi
        #gzip -q $logdir/*.log
        logfile=$logdir/$(date +%F_%T).$$.log
        export UNDER_SCRIPT=$logfile
        script -f -q $logfile
        exit
fi' >> ~/.bash_profile

service postgresql start
msfdb init

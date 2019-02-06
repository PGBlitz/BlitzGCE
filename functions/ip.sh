#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################
source /opt/pggce/functions/main.sh

nvmecount () {

pnum=0
mkdir -p /var/plexguide/prolist
rm -r /var/plexguide/prolist/*

echo "" > /var/plexguide/prolist/final.sh
gcloud compute regions list | awk '{print $1}' | tail -n +2 > /tmp/1.txt
awk '{print substr($0, 1, length($0)-1)}' /tmp/1.txt > /tmp/2.txt
sort -u /tmp/2.txt > /tmp/1.txt
cat /tmp/1.txt

gcloud projects list | cut -d' ' -f1 | tail -n +2 > /var/plexguide/prolist/prolist.sh

### prevent bonehead from deleting the project that is active!
variablepull
sed -i -e "/${projectid}/d" /var/plexguide/prolist/prolist.sh

### project no exist check
pcheck=$(cat /var/plexguide/prolist/prolist.sh)
if [[ "$pcheck" == "" ]]; then noprojects; fi

while read p; do
  let "pnum++"
  echo "$p" > "/var/plexguide/prolist/$pnum"
  echo "[$pnum] $p" >> /var/plexguide/prolist/final.sh
done </var/plexguide/prolist/prolist.sh
prolist=$(cat /var/plexguide/prolist/final.sh)

pnum=9
typed2=999999999
while [[ "$typed2" -lt "1" || "$typed2" -gt "$pnum" ]]; do
  existlist
  read -p 'Type Number | Press [ENTER]: ' typed2 < /dev/tty
  if [[ "$typed2" == "exit" || "$typed2" == "Exit" || "$typed2" == "EXIT" ]]; then projectinterface; fi
done

typed=$(cat /var/plexguide/prolist/$typed2)
gcloud projects delete "$typed"

}

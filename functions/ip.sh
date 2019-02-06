#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################
source /opt/pggce/functions/main.sh

regioncenter () {

pnum=0
mkdir -p /var/plexguide/prolist
rm -r /var/plexguide/prolist/*

echo "" > /var/plexguide/prolist/final.sh
gcloud compute regions list | awk '{print $1}' | tail -n +2 > /var/plexguide/prolist/1.output
awk '{print substr($0, 1, length($0)-1)}' /var/plexguide/prolist/1.output > /var/plexguide/prolist/2.output
sort -u /var/plexguide/prolist/2.output > /var/plexguide/prolist/1.output

while read p; do
  let "pnum++"
  echo "$p" > "/var/plexguide/prolist/$pnum"
  echo "[$pnum] $p" >> /var/plexguide/prolist/final.sh
done </var/plexguide/prolist/1.output

pnum=9
typed2=999999999
profinal=$(cat /var/plexguide/prolist/final.sh)
while [[ "$typed2" -lt "1" || "$typed2" -gt "$pnum" ]]; do

  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Select a GCE Region
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
$profinal

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  read -p 'Type Number | Press [ENTER]: ' typed2 < /dev/tty
  if [[ "$typed2" == "exit" || "$typed2" == "Exit" || "$typed2" == "EXIT" ]]; then projectinterface; fi
done

typed=$(cat /var/plexguide/prolist/$typed2)
echo##########

}

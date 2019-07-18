#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/blitzgce/functions/main.sh

regioncenter() {

  pnum=0
  mkdir -p /var/plexguide/prolist
  rm -r /var/plexguide/prolist/*

  echo "" >/var/plexguide/prolist/final.sh
  gcloud compute regions list | awk '{print $1}' | tail -n +2 >/var/plexguide/prolist/1.output
  awk '{print substr($0, 1, length($0)-1)}' /var/plexguide/prolist/1.output >/var/plexguide/prolist/2.output
  sort -u /var/plexguide/prolist/2.output >/var/plexguide/prolist/1.output

  while read p; do
    let "pnum++"
    echo "$p" >"/var/plexguide/prolist/$pnum"
    echo "[$pnum] $p" >>/var/plexguide/prolist/final.sh
  done </var/plexguide/prolist/1.output

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

    read -p 'Type Number | Press [ENTER]: ' typed2 </dev/tty
    if [[ "$typed2" == "exit" || "$typed2" == "q" || "$typed2" == "Q" || "$typed2" == "exit" || "$typed2" == "q" || "$typed2" == "Q" || "$typed2" == "exit" || "$typed2" == "q" || "$typed2" == "Q" ]]; then projectinterface; fi
  done

  typed=$(cat /var/plexguide/prolist/$typed2)
  echo $typed >/var/plexguide/project.ipregion

  gcloud compute zones list | grep $typed | head -n1 | awk '{print $2}' >/var/plexguide/project.ipregion

  echo
  variablepull
  gcloud compute addresses create pg-gce --region $ipregion --project $projectid
  gcloud compute zones list | grep $typed | head -n1 | awk '{print $1}' >/var/plexguide/project.ipzone
  gcloud compute addresses list | grep pg-gce | awk '{print $2}' >/var/plexguide/project.ipaddress

  echo
  read -p '↘️  IP Address & Region Set | Press [ENTER] ' typed </dev/tty

}

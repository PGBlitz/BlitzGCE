#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /pg/blitzgce/functions/main.sh

regioncenter() {

  pnum=0
  mkdir -p /pg/var/prolist
  rm -r /pg/var/prolist/*

  echo "" >/pg/var/prolist/final.sh
  gcloud compute regions list | awk '{print $1}' | tail -n +2 >/pg/var/prolist/1.output
  awk '{print substr($0, 1, length($0)-1)}' /pg/var/prolist/1.output >/pg/var/prolist/2.output
  sort -u /pg/var/prolist/2.output >/pg/var/prolist/1.output

  while read p; do
    let "pnum++"
    echo "$p" >"/pg/var/prolist/$pnum"
    echo "[$pnum] $p" >>/pg/var/prolist/final.sh
  done </pg/var/prolist/1.output

  typed2=999999999
  profinal=$(cat /pg/var/prolist/final.sh)
  while [[ "$typed2" -lt "1" || "$typed2" -gt "$pnum" ]]; do

    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 Select a GCE Region
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
$profinal

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

    read -p 'Type Number | Press [ENTER]: ' typed2 </dev/tty
    if [[ "$typed2" == "exit" || "$typed2" == "Exit" || "$typed2" == "EXIT" || "$typed2" == "z" || "$typed2" == "Z" ]]; then projectinterface; fi
  done

  typed=$(cat /pg/var/prolist/$typed2)
  echo $typed >/pg/var/project.ipregion

  gcloud compute zones list | grep $typed | head -n1 | awk '{print $2}' >/pg/var/project.ipregion

  echo
  variablepull
  gcloud compute addresses create pg-gce --region $ipregion --project $projectid
  gcloud compute zones list | grep $typed | head -n1 | awk '{print $1}' >/pg/var/project.ipzone
  gcloud compute addresses list | grep pg-gce | awk '{print $2}' >/pg/var/project.ipaddress

  echo
  read -p '↘️  IP Address & Region Set | Press [ENTER] ' typed </dev/tty

}

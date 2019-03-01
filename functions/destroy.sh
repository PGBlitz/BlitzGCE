#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/blitzgce/functions/main.sh

destroyserver () {

  ### checking to making sure there is a server deployed to destroy
  destorycheck=$(gcloud compute instances list | grep pg-gce | head -n +1 | awk '{print $1}')
  if [[ "$destorycheck" == "" ]]; then

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 SYSTEM MESSAGE: No PG-GCE Server Deployed! Exiting!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
  gcestart
  fi

  ### starting process
  echo
  variablepull
  zone=$(gcloud compute instances list | tail -n 1 | awk '{print $2}')
  #ipdelete=$(gcloud compute addresses list | grep pg-gce | head -n +1 | awk '{print $2}')

tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 SYSTEM MESSAGE: Destroying Server - Can Take Awhile!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

  gcloud compute instances delete pg-gce --zone $ipzone --quiet

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 SYSTEM MESSAGE: Releasing IP Address
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  rm -rf /var/plexguide/project.zone
  rm -rf /var/plexguide/project.ipregion
  rm -rf /var/plexguide/project.ipaddress
  gcloud compute addresses delete pg-gce --region $ipregion --quiet
  rm -rf /root/.ssh/google_compute_engine 1>/dev/null 2>&1

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 SYSTEM MESSAGE: Process Complete!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

  read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
}

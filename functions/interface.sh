#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################
source /opt/pggce/functions/main.sh

destroyserver () {
  ### what is location?
  gcloud compute instances delete pg-gce --quiet --zone "$location"
  rm -rf /root/.ssh/google_compute_engine 1>/dev/null 2>&1

tee <<-EOF

🌎  NOTE: Server Destroyed
EOF
read -p 'Acknowledge | Press [ENTER]: ' typed < /dev/tty

}

nvmecount () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  NVME Count                          ⚡ Reference: pggce.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Most users will only need to utilize 1 -2 NVME Drives. The more, the
faster the processing, but the faster your credits drain. If intent is to
be in beast mode during the GCE's duration, 3 - 4 is acceptable.

INSTRUCTIONS: Set the NVME Count ~ 1/2/3/4
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p 'Type Number | Press [ENTER]: ' typed < /dev/tty

if [[ "$typed" == "1" || "$typed" == "2" || "$typed" == "3" || "$typed" == "4" ]]; then
  echo "$typed" > /var/plexguide/project.nvme; else nvmecount; fi
}

processorcount () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  Processor Count                     ⚡ Reference: pggce.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Information: The processor count utilizes can affect how fast your credits
drain. If usage is light, select 2. If for average use, 2 or 6 is fine.
Only utilize 8 if the GCE will be used heavily!

INSTRUCTIONS: Set the Processor Count ~ 2/4/6/8
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p 'Type Number | Press [ENTER]: ' typed < /dev/tty

if [[ "$typed" == "2" || "$typed" == "4" || "$typed" == "6" || "$typed" == "8" ]]; then
  echo "$typed" > /var/plexguide/project.processor; else processorcount; fi
}

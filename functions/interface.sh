#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################
source /opt/pggce/functions/main.sh

processorcount () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  PG GCE Deployment                   ⚡ Reference: pggce.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Information: The processor count utilizes can affect how fast your credits
drain. If usage is light, select 2. If for average use, 2 or 6 is fine.
Only utilize 8 if the GCE will be used heavily!

Instructions: Set the Processor Count (2 - 4 - 6 or 8)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
read -p 'Type Number | Press [ENTER]: ' typed < /dev/tty

if [[ "$typed" == "2" || "$typed" == "4" || "$typed" == "6" || "$typed" == "8" ]]; then
  echo "$typed" > /var/plexguide/project.processor; else processorcount; fi

}

#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################
source /opt/pggce/functions/main.sh

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

#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################
source /opt/pggce/functions/main.sh

### the primary interface for GCE
gcestart () {

  ### call key variables ~ /functions/main.sh
  variablepull

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  PG GCE Deployment                   ⚡ Reference: pggce.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. Log Into the Account  : $account
2. Project Interface     : $projectid
3. Set Processor Count   : $processor
4. NVME Drive Count      : $nvmecount
5. Set IP Region / Server: $ipaddress - $ipregion
6. Deploy GCE Server     : $serverstatus
7. SSH into the GCE Box  : $sshstatus

a. Destroy Server
z. EXIT

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p 'Type a Number | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
        gcestart ;;
    2 )
        gcestart ;;
    3 )
        gcestart ;;
    4 )
        gcestart ;;
    5 )
        gcestart ;;
    6 )
        gcestart ;;
    7 )
        gcestart ;;
    A )
        gcestart ;;
    b )
        gcestart ;;
    z )
        exit ;;
    Z )
        exit ;;
    * )
        question1 ;;
esac
}

gcestart

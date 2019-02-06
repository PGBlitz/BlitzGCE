#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################
source /opt/pggce/functions/main.sh
source /opt/pggce/functions/interface.sh
source /opt/pggce/functions/ip.sh

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
3. Processor Count       : $processor
4. NVME Drive Count      : 1 (NOT CODED YET)
5. Set IP Region / Server: $ipaddress [$ipregion]
6. Deploy GCE Server     : $serverstatus
7. SSH into the GCE Box  : $sshstatus

a. Destroy Server
z. EXIT

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p 'Type Number | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
        echo ""
        gcloud auth login --no-launch-browser --verbosity error
        ### note --no-user-output-enabled | gcloud auth login --enable-gdrive-access --brief
        # gcloud config configurations list
        gcestart ;;
    2 )
        projectinterface
        gcestart ;;
    3 )
        processorcount
        gcestart ;;
    4 )
        # nvmecount
        gcestart ;;
    5 )
        regioncenter
        gcestart ;;
    6 )
        gcestart ;;
    7 )
        gcestart ;;
    A )
        destroyserver
        gcestart ;;
    a )
        destroyserver
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

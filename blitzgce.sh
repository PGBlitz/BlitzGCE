#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705 - Deiteq
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/blitzgce/functions/main.sh
source /opt/blitzgce/functions/interface.sh
source /opt/blitzgce/functions/ip.sh
source /opt/blitzgce/functions/deploy.sh
source /opt/blitzgce/functions/destroy.sh

### the primary interface for GCE
gcestart () {

  ### call key variables ~ /functions/main.sh
  variablepull

  ### For New Installs; hangs because of no account logged in yet; this prevents
  othercheck=$(cat /var/plexguide/project.account)
  secondcheck=$(cat /var/plexguide/project.id )
  if [[ "$othercheck" != "NOT-SET" ]]; then

    if [[ "$secondcheck" != "NOT-SET" ]]; then servercheck
    else
    projectid=NOT-SET
    gcedeployedcheck=NOT-SET; fi
else
  account=NOT-SET
  projectid=NOT-SET
  gcedeployedcheck=NOT-SET; fi

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  PG GCE Deployment ~ http://pggce.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

1. Log Into the Account  : $account
2. Project Interface     : $projectid
3. Processor Count       : $processor
4. Set IP Region / Server: $ipaddress [$ipregion]
5. Deploy GCE Server     : $gcedeployedcheck
6. SSH into the GCE Box

a. Destroy Server
z. EXIT

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p 'Type Number | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )
        echo ""
        gcloud auth login --no-launch-browser --verbosity error --quiet
        echo "NOT-SET" > /var/plexguide/project.id
        echo "on" > /var/plexguide/project.switch
        ### note --no-user-output-enabled | gcloud auth login --enable-gdrive-access --brief
        # gcloud config configurations list
        gcestart ;;
    2 )
        projectinterface
        gcestart ;;
    3 )
        projectdeny
        processorcount
        gcestart ;;
    4 )
        projectdeny
        regioncenter
        gcestart ;;
    5 )
        projectdeny
        deployserver
        gcestart ;;
    6 )
        projectdeny
        if [[ "$gcedeployedcheck" == "DEPLOYED" ]]; then
          sshdeploy
        else
          gcestart
        fi ;;
    A )
        projectdeny
        destroyserver
        gcestart ;;
    a )
        projectdeny
        destroyserver
        gcestart ;;
    z )
        exit ;;
    Z )
        exit ;;
    * )
        gcestart ;;
esac
}

gcestart

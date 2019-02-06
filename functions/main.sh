#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################

### assists in creating default variables if they do not exist
variable () {
  file="$1"
  if [ ! -e "$file" ]; then echo "$2" > $1; fi
}

### key variable pull
variablepull () {

  ### sets variables if they do not exist
  variable /var/plexguide/project.account NOT-SET
  variable /var/plexguide/project.ipaddress NOT-SET
  variable /var/plexguide/project.ipregion NOT-SET
  variable /var/plexguide/project.ipzone NOT-SET
  variable /var/plexguide/project.processor NOT-SET
  variable /var/plexguide/project.nvme NOT-SET

  ### variables being called

  #account=$(cat /var/plexguide/project.account)
  account=$(gcloud config configurations list | tail -n 1 | awk '{print $3}')

  ipaddress=$(cat /var/plexguide/project.ipaddress)
  ipregion=$(cat /var/plexguide/project.ipregion)
  ipzone=$(cat /var/plexguide/project.ipzone)
  nvmecount=$(cat /var/plexguide/project.nvme)
  processor=$(cat /var/plexguide/project.processor)

  #projectid=projectid
  projectid=$(gcloud config configurations list | tail -n 1 | awk '{print $4}')

  serverstatus=serverstatus
  sshstatus=notready
}

servercheck () {
  temp55=$(gcloud compute instances list | grep pg-gce)
  if [[ "$temp55" != "" ]]; then gcedeployedcheck="DEPLOYED";
else gcedeployedcheck="NOT DEPLOYED"; fi
}

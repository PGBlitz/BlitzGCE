#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################

### assists in creating default variables if they do not exist
variable() {
  file="$1"
  if [ ! -e "$file" ]; then echo "$2" >$1; fi
}

### key variable pull
variablepull() {

  ### sets variables if they do not exist
  variable /var/plexguide/project.account NOT-SET
  variable /var/plexguide/project.ipaddress NOT-SET
  variable /var/plexguide/project.ipregion NOT-SET
  variable /var/plexguide/project.ipzone NOT-SET
  variable /var/plexguide/project.processor 2
  variable /var/plexguide/project.ram 8
  variable /var/plexguide/project.nvme 1
  variable /var/plexguide/project.id NOT-SET
  variable /var/plexguide/project.switch off

  ### variables being called

  #account=$(cat /var/plexguide/project.account)
  account=$(gcloud config configurations list | tail -n 1 | awk '{print $3}')
  if [[ "$account" != "" ]]; then echo $account >/var/plexguide/project.account; fi

  ipaddress=$(cat /var/plexguide/project.ipaddress)
  ipregion=$(cat /var/plexguide/project.ipregion)
  ipzone=$(cat /var/plexguide/project.ipzone)
  nvmecount=$(cat /var/plexguide/project.nvme)
  ramcount=$(cat /var/plexguide/project.ram)
  processor=$(cat /var/plexguide/project.processor)

  # if user switches usernames, this turns on. turns of when user sets project again
  switchcheck=$(cat /var/plexguide/project.switch)
  if [[ "$switchcheck" != "on" ]]; then
    projectid=$(gcloud config configurations list | tail -n 1 | awk '{print $4}')
    if [[ "$projectid" != "" ]]; then echo $projectid >/var/plexguide/project.id; fi
  fi

  serverstatus=serverstatus
  sshstatus=notready
}

servercheck() {

  gcedeployedcheck="NOT DEPLOYED"
  minicheck=$(cat /var/plexguide/project.id)
  if [[ "$minicheck" != "NOT-SET" ]]; then

    temp55=$(gcloud compute instances list | grep pg-gce)
    if [[ "$temp55" != "" ]]; then gcedeployedcheck="DEPLOYED"; fi

  fi
}

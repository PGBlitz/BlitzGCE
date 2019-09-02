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
  variable /pg/var/project.account NOT-SET
  variable /pg/var/project.ipaddress NOT-SET
  variable /pg/var/project.ipregion NOT-SET
  variable /pg/var/project.ipzone NOT-SET
  variable /pg/var/project.processor 2
  variable /pg/var/project.ram 8
  variable /pg/var/project.nvme 1
  variable /pg/var/project.id NOT-SET
  variable /pg/var/project.switch off

  ### variables being called

  #account=$(cat /pg/var/project.account)
  account=$(gcloud config configurations list | tail -n 1 | awk '{print $3}')
  if [[ "$account" != "" ]]; then echo $account >/pg/var/project.account; fi

  ipaddress=$(cat /pg/var/project.ipaddress)
  ipregion=$(cat /pg/var/project.ipregion)
  ipzone=$(cat /pg/var/project.ipzone)
  nvmecount=$(cat /pg/var/project.nvme)
  ramcount=$(cat /pg/var/project.ram)
  processor=$(cat /pg/var/project.processor)

  # if user switches usernames, this turns on. turns of when user sets project again
  switchcheck=$(cat /pg/var/project.switch)
  if [[ "$switchcheck" != "on" ]]; then
    projectid=$(gcloud config configurations list | tail -n 1 | awk '{print $4}')
    if [[ "$projectid" != "" ]]; then echo $projectid >/pg/var/project.id; fi
  fi

  serverstatus=serverstatus
  sshstatus=notready
}

servercheck() {

  gcedeployedcheck="NOT DEPLOYED"
  minicheck=$(cat /pg/var/project.id)
  if [[ "$minicheck" != "NOT-SET" ]]; then

    temp55=$(gcloud compute instances list | grep pg-gce)
    if [[ "$temp55" != "" ]]; then gcedeployedcheck="DEPLOYED"; fi

  fi
}

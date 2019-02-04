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

  # sets variables if they do not exist
  variable /var/plexguide/project.account NOT-SET
  variable /var/plexguide/project.ipaddress NOT-SET
  variable /var/plexguide/project.ipregion NOT-SET
  variable /var/plexguide/project.processor NOT-SET

  # variables being called
  account=$(cat /var/plexguide/project.account)
  ipaddress=$(cat /var/plexguide/project.ipaddress)
  ipregion=$(cat /var/plexguide/project.ipregion)
  nvmecount=nvmecount
  processor=$(cat /var/plexguide/project.processor)
  projectid=projectid
  serverstatus=serverstatus
  sshstatus=notready
}

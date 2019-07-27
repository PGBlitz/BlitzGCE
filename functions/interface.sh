#!/bin/bash
#
# Title:      PGBlitz (Reference Title File)
# Author(s):  Admin9705
# URL:        https://pgblitz.com - http://github.pgblitz.com
# GNU:        General Public License v3.0
################################################################################
source /opt/blitzgce/functions/main.sh
suffix=GB
billingdeny() {
  if [[ $(gcloud beta billing accounts list | grep "\<True\>") == "" ]]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 MESSAGE TYPE: ERROR
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

REASON: Billing Failed

INSTRUCTIONS: Must turn on the billing for first for this project in
GCE Panel. Exiting!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -p '↘️  Acknowledge Error | Press [ENTER] ' typed </dev/tty

    projectinterface
  fi

}

deployfail() {

  gcefail="off"

  fail1=$(cat /var/plexguide/project.ipregion)
  fail2=$(cat /var/plexguide/project.processor)
  fail3=$(cat /var/plexguide/project.account)
  fail4=$(cat /var/plexguide/project.nvme)

  if [[ "$fail1" == "NOT-SET" || "$fail2" == "NOT-SET" || "$fail3" == "NOT-SET" || "$fail4" == "NOT-SET" ]]; then
    gcefail="on"
  fi

  if [[ "$gcefail" == "on" ]]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  Deployment Checks Failed!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Failed to set the processer count, log in, and/or set your server
location! Ensure that everything is set before deploying the GCE Server!

INSTRUCTIONS: Quit Being a BoneHead and Read!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -p '↘️  Acknowledge Being a BoneHead | Press [ENTER] ' typed </dev/tty

    gcestart
  fi
}

nvmecount() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  NVME Count
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Most users will only need to utilize 1 -2 NVME Drives. The more, the
faster the processing, but the faster your credits drain. If intent is to
be in beast mode during the GCE's duration, 3 - 4 is acceptable.

INSTRUCTIONS: Set the NVME Count ~ 1/2/3/4
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p 'Type Number | Press [ENTER]: ' typed </dev/tty

  ##if [[ "$typed" == "1" || "$typed" == "2" || "$typed" == "3" || "$typed" == "4" ]]

  ##; then
  ## echo "$typed" > /var/plexguide/project.nvme; else nvmecount; fi

  ## NVME counter to add dont edit this lines below
  nvmedeploy="$(cat /var/plexguide/deploy.nvme)"

  if [[ "$typed" == "1" ]]; then
    echo "$typed" >/var/plexguide/project.nvme
    echo -e "--local-ssd interface=nvme" >/var/plexguide/deploy.nvme
  elif [[ "$typed" == "2" ]]; then
    echo "$typed" >/var/plexguide/project.nvme
    echo -e "--local-ssd interface=nvme \\n--local-ssd interface=nvme " >/var/plexguide/deploy.nvme
  elif [[ "$typed" == "3" ]]; then
    echo "$typed" >/var/plexguide/project.nvme
    echo -e "--local-ssd interface=nvme \\n--local-ssd interface=nvme \\n--local-ssd interface=nvme" >/var/plexguide/deploy.nvme
  elif [[ "$typed" == "4" ]]; then
    echo "$typed" >/var/plexguide/project.nvme
    echo -e "--local-ssd interface=nvme \\n--local-ssd interface=nvme \\n--local-ssd interface=nvme \\n--local-ssd interface=nvme" >/var/plexguide/deploy.nvme
  else nvmecount; fi
}
ramcount() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  RAM Count
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Most users will only need to utilize 8 Gb Ram . The more, the
faster the processing, but the faster your credits drain. If intent is to
be in beast mode during the GCE's duration, 16GB is acceptable.

INSTRUCTIONS: Set the RAM Count ~ 8 / 12 / 16 GB
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p 'Type Number | Press [ENTER]: ' typed </dev/tty

  if [[ "$typed" == "8" || "$typed" == "12" || "$typed" == "16" ]]; then
    echo "$typed""$suffix" >/var/plexguide/project.ram
  else ramcount; fi
}

processorcount() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  Processor Count
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

INFORMATION: The processor count utilizes can affect how fast your credits
drain. If usage is light, select 2. If for average use, 2 or 6 is fine.
Only utilize 8 if the GCE will be used heavily!

INSTRUCTIONS: Set the Processor Count ~ 2/4/6/8
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p 'Type Number | Press [ENTER]: ' typed </dev/tty

  if [[ "$typed" == "2" || "$typed" == "4" || "$typed" == "6" || "$typed" == "8" ]]; then
    echo "$typed" >/var/plexguide/project.processor
  else processorcount; fi
}

projectinterface() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  Project Interface
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Project ID: $projectid

[1] Utilize/Change Existing Project
[2] Build a New Project
[3] Destroy Existing Project

[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p 'Type Number | Press [ENTER]: ' typed </dev/tty

  case $typed in
  1)

    infolist() {
      tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  Utilize/Change Existing Project      ⚡ Reference: pggce.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

QUESTION: Which existing project will be utilized for the PG-GCE?
$prolist

[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    }

    pnum=0
    mkdir -p /var/plexguide/prolist
    rm -rf /var/plexguide/prolist/* 1>/dev/null 2>&1

    echo "" >/var/plexguide/prolist/final.sh
    gcloud projects list | cut -d' ' -f1 | tail -n +2 >/var/plexguide/prolist/prolist.sh

    ### project no exist check
    pcheck=$(cat /var/plexguide/prolist/prolist.sh)
    if [[ "$pcheck" == "" ]]; then noprojects; fi

    while read p; do
      let "pnum++"
      echo "$p" >"/var/plexguide/prolist/$pnum"
      echo "[$pnum] $p" >>/var/plexguide/prolist/final.sh
    done </var/plexguide/prolist/prolist.sh
    prolist=$(cat /var/plexguide/prolist/final.sh)

    typed2=999999999
    while [[ "$typed2" -lt "1" || "$typed2" -gt "$pnum" ]]; do
      infolist
      read -p 'Type Number | Press [ENTER]: ' typed2 </dev/tty
      if [[ "$typed2" == "exit" || "$typed2" == "Exit" || "$typed2" == "EXIT" || "$typed2" == "z" || "$typed2" == "Z" ]]; then projectinterface; fi
    done

    typed=$(cat /var/plexguide/prolist/$typed2)
    gcloud config set project $typed
    billingdeny

    echo "off" >/var/plexguide/project.switch

    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 PLEASE WAIT! Enabling Billing ~ Project $typed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    accountbilling=$(gcloud beta billing accounts list | tail -1 | awk '{print $1}')
    gcloud beta billing projects link $typed --billing-account "$accountbilling" --quiet

    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 PLEASE WAIT! Enabling Compute API ~ Project $typed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    gcloud services enable compute.googleapis.com

    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 PLEASE WAIT! Enabling Drive API ~ Project $typed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    echo ""
    gcloud services enable drive.googleapis.com --project $typed

    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 NOTICE: Project Default Set ~ $typed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    echo $typed >/var/plexguide/pgclone.project
    echo
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
    variablepull
    projectinterface
    ;;

  2)

    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  Create & Set a Project Name
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

INSTRUCTIONS: Set a Project Name and keep it short and simple! No spaces
and keep it all lower case! Failing to do so will result in naming
issues.

[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -p 'Type Project Name | Press [ENTER]: ' projectname </dev/tty
    echo ""

    # loops user back to exit if typed
    if [[ "$projectname" == "exit" || "$projectname" == "Exit" || "$projectname" == "EXIT" || "$projectname" == "z" || "$projectname" == "Z" ]]; then
      projectinterface
    fi

    # generates a random number within to prevent collision with other Google Projects; yes everyone!
    rand=$(echo $((1 + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM)))
    projectfinal="pg-$projectname-$rand"
    gcloud projects create $projectfinal

    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  Project Message
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

INFO: $projectfinal created. Ensure afterwards to ESTABLISH the project
as your default to utilize!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF

    read -p 'Acknowledge Info | Press [ENTER]' typed </dev/tty

    projectinterface
    ;;

  3)
    existlist() {
      tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  Delete Existing Projects
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

WARNING : Deleting projects will result in deleting keys that are
associated with it! Be careful in what your doing!

QUESTION: Which existing project will be deleted?
$prolist

[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    }

    pnum=0
    mkdir -p /var/plexguide/prolist
    rm -rf /var/plexguide/prolist/* 1>/dev/null 2>&1

    echo "" >/var/plexguide/prolist/final.sh
    gcloud projects list | cut -d' ' -f1 | tail -n +2 >/var/plexguide/prolist/prolist.sh

    ### prevent bonehead from deleting the project that is active!
    variablepull
    sed -i -e "/${projectid}/d" /var/plexguide/prolist/prolist.sh

    ### project no exist check
    pcheck=$(cat /var/plexguide/prolist/prolist.sh)
    if [[ "$pcheck" == "" ]]; then noprojects; fi

    while read p; do
      let "pnum++"
      echo "$p" >"/var/plexguide/prolist/$pnum"
      echo "[$pnum] $p" >>/var/plexguide/prolist/final.sh
    done </var/plexguide/prolist/prolist.sh
    prolist=$(cat /var/plexguide/prolist/final.sh)

    typed2=999999999
    while [[ "$typed2" -lt "1" || "$typed2" -gt "$pnum" ]]; do
      existlist
      read -p 'Type Number | Press [ENTER]: ' typed2 </dev/tty
      if [[ "$typed2" == "exit" || "$typed2" == "Exit" || "$typed2" == "EXIT" || "$typed2" == "z" || "$typed2" == "Z" ]]; then projectinterface; fi
    done

    typed=$(cat /var/plexguide/prolist/$typed2)
    gcloud projects delete "$typed"

    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 System Message: Project Deleted ~ $typed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    echo $typed >/var/plexguide/pgclone.project
    echo
    read -p '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty
    variablepull
    projectinterface
    ;;
  z)
    gcestart
    ;;
  Z)
    gcestart
    ;;
  *)
    processorcount
    nvmecount
    ;;
  esac

}

### Function for if no projects exists
noprojects() {
  tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  No Projects Exist                     ⚡ Reference: pggce.pgblitz.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

WARNING: No projects exists! Cannot delete the default active project if
that exists!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
  read -p '↘️  Acknowledge Info | Press [ENTER] ' typed </dev/tty

  ### go back to main project interface
  projectinterface
}

projectdeny() {
  if [[ $(cat /var/plexguide/project.id) == "NOT-SET" ]]; then
    tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 MESSAGE TYPE: ERROR
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

REASON: Project ID Not Set

INSTRUCTIONS: Project ID from the Project Interface must be set first.
Exiting!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

EOF
    read -p '↘️  Acknowledge Error | Press [ENTER] ' typed </dev/tty
    gcestart
  fi

}

sshdeploy() {
  variablepull
  gcloud compute ssh pg-gce --zone "$ipzone"
  gcestart
}

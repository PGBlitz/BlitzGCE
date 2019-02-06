#!/bin/bash
#
# Title:      PlexGuide (Reference Title File)
# Author(s):  Admin9705
# URL:        https://plexguide.com - http://github.plexguide.com
# GNU:        General Public License v3.0
################################################################################
source /opt/pggce/functions/main.sh

destroyserver () {
  ### what is location?
  gcloud compute instances delete pg-gce --quiet --zone "$location"
  rm -rf /root/.ssh/google_compute_engine 1>/dev/null 2>&1

tee <<-EOF

🌎  NOTE: Server Destroyed
EOF
read -p 'Acknowledge | Press [ENTER]: ' typed < /dev/tty

}

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

processorcount () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  Processor Count                     ⚡ Reference: pggce.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Information: The processor count utilizes can affect how fast your credits
drain. If usage is light, select 2. If for average use, 2 or 6 is fine.
Only utilize 8 if the GCE will be used heavily!

INSTRUCTIONS: Set the Processor Count ~ 2/4/6/8
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p 'Type Number | Press [ENTER]: ' typed < /dev/tty

if [[ "$typed" == "2" || "$typed" == "4" || "$typed" == "6" || "$typed" == "8" ]]; then
  echo "$typed" > /var/plexguide/project.processor; else processorcount; fi
}

projectinterface () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  Project Interface                   ⚡ Reference: pggce.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Project ID: $projectid

[1] Utilize/Change Existing Project
[2] Build a New Project
[3] Destroy Existing Project
[Z] Exit

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p 'Type Number | Press [ENTER]: ' typed < /dev/tty

case $typed in
    1 )

infolist () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  Utilize/Change Existing Project      ⚡ Reference: pggce.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

QUESTION: Which existing project will be utilized for the PG-GCE?
$prolist

Quitting? Type >>> exit (all lowercase)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
}

        pnum=0
        mkdir -p /var/plexguide/prolist
        rm -r /var/plexguide/prolist/*

        echo "" > /var/plexguide/prolist/final.sh
        gcloud projects list | cut -d' ' -f1 | tail -n +2 > /var/plexguide/prolist/prolist.sh

        ### project no exist check
        pcheck=$(cat /var/plexguide/prolist/prolist.sh)
        if [[ "$pcheck" == "" ]]; then noprojects; fi

        while read p; do
          let "pnum++"
          echo "$p" > "/var/plexguide/prolist/$pnum"
          echo "[$pnum] $p" >> /var/plexguide/prolist/final.sh
        done </var/plexguide/prolist/prolist.sh
        prolist=$(cat /var/plexguide/prolist/final.sh)

        pnum=9
        typed2=999999999
        while [[ "$typed2" -lt "1" || "$typed2" -gt "$pnum" ]]; do
          infolist
          read -p 'Type Number | Press [ENTER]: ' typed2 < /dev/tty
          if [[ "$typed2" == "exit" || "$typed2" == "Exit" || "$typed2" == "EXIT" ]]; then projectinterface; fi
        done

        typed=$(cat /var/plexguide/prolist/$typed2)
        gcloud config set project $typed

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 System Message: Enabling Drive API ~ Project $typed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
        echo ""
        gcloud services enable drive.googleapis.com --project $typed

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 System Message: Project Established ~ $typed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
        echo $typed > /var/plexguide/pgclone.project
        echo
        read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
        variablepull
        projectinterface ;;

        2 )

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  Create & Set a Project Name         ⚡ Reference: pggce.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

INSTRUCTIONS: Set a Project Name and keep it short and simple! No spaces
and keep it all lower case! Failing to do so will result in naming
issues.

Quitting? Type >>> exit (all lowercase)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
        read -p 'Type Project Name | Press [ENTER]: ' projectname < /dev/tty
        echo ""

          # loops user back to exit if typed
          if [[ "$projectname" == "exit" || "$projectname" == "Exit" || "$projectname" == "EXIT" ]]; then
          projectinterface; fi

        # generates a random number within to prevent collision with other Google Projects; yes everyone!
        rand=$(echo $((1 + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM + RANDOM )))
        projectfinal="pg-$projectname-$rand"
        gcloud projects create $projectfinal

        tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  Project Message                       ⚡ Reference: pggce.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

INFO: $projectfinal created! Ensure to set it as your default for an
existing intnerface afterwards!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF

read -p 'Type y or n | Press [ENTER]: ' typed < /dev/tty

projectinterface ;;

    3 )
existlist () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  Delete Existing Projects              ⚡ Reference: pggce.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

WARNING : Deleting projects will result in deleting keys that are
associated with it! Be careful in what your doing!

QUESTION: Which existing project will be deleted?
$prolist

Quitting? Type >>> exit (all lowercase)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
}

        pnum=0
        mkdir -p /var/plexguide/prolist
        rm -r /var/plexguide/prolist/*

        echo "" > /var/plexguide/prolist/final.sh
        gcloud projects list | cut -d' ' -f1 | tail -n +2 > /var/plexguide/prolist/prolist.sh

        ### project no exist check
        pcheck=$(cat /var/plexguide/prolist/prolist.sh)
        if [[ "$pcheck" == "" ]]; then noprojects; fi

        ### prevent bonehead from deleting the project that is active!
        variablepull
        sed -i -e "/${projectid}/d" /var/plexguide/prolist/prolist.sh

        while read p; do
          let "pnum++"
          echo "$p" > "/var/plexguide/prolist/$pnum"
          echo "[$pnum] $p" >> /var/plexguide/prolist/final.sh
        done </var/plexguide/prolist/prolist.sh
        prolist=$(cat /var/plexguide/prolist/final.sh)

        pnum=9
        typed2=999999999
        while [[ "$typed2" -lt "1" || "$typed2" -gt "$pnum" ]]; do
          existlist
          read -p 'Type Number | Press [ENTER]: ' typed2 < /dev/tty
          if [[ "$typed2" == "exit" || "$typed2" == "Exit" || "$typed2" == "EXIT" ]]; then projectinterface; fi
        done

        typed=$(cat /var/plexguide/prolist/$typed2)
        gcloud projects delete $typed

tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎 System Message: Project Deleted ~ $typed
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
        echo $typed > /var/plexguide/pgclone.project
        echo
        read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty
        variablepull
        projectinterface ;;
    z )
        exit ;;
    Z )
        exit ;;
    * )
        processorcount ;;
esac

}

### Function for if no projects exists
noprojects () {
tee <<-EOF

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🌎  No Projects Exist                     ⚡ Reference: pggce.plexguide.com
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

WARNING: No projects exists!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
read -p '↘️  Acknowledge Info | Press [ENTER] ' typed < /dev/tty

### go back to main project interface
projectinterface
}

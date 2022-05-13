#!/bin/bash

export ansible_root=`pwd`
export ANSIBLE_CONFIG=${ansible_root}/ansible.cfg

# Usage info
show_help() {
cat << EOF
Usage: ${0##*/} [ playbook  stackEnv  stackService  stackInstName ]
            playbook: playbook  name without ".yml" - look for available playbooks
            stackEnv: stackEnv like  prod or qa or dev
            stackService: stackService like app, db, dbhost, apphost
            stackInstName: stackInstName like for host ae-dev-ebs-app01 or ebsd for instance
EOF
}


if (( $# != 4 )) 
then
        show_help
        exit 
fi

#playbook name without ".yml"
playbook=$1
# #stackEnv = prod or qa or dev
stackEnv=$2
# #stackService=app or db or apphost or dbhost
stackService=$3
# #stackInstName= orclqa62 (instancename) or shorthostname
stackInstName=$4



#inventory
export target="${stackEnv,,}-ora-${stackService,,}"

if [[ "${stackService,,}" == "apphost" ]] || [[ "${stackService,,}" == "dbhost" ]]
then
stackService="host"
fi

# removing AWS discovery - as not checking for LVM and storage
#if [[ "${playbook,,}" == "ebshosts" ]] || [[ "${playbook,,}" == "lvm-fs-init" ]]
#then
#################### User Confirmation######################
#read -p "Please make sure $ansible_root/vars/secret/keys.yml is updated and encrypted?  If this is not the case, playbook won't configure storage. Only if its configured Press Y/y " -n 1 -r
#echo    # (optional) move to a new line
#if [[ ! $REPLY =~ ^[Yy]$ ]]
#then
#    exit 1
#fi
#
#fi
# EOF


#actual play
#ansible-playbook  --vault-password-file ${ansible_root}/vars/secret/.vault ${ansible_root}/playbooks/${playbook}.yml  -i inventory/${stackEnv} -l  $target --extra-vars "stackEnv=${stackEnv} stackService=${stackService} stackInstName=${stackInstName}"
ansible-playbook  ${ansible_root}/playbooks/${playbook}.yml -i inventory/${stackEnv} -l  $target --extra-vars "stackEnv=${stackEnv} stackService=${stackService} stackInstName=${stackInstName}"
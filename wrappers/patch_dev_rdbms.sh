#!/bin/bash

# this is custom ansible automation wrapper to patch OPatch

# start with Ansible Home dir
cd ../
pwd
# lsit all the playbooks to execute in order
# note how --extra-vars remains the same for all exeuction - it's just a playbook change
ansible-playbook playbooks/connect.yml -i inventory/dev -l tst --extra-vars "env=dev target=tst_19c_rdbms cycle=2022_OCT_RDBMS_PSU"
ansible-playbook playbooks/download.yml -i inventory/dev -l tst --extra-vars "env=dev target=tst_19c_rdbms cycle=2022_OCT_RDBMS_PSU"
ansible-playbook playbooks/stop.yml -i inventory/dev -l tst --extra-vars "env=dev target=tst_19c_rdbms cycle=2022_OCT_RDBMS_PSU"
ansible-playbook playbooks/19c_rdbms_patch_opatch.yml -i inventory/dev -l tst --extra-vars "env=dev target=tst_19c_rdbms cycle=2022_OCT_RDBMS_PSU"
ansible-playbook playbooks/19c_rdbms_patch_opatch.yml -i inventory/dev -l tst --extra-vars "env=dev target=tst_19c_rdbms cycle=2022_OCT_RDBMS_PSU"
ansible-playbook playbooks/start.yml -i inventory/dev -l tst --extra-vars "env=dev target=tst_19c_rdbms cycle=2022_OCT_RDBMS_PSU"
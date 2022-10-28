# Ansible Automation framework for Oracle product patching
blame saldabols@pythian.com

think of this automtation framework as tool to create templates for various tasks, push thos templates into target server replacing changing variables like , patch id, oracle_home and finally executing them. Whole idea of tool is to provide step by step repetitive tasks, make a scenarious out of it
and repeart accross environments.

## patching prerequsities
 
  - need to have an ansible user on target host (can be oracle): but need to have sudo su - oracle (product owner privilege)
  ```
  [root@localhost ~]# cat /etc/sudoers.d/91-ansible-init-users
# User rules for ansible for example
ansible ALL=(ALL) NOPASSWD:ALL`
```
  - need describe ansible inverotry and variables

## example setup:

Below direcotry structure describe the seteup

```
cycles                                    # repetative patching cycle descriptor - list of patches to download / rollback / apply 
 - 2022_JUL_RDBMS_PSU.yml                 # exact scenario
 - 2022_OCT_RDBMS_PSU.yml
inventory                                 # list of inventory / describing physical host connection details
 - dev
playbooks                                 # playbooks - instructions (roles to run)
 - patch_19c_database.yml                 
roles                                     # roles - exact task to run, example of having bash template filled by cycle & vars data / push on server and execute
 - /19c_rdbms_patch_oh/
    - /tasks              
        -  /main.yml
    - /templates                          # templates
        - /19c_rdbms_patch_oh.sh.j2
vars                                      # variable section | totally 4 variables needed per run: global, env global, target and cycle
 - dev
   - dev_rdbms.yml                        # exact target details variable
   - global.yml                           # environment/pod gloabal variable describing server setup/environment
   - tst_19c_rdbms.yml
 - global.yml                             # gloabal variable describing client
 - keys
 - prod
 - qa
wrappers                                  # can customize ansible run by bash - create one-off scripts that could be scheduled
 - patch_dev_rdbms.sh
README.md
ansible.cfg
```

## run example:

# this example would run patch_19c_database playbook doing download, stage patches, stop db, patch opatch, oh, start DB
ansible-playbook playbooks/patch_19c_database.yml -i inventory/dev -l tst --extra-vars "env=dev target=tst_19c_rdbms cycle=2022_OCT_RDBMS_PSU"

# this example would connect AWS machine - execute only execute playbook - that does copy tempalte to server and execute it
ansible-playbook playbooks/execute.yml -i inventory/dev -l aws --extra-vars "env=dev target=dev_rdbms cycle=2022_OCT_RDBMS_PSU"

 - -v will add output 

# this example execute bash wrapper script that would do exactly same as patch_19c_database playbook
Raiviss-MacBook-Pro-2:ansible_oracle_patch raivissaldabols$ cd wrappers/
Raiviss-MacBook-Pro-2:wrappers raivissaldabols$ sh patch_dev_rdbms.sh


# adop example
time ansible-playbook playbooks/adop.yml -i inventory/uat -l uat_app --extra-vars "env=uat target=ebs122_uat_app cycle=2022_JUL_RDBMS_PSU"

## to know

 - stage direcotry (definded in global.yaml) is outside this ansible playbook home - so pushing to git doesn't push actual patches
 - same applies for local log dir
 - on each target server there is ansible/bin (scripts to execute) /log/ (executiong loggin) /stage (pathes) dir for various purposes.
 - each ansible execution will create a log file on server with timestamp

## TO DO list:
 - env printing
 - test run (without executing)
 - verbose
 - logs gahters
 - check ansible home dir permissions
 - confirmation/prompting ? if correct env is selected before making changes
 - ansible vault for : MOS user/pass, for connections, for client stop/start if required
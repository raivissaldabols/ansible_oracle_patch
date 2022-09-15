# this is ansible attempt to create simple patching framework
# example setup:
 
# invetory : setting up physical hosts
# vars : setting up environments and systems 
# cycles : describe instcution list
# playbooks 
# roles

# run example:
# local VM ones with user/password
ansible-playbook playbooks/connect.yml -i inventory/dev -l box1 --extra-vars "env=dev target=rdbms cycle=2022_RDBMS_PSU"

# AWS instance with key
ansible-playbook playbooks/connect.yml -i inventory/dev -l aws1 --extra-vars "env=dev target=rdbms cycle=2022_RDBMS_PSU"


# must have items to resolve before move on:
# - logging: need to have execution details on server + also on ansible host but outside ansible home (so not to move into GIT if pushed)
# - structure of call  / intuitive call options
# - ansible vault with good examples how to put secrets in / use in scripts, calls / etc

# once above resolved can start with actual to do
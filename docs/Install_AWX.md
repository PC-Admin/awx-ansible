
# AWX Installation Instructions

How to install this AWX setup.


## Provision a Server

Provision a Debian 11 or Ubuntu 22.04 server with >=8GB RAM and a public IP, then setup SSH access to the root account, this will be our AWX server.

If you plan on using a backup/monitor server (recommended), provision a Debian 11 or Ubuntu 22.04 server with >=4GB RAM and setup SSH access to the root account.


## Setup DNS entry for it:

Map an: 

A/AAAA record for panel.example.org to the servers IP.
A/AAAA record for rancher.example.org to the servers IP, 
    or a CNAME record for it pointing to panel.example.org.
optionally, an A/AAAA record for grafana.example.org to the backup/monitor servers IP.


## Install

1) Install the following ansible-galaxy packages on the controller:

`$ ansible-galaxy collection install --force awx.awx:21.9.0`
`$ ansible-galaxy collection install community.grafana`


2) Edit host into: [./inventory/hosts](./inventory/hosts)

Create folder for each host at: ./inventory/host_vars/

Record these variables into each hosts vars.yml:
```
# Your organisations name
org_name: Example
# URL of the AWX instance.
awx_url: awx.example.org
# AWX database password.
pg_password: strong-password
# AWX admin user password.
admin_password: strong-password
# AWX secrets password.
secret_key: strong-password
# Time periods for schedules, eg: 
# 'MINUTELY', 'HOURLY', 'DAILY', 'WEEKLY','MONTHLY'
update_schedule_frequency: 'WEEKLY'
# Number of hours/days/weeks to schedule updates too:
update_schedule_interval: 4
# Project repository URL.
deploy_source: https://github.com/PC-Admin/project-repository.git
# Branch of the project repository.
deploy_branch: testing
# The organisations email for LetsEncrypt.
certbot_email: michael@perthchat.org
```

If using the backup server also configure:
```
backup_enabled: true
backup_server_url: backup.example.org
```


3) Run the playbook with the following tags:

`$ ansible-playbook -v -i ./inventory/hosts -t "setup,setup-firewall,master-token,configure-awx" setup.yml`

BUSTED TAG: `setup-rancher`


4) To install the backup/monitor server run the playbook again with the following tags:

`$ ansible-playbook -v -i ./inventory/hosts -t "setup-backup,setup-monitor" setup.yml`

NOTE: If using the monitor, you need to immediately go to your {{ grafana_url }} and set the initial administrator password manually.


5) In AWX 'customize pod specification' for the default Container Instance Group:

Go into: Instance Groups > default > Edit

Check 'Customize pod specification' and alter the following values in 'Custom pod spec':
```
apiVersion: v1
kind: Pod
metadata:
  namespace: awx
spec:
  serviceAccountName: awx-backup
  automountServiceAccountToken: true
  containers:
    - image: quay.io/ansible/awx-ee:latest
      name: worker
      args:
        - ansible-runner
        - worker
        - '--private-data-dir=/runner'
      resources:
        requests:
          cpu: 250m
          memory: 100Mi
```

OR

Go into: Instance Groups > Add > Add container group > Set name to 'AWX Server'. then insert the variables above.

Edit the 'Backup AWX System' job template select the 'AWX Server' instance group, save it.


6) In AWX, set the base URL

Go into: Settings > Miscellaneous System Settings > Edit

Alter the value of 'Base URL of the Tower host' to your AWX systems URL.
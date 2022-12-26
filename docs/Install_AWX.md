
# AWX Installation Instructions

How to install this AWX setup.


## Provision the Servers

Provision a Debian 11 or Ubuntu 22.04 server with >=8GB RAM, disabled swap and a public IP, then setup SSH access to root@{{ awx_url }} account, this will be our AWX server.

If you plan on using a backup/monitor server (recommended), provision a Debian 11 or Ubuntu 22.04 server with >=4GB RAM and setup SSH access to root@IP.


## Setup DNS Entries for it

1) A/AAAA record for awx.example.org to the servers IP.

2) optionally, an A/AAAA record for rancher.example.org to the servers IP, 
    or a CNAME record for it pointing to awx.example.org.

3) optionally, an A/AAAA record for grafana.example.org to the backup/monitor servers IP.


## Install

1) Install the following ansible-galaxy packages on the controller:
```
$ ansible-galaxy collection install --force awx.awx:21.9.0
$ ansible-galaxy collection install community.grafana
```


2) Edit host into: [./inventory/hosts](./inventory/hosts)

Create folder for each host at: ./inventory/host_vars/

Record each hosts variables into each hosts ./inventory/host_vars/example.org/vars.yml file.


3) Run the playbook with the following tags:

`$ ansible-playbook -v -i ./inventory/hosts -t "setup,setup-firewall,master-token,configure-awx,setup-rancher,setup-backup,setup-monitor" setup.yml`

NOTE: If using the monitor for the first time, you need to immediately go to your {{ grafana_url }} and set the initial administrator password manually.
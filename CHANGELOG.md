
## AWX Ansible v0.0.7 [2022-12-29]

- Added semi-automated recovery for AWX.
- Added a 'AWX Status Check' template to examine if AWX is functional.
- Fix compatibility for Debian 11.
- Refactor of the entire playbook.

## AWX Ansible v0.0.6 [2022-12-25]

- Refined the grafana monitor. 
- Configured a workflow template powered backup for AWX. Where one job template causes a local dump, while the next template triggers a borgmatic backup from AWX to the backup server.

## AWX Ansible v0.0.5 [2022-12-20]

- Fix AWX token generation. [done]
- Fix Rancher. [done]
- Add basic monitoring with Node Exporter. [done]

## AWX Ansible v0.0.4 [2022-11-29]

Increase AWX version to 21.9.0 with awx-operator 1.1.0.

## AWX Ansible v0.0.3 [2022-11-23]

Increase AWX version to 21.8.0 with awx-operator 1.0.0.

## AWX Ansible v0.0.2 [2022-07-24]

Increase AWX version to 21.3.0 with awx-operator 0.24.0.

## AWX Ansible v0.0.1 [2022-07-16]

Initial release of generic AWX system.

Deploys an AWX 21.2.0 system onto k3s, uses awx-operator 0.23.0.
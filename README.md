# AWX Ansible

This playbook spawns a ready-to-use AWX system and Rancher on K3S, on a Debian 11 or Ubuntu 22.04 host.
Backup and recovery is automated by ansible between the AWX server and the Backup/Monitor server.

It can optionally install:
- [Rancher](https://www.rancher.com/), a management tool for Kubernetes/K3S.
- [Grafana](https://grafana.com/), an open source analytics & monitoring solution.
- [BorgBackup](https://www.borgbackup.org/), A deduplicating backup system with compression and encryption.

AWX is a tool that can be used to manage multiple servers with Ansible.
Ideally this system can manage the updates, configuration, backups and monitoring of many servers/services on its own. 


## Previews




## Installation

To configure and install this AWX setup on your own server, follow the [Install_AWX.md in the docs/ directory](docs/Install_AWX.md).


## To Do

- Automate routine recovery testing for the AWX setup [in progress]
- Allow for self-signed certs (opt-out of letsencrypt) [in progress]
- Get Apache onto docker too? []
- Add email alerts for system issues []


## License

This playbook is copyrighted by Michael Collins under the [MIT License](licenses/MIT_License_Michael_Collins.txt).


## Other Licenses

"AWX" is a registered trademark of Red Hat, Inc. Please consult their [AWX Trademark Guidelines](https://github.com/ansible/awx-logos/blob/master/TRADEMARKS.md) for more information.

The AWX source code is copyrighted to Red Hat Inc, and is made available under the [Apache License 2.0](https://github.com/ansible/awx/blob/devel/LICENSE.md).

Rancher is Kubernetes management tool, it is copyrighted to Rancher Labs and is made available under the [Apache License 2.0](https://github.com/rancher/rancher/blob/release/v2.7/LICENSE).

"awx-on-k3s" is an example implementation of AWX on K3s, it is copyrighted to 'kurokobo' and made available under the [MIT License](https://github.com/kurokobo/awx-on-k3s/blob/main/LICENSE).
# AWX Ansible

This playbook spawns a ready-to-use AWX system on K3S, on a Debian 11 or Ubuntu 22.04 host.
AWX is a tool that can be used to manage multiple servers with Ansible.

It can optionally install:
- [Rancher](https://www.rancher.com/), a management tool for Kubernetes/K3S.
- [Grafana](https://grafana.com/), an open source analytics & monitoring solution.
- [BorgBackup](https://www.borgbackup.org/), A deduplicating backup system with compression and encryption.


Ideally this system can manage the updates, configuration, backups and monitoring of many servers/services on its own. 


## Installation

To configure and install this AWX setup on your own server, follow the [Install_AWX.md in the docs/ directory](docs/Install_AWX.md).


## To Do

- Update AWX to newer version. 21.9.0/1.1.0 [done]
- Update awx-on-k3s to newer version. 1.1.0 [done]
- Update k9s to latest version. [done]
- Fix AWX token generation. [done]
- Fix Rancher. [done]
- Add basic monitoring with Node Exporter. [done]
- Refine prometheus/grafana monitoring. [done]
- Automate backups using borg. [done]
- Add template for listing current backups on local and remote host. [done]
- Make AWX regenerate the SSH key for borg@{{ awx_url }} every time. [done]
- Automate recovery. [done]
- Create AWX status test [done]
- Automate routine recovery testing for the AWX setup. [in progress]
- Get Apache onto docker too? [in progress]
- Add email alerts for system issues []


## License

This playbook is copyrighted by Michael Collins under the [MIT License](licenses/MIT_License_Michael_Collins.txt).


## Other Licenses

"AWX" is a registered trademark of Red Hat, Inc. Please consult their [AWX Trademark Guidelines](https://github.com/ansible/awx-logos/blob/master/TRADEMARKS.md) for more information.

The AWX source code is copyrighted to Red Hat Inc, and is made available under the [Apache License 2.0](https://github.com/ansible/awx/blob/devel/LICENSE.md).

Rancher is Kubernetes management tool, it is copyrighted to Rancher Labs and is made available under the [Apache License 2.0](https://github.com/rancher/rancher/blob/release/v2.7/LICENSE).

"awx-on-k3s" is an example implementation of AWX on K3s, it is copyrighted to 'kurokobo' and made available under the [MIT License](https://github.com/kurokobo/awx-on-k3s/blob/main/LICENSE).
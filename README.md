# AWX/Automation Controller Setup

This playbook spawns an AWX/Automation Controller system that can create and manage multiple servers.

It also can install [rancher](https://www.rancher.com/), a tool for managing Kubernetes.

Ideally this system can manage the updates, configuration, backups and monitoring of servers on it's own. 


## Installation

To configure and install this AWX/Automation Controller setup on your own server, follow the [Install_AWX.md in the docs/ directory](docs/Install_AWX.md).


## To Do

- Allow deployment onto Ubuntu 20.04 and 22.04. [done]
- Update AWX to newer version. 1.1.0 [done]
- Update awx-on-k3s to newer version. 1.1.0 [done]
- Update k9s to latest version. [done]
- Fix Rancher. []
- Fix AWX token generation. [fixed?]
- Automate backups using borg.
- Automate recovery.
- Automate routine recovery testing for the AWX setup.


## License

This playbook is copyrighted by Michael Collins under the [MIT License](licenses/MIT_License_Michael_Collins.txt).


## Other Licenses

"AWX" is a registered trademark of Red Hat, Inc. Please consult their [AWX Trademark Guidelines](https://github.com/ansible/awx-logos/blob/master/TRADEMARKS.md) for more information.

The AWX source code is copyrighted to Red Hat Inc, and is made available under the [Apache License 2.0](https://github.com/ansible/awx/blob/devel/LICENSE.md).

Rancher is Kubernetes management tool, it is copyrighted to Rancher Labs and is made available under the [Apache License 2.0](https://github.com/rancher/rancher/blob/release/v2.7/LICENSE).

"awx-on-k3s" is an example implementation of AWX on K3s, it is copyrighted to 'kurokobo' and made available under the [MIT License](https://github.com/kurokobo/awx-on-k3s/blob/main/LICENSE).
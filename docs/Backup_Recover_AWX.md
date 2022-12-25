
# Backup and recover AWX


## Recover from local dump with Ansible.

1) Collect the local tower-openshift-backup directory name, for example:

"tower-openshift-backup-2022-12-24-11:43:33"

2) Run the playbook with the recover-awx-local tag:

`$ ansible-playbook -v -i ./inventory/hosts -e "awx_backup_directory='tower-openshift-backup-2022-12-24-11:43:33'" -t "recover-awx-local" setup.yml`


## Backup manually with: https://github.com/kurokobo/awx-on-k3s/tree/main/backup/#back-up-awx-manually

Example:
```
root@awx:~/awx-on-k3s-1.1.0# NAMESPACE=awx
root@awx:~/awx-on-k3s-1.1.0# cd ./backup/ansible/
root@awx:~/awx-on-k3s-1.1.0/backup/ansible# kubectl -n ${NAMESPACE} apply -f rbac/sa.yaml
serviceaccount/awx-backup created
role.rbac.authorization.k8s.io/awx-backup created
rolebinding.rbac.authorization.k8s.io/awx-backup created

root@awx:~/awx-on-k3s-1.1.0# export K8S_AUTH_HOST="https://awx.penholder.xyz:6443/"
root@awx:~/awx-on-k3s-1.1.0# export K8S_AUTH_VERIFY_SSL=no
root@awx:~/awx-on-k3s-1.1.0# export K8S_AUTH_API_KEY=$(kubectl -n awx create token awx-backup --duration=1h)

root@awx:~/awx-on-k3s-1.1.0# cd ./backup/ansible/
root@awx:~/awx-on-k3s-1.1.0/backup/ansible# ansible-galaxy collection install kubernetes.core
Starting galaxy collection install process
Process install dependency map
Starting collection install process
Installing 'kubernetes.core:2.3.2' to '/root/.ansible/collections/ansible_collections/kubernetes/core'
Downloading https://galaxy.ansible.com/download/kubernetes-core-2.3.2.tar.gz to /root/.ansible/tmp/ansible-local-1360836tq6df3f/tmpfxglrv39
kubernetes.core (2.3.2) was installed successfully

root@awx:~/awx-on-k3s-1.1.0/backup/ansible# sudo apt install python3-pip
root@awx:~/awx-on-k3s-1.1.0/backup/ansible# pip install openshift pyyaml kubernetes

root@awx:~/awx-on-k3s-1.1.0/backup/ansible# ansible-playbook project/backup.yml -e awxbackup_spec="{'deployment_name':'awx','backup_pvc':'awx-backup-claim','clean_backup_on_delete':true}" -e keep_days=90

TASK [Print created AWXBackup] ***********************************************************************************************************************************
ok: [localhost] => {
    "_awxbackup_created_info": {
        "backup_directory": "/backups/tower-openshift-backup-2022-12-08-07:05:19",
        "backup_pvc": "awx-backup-claim",
        "creation_timestamp": "2022-12-08T07:05:03Z",
        "deployment_name": "awx",
        "name": "awxbackup-2022-12-08-07-05-01"
    }
}
```
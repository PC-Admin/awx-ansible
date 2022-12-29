
# Backup and Restore AWX


## Restore local dumps from the Backup Server with Ansible.

1) Collect the borg backup id from either the backup server or AWX's 'Backup AWX [List Backups]' template:

```
borg@backup:~$ borg list ~/AWX/
Enter passphrase for key /home/borg/AWX:
...
awx-2022-12-27T02:02:11              Tue, 2022-12-27 02:02:11 [a2dd0aafca6e1f82b348379feb7ea68a7931b6db62ce06b885421422b8f4a332]
awx-2022-12-27T03:02:08              Tue, 2022-12-27 03:02:09 [f1fd1553288a05c62277db601033b9717445221afa63481ac0d06c6d9811e051]
awx-2022-12-27T04:01:58              Tue, 2022-12-27 04:01:58 [efb4e9df782c0cf625e066bc8a2bede804962e309abb788019503cf9b8f36509]
```

For example: "awx-2022-12-27T04:01:58"

2) Double check the right host is enabled in ./inventory/hosts, then run the playbook:

`$ ansible-playbook -v -i ./inventory/hosts -e "borg_backup='awx-2022-12-27T04:01:58'" playbooks/restore_borg.yml`


## Recover AWX from a local dump with Ansible.

1) Collect the local tower-openshift-backup directory name from either the above script, the server itself, or AWX's 'Backup AWX [List Backups]' template:

"tower-openshift-backup-2022-12-24-11:43:33"

2) Run the restore_local playbook with this value:

`$ ansible-playbook -v -i ./inventory/hosts -e "awx_backup_directory='tower-openshift-backup-2022-12-24-11:43:33'" playbooks/restore_local.yml`


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
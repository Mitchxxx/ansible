#!/bin/bash
ansible-galaxy install -r roles/requirements.yml

echo $ANSIBLE_VAULT_PASSWORD >> .vault

ansible-playbook -i hosts_aws_ec2.yml site.yml --vault-password-file .vault

#avoids locally storing on a mounted volume
rm .vault
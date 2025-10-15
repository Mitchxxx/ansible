# Ansible Automation Project

A comprehensive Ansible automation project that demonstrates infrastructure provisioning, configuration management, and automated deployment across AWS and Azure cloud platforms.

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Prerequisites](#prerequisites)
- [Repository Structure](#repository-structure)
- [Getting Started](#getting-started)
- [Usage](#usage)
  - [Ad-hoc Commands](#ad-hoc-commands)
  - [Playbooks](#playbooks)
  - [Cloud Infrastructure Provisioning](#cloud-infrastructure-provisioning)
- [CI/CD Pipeline](#cicd-pipeline)
- [Docker Containers](#docker-containers)
- [Dynamic Inventory](#dynamic-inventory)
- [Configuration Management](#configuration-management)
- [Contributing](#contributing)

## 🎯 Overview

This project showcases Ansible automation capabilities including:
- Infrastructure as Code (IaC) for AWS and Azure
- Automated server configuration and deployment
- CI/CD integration with GitHub Actions
- Containerized Ansible environments
- Dynamic inventory management
- Web server (Nginx) deployment automation

## ✨ Features

- **Multi-Cloud Support**: Provision and manage infrastructure on both AWS and Azure
- **Automated Deployments**: Deploy and configure Nginx web servers automatically
- **Dynamic Inventories**: Auto-discover cloud resources using AWS EC2 and Azure RM plugins
- **CI/CD Integration**: Automated linting and deployment via GitHub Actions
- **Containerized Execution**: Run Ansible in Docker containers with all dependencies pre-installed
- **Security**: Ansible Vault integration for sensitive data encryption

## 📦 Prerequisites

- **Ansible**: Version 2.9.12 or higher
- **Python**: Python 3.x with pip
- **Cloud Accounts**: 
  - AWS account with API credentials
  - Azure account with service principal (optional)
- **SSH Access**: SSH key pair or password authentication for target hosts
- **Docker**: For containerized execution (optional)

### Required Python Packages

For AWS:
```bash
pip3 install ansible==2.9.12
pip3 install boto boto3
pip3 install pywinrm>=0.3.0
pip3 install ansible-lint
```

For Azure:
```bash
pip3 install ansible==2.9.12
pip3 install ansible[azure]
pip3 install pywinrm>=0.3.0
```

## 📂 Repository Structure

```
.
├── AWS/                          # AWS-specific playbooks and configurations
│   ├── Dockerfile               # Docker image for AWS Ansible execution
│   ├── aws_create_vpc.yaml      # Creates VPC with subnets and networking
│   ├── aws_create_linux_ec2_instance.yaml    # Provisions Linux EC2 instances
│   ├── aws_create_windows_ec2_instance.yaml  # Provisions Windows EC2 instances
│   ├── aws_delete_ansible_env.yaml           # Cleanup AWS resources
│   └── ping.yaml                # Test connectivity to AWS instances
│
├── Azure/                        # Azure-specific playbooks and configurations
│   ├── Dockerfile               # Docker image for Azure Ansible execution
│   ├── azure_create_resource_group.yaml     # Creates Azure resource group
│   ├── azure_create_linux_vm.yaml           # Provisions Linux VMs
│   ├── azure_create_windows_vm.yaml         # Provisions Windows VMs
│   ├── azure_delete_ansible_env.yaml        # Cleanup Azure resources
│   └── ping.yaml                # Test connectivity to Azure VMs
│
├── .github/                      # GitHub Actions workflows and custom actions
│   ├── workflows/
│   │   ├── deploy_ansible.yml   # Automated deployment pipeline
│   │   └── lint.yml             # Ansible linting workflow
│   └── actions/ansible/         # Custom GitHub Action for Ansible
│       ├── Dockerfile
│       ├── action.yml
│       └── entrypoint.sh
│
├── group_vars/                   # Group variable definitions
│   └── linux.yml                # Variables for Linux hosts (with Vault encryption)
│
├── roles/                        # Ansible roles directory
│   └── requirements.yml         # Galaxy role requirements
│
├── hosts.yml                     # Static inventory file
├── hosts_aws_ec2.yml            # AWS EC2 dynamic inventory configuration
├── hosts_azure_rm.yml           # Azure RM dynamic inventory configuration
├── site.yml                     # Main playbook orchestrator
├── ping.yml                     # Basic connectivity test playbook
├── configure_nginx_web_server.yml   # Nginx installation and configuration
├── index.html                   # Custom web page for Nginx
├── ansible.sh                   # Simple Ansible execution script
├── ad-hoc-ansible.md            # Ad-hoc command examples
└── README.md                    # This file
```

## 🚀 Getting Started

### 1. Clone the Repository

```bash
git clone https://github.com/Mitchxxx/ansible.git
cd ansible
```

### 2. Install Dependencies

```bash
# Install Ansible
pip3 install ansible==2.9.12

# For AWS support
pip3 install boto boto3

# For Azure support
pip3 install ansible[azure]
```

### 3. Configure Cloud Credentials

**For AWS:**
```bash
export AWS_ACCESS_KEY_ID='your-access-key'
export AWS_SECRET_ACCESS_KEY='your-secret-key'
```

**For Azure:**
```bash
az login
# Or configure service principal credentials
```

### 4. Set Up Ansible Vault (Optional)

```bash
# Create vault password file
echo "your-vault-password" > .vault

# Encrypt sensitive data
ansible-vault encrypt_string 'your-secret-password' --name 'ansible_password'
```

## 💻 Usage

### Ad-hoc Commands

Ad-hoc commands are single-task Ansible commands for quick operations:

```bash
# Test local connectivity
ansible localhost -m ping

# Gather facts from all hosts
ansible all -i hosts.yml -m setup

# Check disk space on Linux hosts
ansible linux -i hosts.yml -m shell -a "df -h"
```

For more examples, see [ad-hoc-ansible.md](ad-hoc-ansible.md)

### Playbooks

#### Test Connectivity

```bash
# Test local connection
ansible-playbook ping.yml

# Test AWS EC2 instances
ansible-playbook -i hosts_aws_ec2.yml AWS/ping.yaml

# Test Azure VMs
ansible-playbook -i hosts_azure_rm.yml Azure/ping.yaml
```

#### Deploy Nginx Web Server

```bash
# Deploy to all Linux hosts in static inventory
ansible-playbook -i hosts.yml configure_nginx_web_server.yml

# Deploy using dynamic AWS inventory
ansible-playbook -i hosts_aws_ec2.yml site.yml --vault-password-file .vault
```

### Cloud Infrastructure Provisioning

#### AWS Infrastructure

**Create VPC and Networking:**
```bash
ansible-playbook AWS/aws_create_vpc.yaml
```

**Provision Linux EC2 Instance:**
```bash
ansible-playbook AWS/aws_create_linux_ec2_instance.yaml
```
This playbook will:
- Create VPC, subnet, internet gateway, and routing tables
- Set up security groups (SSH on port 22, HTTP on port 80)
- Generate EC2 key pair
- Launch EC2 instance with user data script
- Associate Elastic IP address

**Provision Windows EC2 Instance:**
```bash
ansible-playbook AWS/aws_create_windows_ec2_instance.yaml
```

**Cleanup AWS Resources:**
```bash
ansible-playbook AWS/aws_delete_ansible_env.yaml
```

#### Azure Infrastructure

**Create Resource Group:**
```bash
ansible-playbook Azure/azure_create_resource_group.yaml
```

**Provision Linux VM:**
```bash
ansible-playbook Azure/azure_create_linux_vm.yaml
```
This playbook will:
- Create virtual network and subnet
- Configure public IP with DNS label
- Set up network security group (SSH and HTTP/HTTPS)
- Create network interface
- Deploy Ubuntu VM
- Configure sudo access via VM extension

**Provision Windows VM:**
```bash
ansible-playbook Azure/azure_create_windows_vm.yaml
```

**Cleanup Azure Resources:**
```bash
ansible-playbook Azure/azure_delete_ansible_env.yaml
```

## 🔄 CI/CD Pipeline

The project includes GitHub Actions workflows for automated testing and deployment:

### Ansible Lint Workflow

Automatically lints all playbooks on push and pull requests:

```yaml
# Triggered on: push, pull_request
# Action: Validates Ansible syntax and best practices
```

### Deployment Workflow

Automatically deploys to AWS EC2 instances on push to main branch:

```yaml
# Triggered on: push to main, pull requests to main
# Steps:
#   1. Checkout code
#   2. Run custom Ansible action
#   3. Execute playbooks with vault password
#   4. Deploy to AWS EC2 instances
```

**Required Secrets:**
- `ANSIBLE_VAULT_PASSWORD`: Password for decrypting Ansible Vault
- `AWS_ACCESS_KEY_ID`: AWS access key
- `AWS_SECRET_ACCESS_KEY`: AWS secret key

## 🐳 Docker Containers

Pre-configured Docker images are available for running Ansible with all dependencies:

### AWS Container

```bash
cd AWS
docker build -t ansible-aws .
docker run -it \
  -e AWS_ACCESS_KEY_ID='your-key' \
  -e AWS_SECRET_ACCESS_KEY='your-secret' \
  -v $(pwd):/ansible \
  ansible-aws bash
```

**Includes:**
- Ubuntu base image
- Ansible 2.9.12
- AWS CLI tools
- boto/boto3 libraries
- SSH client and sshpass
- pywinrm for Windows management

### Azure Container

```bash
cd Azure
docker build -t ansible-azure .
docker run -it \
  -v $(pwd):/ansible \
  ansible-azure bash
```

**Includes:**
- Ubuntu base image
- Ansible 2.9.12
- Azure CLI
- Ansible[azure] package
- SSH client and sshpass
- pywinrm for Windows management

## 📊 Dynamic Inventory

### AWS EC2 Dynamic Inventory

The `hosts_aws_ec2.yml` file configures dynamic inventory for AWS:

```yaml
plugin: aws_ec2
regions:
  - eu-west-1
filters:
  tag:app: ansible
groups:
  linux: "'linux' in tags.Name"
```

**Usage:**
```bash
# List discovered hosts
ansible-inventory -i hosts_aws_ec2.yml --list

# Use in playbooks
ansible-playbook -i hosts_aws_ec2.yml site.yml
```

### Azure RM Dynamic Inventory

The `hosts_azure_rm.yml` file configures dynamic inventory for Azure:

```yaml
plugin: azure_rm
include_vm_resource_groups:
  - ansible
conditional_groups:
  linux: "'linux' in os_profile.system"
```

**Usage:**
```bash
# List discovered hosts
ansible-inventory -i hosts_azure_rm.yml --list

# Use in playbooks
ansible-playbook -i hosts_azure_rm.yml site.yml
```

## ⚙️ Configuration Management

### Group Variables

Variables for host groups are defined in `group_vars/`:

**linux.yml:**
- `ansible_user`: SSH user for Linux hosts
- `ansible_password`: Encrypted with Ansible Vault
- `ansible_ssh_common_args`: SSH connection options

### Ansible Vault

Sensitive data is encrypted using Ansible Vault:

```bash
# Encrypt a file
ansible-vault encrypt group_vars/linux.yml

# Decrypt a file
ansible-vault decrypt group_vars/linux.yml

# Edit encrypted file
ansible-vault edit group_vars/linux.yml

# Run playbook with vault password
ansible-playbook site.yml --vault-password-file .vault
```

### Host Configuration

**Static Inventory (hosts.yml):**
```yaml
all:
  children:
    linux:
      hosts:
        ec2-3-254-19-200.eu-west-1.compute.amazonaws.com
        vm-linuxweb32.westeurope.cloudapp.azure.com
```

## 🤝 Contributing

Contributions are welcome! Please follow these guidelines:

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/your-feature`
3. **Make your changes** ensuring:
   - Ansible playbooks pass linting (`ansible-lint`)
   - Playbooks are idempotent
   - Sensitive data is encrypted with Ansible Vault
   - Documentation is updated
4. **Commit your changes**: `git commit -am 'Add new feature'`
5. **Push to the branch**: `git push origin feature/your-feature`
6. **Submit a pull request**

### Code Style

- Follow Ansible best practices
- Use YAML syntax with 2-space indentation
- Include meaningful task names
- Add comments for complex logic
- Use variables for values that may change

## 📝 License

This project is provided as-is for educational and demonstration purposes.

## 🔗 Useful Resources

- [Ansible Documentation](https://docs.ansible.com/)
- [Ansible Galaxy](https://galaxy.ansible.com/)
- [AWS Ansible Modules](https://docs.ansible.com/ansible/latest/collections/amazon/aws/)
- [Azure Ansible Modules](https://docs.ansible.com/ansible/latest/collections/azure/azcollection/)
- [Ansible Vault Guide](https://docs.ansible.com/ansible/latest/user_guide/vault.html)

---

**Note**: This repository demonstrates infrastructure automation and configuration management using Ansible. Ensure you review and understand all playbooks before executing them, especially those that provision cloud resources which may incur costs.

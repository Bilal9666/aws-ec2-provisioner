# Terraform EC2 Automation with EBS & Elastic IP

This Terraform project:

- Launches an EC2 instance
- Installs Nginx via user data
- Attaches a 5GB EBS volume
- Mounts it to /data
- Assigns a static Elastic IP
- Includes clean tags and scalable structure

## Requirements
- AWS CLI configured
- Terraform installed

## Usage

```bash
terraform init
terraform plan
terraform apply
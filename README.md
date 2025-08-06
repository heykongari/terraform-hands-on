# Terraform Infrastructure Provisioning

This repository contains modular and reusable Terraform configurations for provisioning cloud infrastructure on AWS. It demonstrates best practices in Infrastructure as Code (IaC) using Terraform, including support for modular design, variable configuration, and provisioning with `remote-exec`.

## Folder structure
```
📦terraform-infrastructure-provisioning
 ┣ 📂modules
 ┃ ┣ 📂ec2
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┗ 📜variables.tf
 ┃ ┗ 📂vpc
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┗ 📜variables.tf
 ┣ 📜LICENSE
 ┣ 📜README.md
 ┣ 📜main.tf
 ┣ 📜outputs.tf
 ┣ 📜terraform.tfvars
 ┗ 📜variables.tf
 ```

 ## Prerequisites
- [Terraform](https://developer.hashicorp.com/terraform/downloads) ≥ 1.0
- AWS CLI (`aws configure`)
- Active AWS account
- IAM user with necessary permissions

## Usage
### 1. Clone this Repository
```bash
git clone https://github.com/heykongari/terraform-infrastructure-provisioning.git
cd terraform-infrastructure-provisioning
```
### 2. Initialize Terraform
```bash
terraform init
```
### 3. Validate Infrastructure
```bash
terraform validate
```
### 4. Preview Changes
```bash
terraform plan
```
### 5. Apply Configuration and (optional) save output to file
```bash
terraform apply -auto-approve | tee output.txt
```
### 6. Destroy Infrastructure
```bash
terraform destroy -auto-approve
```
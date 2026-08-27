# Custom VPC with EC2 Web Server and RDS Database

A Terraform-based AWS networking project that builds a custom VPC, public EC2 web server, private RDS MySQL database, routing, security groups, and supporting IAM configuration.

## Architecture

```text
Internet
   |
   v
Internet Gateway
   |
   v
Public Subnet
   |
   v
EC2 Web Server
   |
   | TCP 3306
   v
Private Subnet
   |
   v
Amazon RDS MySQL
```

## What this project provisions

- Custom VPC with DNS support and hostnames enabled
- Public subnet for the EC2 web server
- Private subnet for the RDS database
- Internet Gateway and public route table
- EC2 Linux web server with a security group
- RDS MySQL database with a DB subnet group
- Restricted database access from the EC2 security group only
- Terraform-managed EC2 key pair generation
- Variables and outputs for reusable configuration
- GitHub Actions workflow for Terraform formatting and validation

## Security design

The EC2 instance is placed in a public subnet so it can be reached for administration and web access. The RDS database is private and is not publicly accessible. MySQL port 3306 is allowed to the database only from the EC2 security group.

For production use, restrict SSH to a trusted IP range, use AWS Systems Manager where practical, enable encryption, backups, deletion protection, and place application and database workloads across multiple Availability Zones.

## Repository structure

```text
.
├── main.tf
├── vpc.tf
├── ec2.tf
├── rds.tf
├── security_groups.tf
├── iam.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── terraform.tfvars.example
├── .gitignore
├── LICENSE
└── .github/workflows/terraform.yml
```

## Prerequisites

- Terraform >= 1.6
- AWS CLI
- An AWS account with permissions to create VPC, EC2, RDS and IAM resources
- AWS credentials configured locally

## Setup

```bash
git clone https://github.com/gauravkevolve-design/Custom-VPC-with-EC2-Web-Server-and-RDS-Database-.git
cd Custom-VPC-with-EC2-Web-Server-and-RDS-Database-
cp terraform.tfvars.example terraform.tfvars
```

Update `terraform.tfvars` with your own values. Never commit real passwords, private keys, Terraform state, or credential files.

## Deploy

```bash
terraform init
terraform fmt -recursive
terraform validate
terraform plan
terraform apply
```

After deployment:

```bash
terraform output
```

Use the EC2 public IP to test the server and the RDS endpoint from the EC2 host.

## Cleanup

```bash
terraform destroy
```

## Portfolio focus

This project demonstrates hands-on understanding of AWS VPC networking, subnet design, routing, EC2 provisioning, security-group relationships, database connectivity, and Infrastructure as Code with Terraform.

## Attribution

The architecture was informed by publicly available AWS/Terraform examples, including a public custom VPC + EC2 + RDS project. The implementation in this repository is independently organized and documented for portfolio and learning use.

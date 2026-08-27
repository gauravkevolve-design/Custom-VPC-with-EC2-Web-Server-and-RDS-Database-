# Architecture Notes

## Network layout

The project creates one custom VPC with a public web subnet and a private database subnet.

### Public tier

The public subnet hosts the EC2 web server. It has a route to the Internet Gateway and automatically receives a public IP address.

### Database tier

The private subnet hosts the RDS MySQL database. RDS is configured as `publicly_accessible = false` and receives MySQL traffic only from the EC2 security group.

## Request and database flow

1. A user sends HTTP traffic to the EC2 server public address.
2. The public route table sends Internet traffic through the Internet Gateway.
3. Nginx serves the web page from the EC2 instance.
4. Application/database clients on EC2 can connect to RDS on TCP 3306.
5. The RDS security group permits that connection only from the EC2 security group.

## Infrastructure lifecycle

```text
terraform init
      |
      v
terraform validate
      |
      v
terraform plan
      |
      v
terraform apply
      |
      v
AWS VPC + EC2 + RDS
```

Destroy temporary environments with `terraform destroy` when testing is complete.

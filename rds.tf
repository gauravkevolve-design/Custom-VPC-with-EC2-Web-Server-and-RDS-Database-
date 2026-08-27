resource "aws_db_subnet_group" "main" {
  name       = "custom-vpc-rds-subnets"
  subnet_ids = [aws_subnet.private.id]

  tags = {
    Name = "custom-vpc-rds-subnets"
  }
}

resource "aws_db_instance" "mysql" {
  identifier             = "custom-vpc-mysql"
  engine                 = "mysql"
  engine_version         = "8.0"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  max_allocated_storage  = 50
  db_name                = "applicationdb"
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  publicly_accessible    = false
  backup_retention_period = 7
  multi_az               = false
  storage_encrypted      = true
  skip_final_snapshot    = true

  tags = {
    Name = "custom-vpc-mysql"
  }
}

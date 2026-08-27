resource "aws_instance" "web" {
  ami                         = data.aws_ami.amazon_linux.id
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.ec2.id]
  key_name                    = aws_key_pair.ec2_key.key_name
  iam_instance_profile        = aws_iam_instance_profile.ec2_monitoring.name
  associate_public_ip_address = true

  user_data = <<-EOF
              #!/bin/bash
              dnf update -y
              dnf install -y nginx mysql
              systemctl enable --now nginx

              cat > /usr/share/nginx/html/index.html <<'HTML'
              <!doctype html>
              <html>
              <head><title>Custom VPC Web Server</title></head>
              <body>
                <h1>Custom VPC Web Server</h1>
                <p>EC2 web tier is running successfully.</p>
                <p>Database tier: Amazon RDS MySQL (private).</p>
              </body>
              </html>
              HTML
              EOF

  tags = {
    Name = "custom-vpc-web-server"
  }
}

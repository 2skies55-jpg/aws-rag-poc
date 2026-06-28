data "aws_ami" "amazon_linux" {

  most_recent = true

  owners = ["amazon"]

  filter {
    name = "name"

    values = ["al2023-ami-2023*-x86_64"]
  }

  filter {
    name = "state"

    values = ["available"]
  }
}

resource "aws_instance" "rag_server" {

  ami = data.aws_ami.amazon_linux.id

  instance_type = var.instance_type

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  iam_instance_profile = var.instance_profile_name

  associate_public_ip_address = true

  user_data = <<-EOF
#!/bin/bash

dnf update -y

dnf install docker git python3 -y

systemctl enable docker

systemctl start docker

usermod -aG docker ec2-user
EOF

  tags = {
    Name = "${var.project_name}-${var.environment}-ec2"
  }
}
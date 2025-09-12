locals {
  common_tags = {
    Prod = "terraform"
    Env  = "Prod_class-7"
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet" "default_public" {
  vpc_id     = data.aws_vpc.default.id
  cidr_block = "172.31.0.0/20"
}

resource "aws_security_group" "ingress_sg" {
  name        = "class-7_SG"
  vpc_id      = data.aws_vpc.default.id
  description = "Allows HTTP traffic to webpage"

  tags = merge(local.common_tags, {
    Name = "Lizzo-SG-class7"
  })

}

resource "aws_vpc_security_group_ingress_rule" "example" {
  security_group_id = aws_security_group.ingress_sg.id
  description       = "Allow http traffic to webapp"
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80

}


resource "aws_instance" "web" {
  ami                         = "ami-0b09ffb6d8b58ca91"
  instance_type               = "t3.micro"
  vpc_security_group_ids      = [aws_security_group.ingress_sg.id]
  subnet_id                   = data.aws_subnet.default_public.id
  associate_public_ip_address = true

  root_block_device {
    delete_on_termination = true
    volume_size           = 10
    volume_type           = "gp2"
  }

  lifecycle {
    create_before_destroy = true
  }
  user_data = file("${path.module}/file.txt")

  tags = merge(local.common_tags, {
    Name = "Class7-Lizzoing-01"
  })
}



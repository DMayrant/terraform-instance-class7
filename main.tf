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
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(local.common_tags, {
    Name = "Lizzo-SG-class7"
  })

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
  user_data = file("${path.module}/file.sh")

  tags = merge(local.common_tags, {
    Name = "Class7-Lizzoing-01"
  })
}



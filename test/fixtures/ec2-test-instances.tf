resource "aws_key_pair" "kitchen-test" {
  key_name   = "kitchen-wc-network-${formatdate("YYYYMMDDHHmmss", timestamp())}"
  public_key = file("${path.root}/${var.ssh_pub_key_path}")

  lifecycle {
    ignore_changes = [key_name]
  }
}

resource "aws_security_group" "allow-all" {
  name   = "kitchen-wc-network-${formatdate("YYYYMMDDHHmmss", timestamp())}"
  vpc_id = module.wc_network.vpc_id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "public" {
  count                       = length(module.wc_network.public_subnet_ids)
  subnet_id                   = module.wc_network.public_subnet_ids[count.index]
  ami                         = data.aws_ami.ubuntu-xenial.image_id
  vpc_security_group_ids      = [aws_security_group.allow-all.id]
  key_name                    = aws_key_pair.kitchen-test.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  tags                        = var.common_tags
}

resource "aws_instance" "private" {
  count                       = length(module.wc_network.private_subnet_ids)
  subnet_id                   = module.wc_network.private_subnet_ids[count.index]
  ami                         = data.aws_ami.ubuntu-xenial.image_id
  vpc_security_group_ids      = [aws_security_group.allow-all.id]
  key_name                    = aws_key_pair.kitchen-test.id
  associate_public_ip_address = true
  instance_type               = "t2.micro"
  tags                        = var.common_tags
}

data "aws_ami" "ubuntu-xenial" {
  most_recent = "true"
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name = "Name"
    values = ["more-recipes*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["753379358044"]
}

resource "aws_instance" "example" {
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "t2.micro"
  user_data     = "${file("userdata")}"
  key_name      = "admin-key-pair-candacentral"
  security_groups = ["sg_rules"]
  tags {
    Name = "More-recipes"
  }
}

output "ip" {
  value = "${aws_instance.example.public_dns}"
}

resource "aws_security_group" "sg_rules" {
  name         = "sg_rules"
  description  = "specify inbound traffic"

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks =  ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8000
    to_port   = 8000
    protocol  = "tcp"
    cidr_blocks =  ["41.215.245.118/32"]
  }

  ingress {
    from_port = 8000
    to_port   = 8000
    protocol  = "tcp"
    cidr_blocks =  ["169.239.188.10/32"]
  }
  
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks =  ["169.239.188.10/32"]
  }

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks =  ["41.215.245.118/32"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
}



provider "aws" {
  region = var.aws_region
}

data "aws_vpc" "default" {
  default = true
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_security_group"
  description = "Allow ssh and http"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Open to ssh to public
  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] #Open to ssh to public
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Allowsshhttp"
  }
}



resource "aws_instance" "my_ec2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  key_name               = "All"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
  #!/bin/bash
  sudo apt update -y
  sudo apt install nginx -y
  sudo systemctl start nginx
  sudo systemctl enable nginx

  sudo mkfs -t ext4/dev/xvdf
  sudo mkdir /data
  sudo mount /dev/xvdf/data

  echo '/dev/xvdf/data ext4 defaults,nofail 0 2'
  sudo tee -a/etc/fstab
  EOF

  root_block_device {
    volume_size = 16
    volume_type = "gp2"
  }

  tags = {
    Name       = "TerraformEc2"
    Environemt = "Dev"
    Owner      = "Bilal"
    Project    = "Ec2-Automation"
  }
}

resource "aws_eip" "my_eip" {
  instance = aws_instance.my_ec2.id
  domain   = "vpc"
}

resource "aws_ebs_volume" "extra_volume" {
  availability_zone = aws_instance.my_ec2.availability_zone
  size              = 5 #5Gb extra volume
  tags = {
    Name = "Terraformextravolume"
  }
}

resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/xvdf"
  volume_id   = aws_ebs_volume.extra_volume.id
  instance_id = aws_instance.my_ec2.id
}


provider "aws" {
  access_key = "access_key"
  secret_key = "secret_ke"
  region     = "us-east-1"
}

#EC2 Instance

resource "aws_instance" "everypixel_test" {
  ami             = "ami-07ebfd5b3428b6f4d"
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.allow_ssh.name}"]
  key_name        = aws_key_pair.pixel_key.key_name
  user_data       = file("./bootstrap.txt")
}


#Security Group

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "allow_ssh" {
  name   = "allow_ssh"
  vpc_id = aws_default_vpc.default.id


  ingress {
    description = "ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#SSH key

resource "aws_key_pair" "pixel_key" {
  key_name   = "pixel_key"
  public_key = "PUBLIC_KEY"
  }

#Elastic IP address

resource "aws_eip" "everypixel_test" {
  instance = aws_instance.everypixel_test.id
  vpc      = true
}


output "public_ip" {
  value = aws_eip.everypixel_test.public_ip
}

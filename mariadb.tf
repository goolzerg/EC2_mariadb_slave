provider "aws" {
  access_key = "AKIARGL4AXZWSRJZY34C"
  secret_key = "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"
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
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCDgZEiO3Spc4GOMl+oRvVvo9y6j6Ne5v+TaUmANXtZ4VE/B4tTwksvZvQ0opEW6MgFHM4D2dbOgZ/NQ8f1ZaTqM6XfSnktlkSWPUudTidGVtj9dWQGLt59kIw5CCwqoZtJLToQ9B7MicD9kWHop8V7r4Guy2ezEeQRzblESDJMy7jKc4Dj3MlM+EEzfOcMfHeeMfPCNKpTqOK1Pagr9PU6UCOiJncRs7tRINFwIi7rkFl3Owxjxtc8domw0e3oBX4S6RiN4Nj+B6iQOq3gSscGtmuNgLiTsNHIftBj3nKRn+q/nL/qyKrWwmwIuroWZSzTRKHPkYKVmIZun33tw/cj imported-openssh-key"
}

#Elastic IP address

resource "aws_eip" "everypixel_test" {
  instance = aws_instance.everypixel_test.id
  vpc      = true
}


output "public_ip" {
  value = aws_eip.everypixel_test.public_ip
}

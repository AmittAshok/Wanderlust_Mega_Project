resource "aws_key_pair" "master-key" {
  key_name   = "terra-key"
  public_key = file("/home/amitt-ashok/Work/ssh-key/my-ssh-key.pub")

}

resource "aws_default_vpc" "my-vpc" {

}

resource "aws_security_group" "wanderlust-sg" {
  name        = "Allow TLS"
  description = "Allow user to connect"
  vpc_id      = aws_default_vpc.my-vpc.id
  ingress {
    description = "allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "allow outgoing traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "port 80 allow"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "port 443 allow"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow redis port"
    from_port   = 6379
    to_port     = 6379
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow range of port"
    from_port   = 30000
    to_port     = 32767
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "allow port of SMTPS"
    from_port   = 465
    to_port     = 465
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow various port"
    from_port   = 3000
    to_port     = 10000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow smtp port"
    from_port   = 25
    to_port     = 25
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow kuberntes API server port"
    from_port   = 6443
    to_port     = 6443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "mysecurity"
  }
}

data "local_file" "installation" {
  filename = "/home/amitt-ashok/wanderlust_installation.sh"

}

resource "aws_instance" "wanderlust-ec2" {
  ami             = var.ami-id
  instance_type   = var.instance-type
  key_name        = aws_key_pair.master-key.key_name
  security_groups = [aws_security_group.wanderlust-sg.name]
  user_data       = data.local_file.installation.content
  tags = {
    Name = "automate"
  }
  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  /*connection {
     type = "ssh"
      user = "ubuntu"
      private_key = file(var.private_key-path)
      host = self.public_ip
    }
*/
}



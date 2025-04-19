provider "aws" {
  region = var.aws_region
}

resource "aws_key_pair" "devops_key" {
  key_name   = "devops-key"
  public_key = var.public_key  # Public key passed from GitHub secrets
}

resource "aws_security_group" "devops_sg" {
  name        = "devops-flask-blog-sg"
  description = "Allow SSH and Flask app traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 5000
    to_port     = 5000
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

resource "aws_instance" "devops_instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = aws_key_pair.devops_key.key_name
  vpc_security_group_ids      = [aws_security_group.devops_sg.id]

  tags = {
    Name = "DevOpsFlaskBlog"
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ubuntu"  # Ensure this is the correct username for your AMI
      private_key = var.ec2_ssh_private_key  # Private key passed securely
      host        = self.public_ip
    }

    inline = [
      "sudo apt update -y",
      "sudo apt install docker.io docker-compose -y",
      "sudo usermod -aG docker ubuntu"
    ]
  }
}

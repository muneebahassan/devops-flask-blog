variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-north-1"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "ec2_ssh_private_key" {
  description = "Private SSH key for EC2 access"
  type        = string
}

variable "public_key" {
  description = "Public SSH key content"
  type        = string
}


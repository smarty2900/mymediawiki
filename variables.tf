variable "region" {
  description = "The AWS region to deploy resources in."
  type        = string
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr" {
  description = "The CIDR block for the subnet."
  type        = string
  default     = "10.0.1.0/24"
}

variable "availability_zone" {
  description = "The availability zone for the subnet."
  type        = string
  default     = "us-east-1a"
}

variable "key_name" {
  description = "The key name to use for the EC2 instance."
  type        = string
}

variable "ami" {
  description = "The AMI to use for the EC2 instance."
  type        = string
  default     = "ami-0aedf6b1cb669b4c7"
}

variable "instance_type" {
  description = "The type of instance to use."
  type        = string
  default     = "t2.micro"
}

variable "ansible_playbook" {
  description = "The path to the Ansible playbook."
  type        = string
}

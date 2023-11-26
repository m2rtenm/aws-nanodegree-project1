# Core

variable "region" {
  description = "The AWS region to create resources in."
  default     = "eu-north-1"
}

# Networking

variable "vpc_cidr" {
  description = "CIDR Block for VPC"
  default     = "10.0.0.0/16"
}
variable "public_subnet_1_cidr" {
  description = "CIDR Block for Public Subnet 1"
  default     = "10.0.1.0/24"
}
variable "public_subnet_2_cidr" {
  description = "CIDR Block for Public Subnet 2"
  default     = "10.0.2.0/24"
}
variable "private_subnet_1_cidr" {
  description = "CIDR Block for Private Subnet 1"
  default     = "10.0.3.0/24"
}
variable "private_subnet_2_cidr" {
  description = "CIDR Block for Public Subnet 2"
  default     = "10.0.4.0/24"
}
variable "availability_zones" {
  description = "Availability zones"
  type        = list(string)
  default     = ["eu-north-1a", "eu-north-1b", "eu-north-1c"]
}

# Load balancer

variable "health_check_path" {
  description = "Health check path for the default target group"
  default     = "/"
}

variable "packer_ami" {
  description = "Which AMI to spawn."
  default = "ami-066eef06a1088db3a"
}
variable "instance_type" {
  default = "t3.micro"
}

variable "prefix" {
  description = "Prefix for all resources"
  default     = "aws-test"
}


# Auto scaling

variable "autoscale_min" {
  description = "Minimum autoscale (number of EC2)"
  default     = "3"
}
variable "autoscale_max" {
  description = "Maximum autoscale (number of EC2)"
  default     = "5"
}
variable "autoscale_desired" {
  description = "Desired autoscale (number of EC2)"
  default     = "4"
}
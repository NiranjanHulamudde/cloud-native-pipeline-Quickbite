variable "aws_region" {
  type = string
  default = "us-east-1"
  description = "Region for deployment"
}

variable  "project_name" {
  type = string
  default = "Quickbite"
  description = "Project name"
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
  description = "base IP range"
}

variable "public_subnet_cidrs" {
  type = list(string)
  default = [ "10.0.1.0/24", "10.0.2.0/24" ]
  description = "IP blocks for public subnets"
}

variable "private_subnet_cidrs" {
  type = list(string)
  default = [ "10.0.11.0/24", "10.0.12.0/24" ]
  description = "IP blocks for private subnets"
}



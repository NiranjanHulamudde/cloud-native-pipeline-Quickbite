terraform {
  required_version = ">=1.5.0"
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~>5.50.0"  # my terraform init was struggling to download 5.0 version hence i changed it to a specific version 
}
}
}
provider "aws" {
    region = var.aws_region
}
    

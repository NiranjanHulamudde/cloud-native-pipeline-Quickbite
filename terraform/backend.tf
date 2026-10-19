terraform {
  backend "s3" {
    bucket         = "terraform-backend-mine" 
    key            = "state/terraform.tfstate"
    region         = "us-east-1"
  }
}

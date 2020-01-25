provider "aws" {
  profile = "dimitrije"
  region  = "us-east-1"
  version = "~> 2.0"
}

terraform {
  backend "s3" {
    bucket = "manics-terraform-backend"
    key    = "core"
    region = "us-east-1"
  }
}

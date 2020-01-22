provider "aws" {
  profile = "dimitrije"
  region  = "us-east-1"
  version = "~> 2.0"
}

provider "cloudflare" {
  version = "~> 2.0"
  email   = "dimitrije@manics.ca"
  api_key = var.cloudflare_api_key
}

terraform {
  backend "s3" {
    bucket = "manics-terraform-backend"
    key    = "production"
    region = "us-east-1"
  }
}

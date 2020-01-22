locals {
  manics_bucket_name = "manics.ca"
}

# S3 Static website
resource "aws_s3_bucket" "manics" {
  bucket        = local.manics_bucket_name
  acl           = "public-read"
  force_destroy = true

  website {
    index_document = "index.html"
    error_document = "index.html"
  }

  policy = <<-POLICY
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "s3:GetObject",
        "Principal": "*",
        "Effect": "Allow",
        "Resource": [
            "arn:aws:s3:::${local.manics_bucket_name}/*"
        ]
      }
    ]
  }
POLICY

  tags = {
    environment = "production"
  }
}

# Cloudflare DNS
resource "cloudflare_record" "manics" {
  zone_id = var.cloudflare_zone_id
  name    = "manics.ca"
  value   = aws_s3_bucket.manics.website_endpoint
  type    = "CNAME"
  ttl     = 1 // Automatic
}

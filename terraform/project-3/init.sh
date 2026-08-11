#!/usr/bin/env bash
# esc bash - Terraform Project #3 setup
set -euo pipefail
mkdir -p /root/project-3
cat > /root/project-3/main.tf <<'EOF'
provider "aws" {
  region                      = "us-east-1"
  access_key                  = "mock_key"
  secret_key                  = "mock_secret"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  s3_use_path_style           = true
  endpoints {
    ec2 = "http://localhost:4566"
    s3  = "http://localhost:4566"
    ssm = "http://localhost:4566"
  }
}

locals {
  db_password = "Esc-Sup3r-S3cret"
}

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "esc-mono-vpc"
  }
}

resource "aws_subnet" "app" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_s3_bucket" "assets" {
  bucket = "esc-mono-assets"
}

resource "aws_s3_bucket" "logs" {
  bucket = "esc-mono-logs"
}

resource "aws_s3_bucket_policy" "assets" {
  bucket = aws_s3_bucket.assets.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid       = "AssetsRead"
        Effect    = "Allow"
        Principal = "*"
        Action    = "s3:GetObject"
        Resource  = "${aws_s3_bucket.assets.arn}/*"
      }
    ]
  })
}

output "db_password" {
  value     = local.db_password
  sensitive = true
}
EOF
aws s3api create-bucket --bucket esc-mono-legacy
aws s3api create-bucket --bucket esc-project-state
aws ssm put-parameter --name /mono/db_password --value Esc-Sup3r-S3cret --type SecureString --overwrite
cd /root/project-3 && terraform init && terraform apply -auto-approve
terraform show -json | jq '{
  vpc: (.values.root_module.resources[] | select(.address=="aws_vpc.main") | .values.id),
  subnet: (.values.root_module.resources[] | select(.address=="aws_subnet.app") | .values.id),
  assets_bucket: (.values.root_module.resources[] | select(.address=="aws_s3_bucket.assets") | .values.id),
  logs_bucket: (.values.root_module.resources[] | select(.address=="aws_s3_bucket.logs") | .values.id)
}' > .baseline-ids.json
echo "Project 3 ready. Monolith infrastructure bootstrapped in /root/project-3/"
echo "Baseline IDs captured in .baseline-ids.json"
echo "Refactor into modules, import click-ops bucket, migrate state to backend."

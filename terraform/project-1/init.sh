#!/usr/bin/env bash
# esc bash - Terraform Project #1 setup
set -euo pipefail
mkdir -p /root/project-1
cat > /root/project-1/providers.tf <<'EOF'
provider "aws" {
  region                      = "us-east-1"
  access_key                  = "mock_key"
  secret_key                  = "mock_secret"
  skip_credentials_validation = true
  skip_requesting_account_id  = true
  skip_metadata_api_check     = true
  s3_use_path_style           = true
  endpoints {
    s3 = "http://localhost:4566"
  }
}
EOF
echo "Project 1 ready. Provider configured at /root/project-1/providers.tf"
echo "Write variables.tf, main.tf with S3 buckets, and outputs.tf"

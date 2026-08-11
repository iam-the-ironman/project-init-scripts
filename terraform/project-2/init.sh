#!/usr/bin/env bash
# esc bash - Terraform Project #2 setup
set -euo pipefail
mkdir -p /root/project-2
cat > /root/project-2/providers.tf <<'EOF'
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
  }
}
EOF
echo "Project 2 ready. Provider configured at /root/project-2/providers.tf"
echo "Write variables.tf, network.tf, sg.tf, instances.tf, and bootstrap.sh"
echo "Use workspaces to manage dev and prod environments."

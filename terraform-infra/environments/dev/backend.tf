# =============================================================================
# S3 Backend Configuration for Remote State
# =============================================================================
# 
# This file configures Terraform to store state remotely in AWS S3 with
# DynamoDB for state locking. This enables team collaboration and prevents
# concurrent modifications.
#
# SETUP INSTRUCTIONS:
# 1. First, create the backend infrastructure by running:
#      cd ../backend-bootstrap
#      terraform init
#      terraform apply
#
# 2. After the backend infrastructure is created, uncomment the backend block
#    below and run:
#      terraform init -migrate-state
#
# 3. Type "yes" when prompted to migrate existing state
# =============================================================================

terraform {
  # S3 Backend for Remote State
  backend "s3" {
    bucket       = "goal-tracker-terraform-state"
    key          = "environments/dev/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
  }
}

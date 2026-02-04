# =============================================================================
# Terraform Backend Bootstrap
# =============================================================================
# This configuration creates the S3 bucket and DynamoDB table required for
# storing Terraform remote state.
#
# Run this ONCE before setting up the remote backend in other environments:
#   terraform init
#   terraform apply
#
# After this is created, you can enable the S3 backend in your environment
# configurations (e.g., environments/dev/backend.tf)
# =============================================================================

terraform {
  required_version = ">= 1.13"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.0"
    }
  }

  # This bootstrap uses local state - DO NOT use remote backend here!
}

provider "aws" {
  region = var.region

  default_tags {
    tags = {
      Project   = var.project
      ManagedBy = "terraform"
      Purpose   = "terraform-state-management"
    }
  }
}

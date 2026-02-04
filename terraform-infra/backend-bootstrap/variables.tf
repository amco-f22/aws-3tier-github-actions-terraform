# =============================================================================
# Variables for Backend Bootstrap
# =============================================================================

variable "region" {
  description = "AWS region for the backend resources"
  type        = string
  default     = "us-east-1"
}

variable "project" {
  description = "Project name used for naming resources"
  type        = string
  default     = "goal-tracker"
}

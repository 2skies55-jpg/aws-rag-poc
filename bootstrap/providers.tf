provider "aws" {
  region = var.aws_region

  default_tags {
    tags = {
      Project     = "aws-rag-poc"
      Environment = "bootstrap"
      ManagedBy   = "Terraform"
      Owner       = "2skies55-jpg"
    }
  }
}
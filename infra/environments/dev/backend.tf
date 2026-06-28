terraform {
  backend "s3" {
    bucket         = "mohit-rag-tf-state-334455667454"
    key            = "dev/terraform.tfstate"
    region         = "ap-south-1"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
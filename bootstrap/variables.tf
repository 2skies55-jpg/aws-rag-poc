variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "Terraform State Bucket"
  type        = string
}

variable "lock_table" {
  description = "Terraform Lock Table"
  type        = string
}
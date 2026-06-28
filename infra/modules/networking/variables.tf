variable "project_name" {
  description = "Project name"
  type        = string
}

variable "environment" {
  description = "Environment"
  type        = string
}

variable "vpc_cidr" {
  description = "VPC CIDR"
  type        = string
}

variable "public_subnet_1_cidr" {
  description = "Public subnet 1"
  type        = string
}

variable "public_subnet_2_cidr" {
  description = "Public subnet 2"
  type        = string
}

variable "availability_zone_1" {
  description = "AZ 1"
  type        = string
}

variable "availability_zone_2" {
  description = "AZ 2"
  type        = string
}
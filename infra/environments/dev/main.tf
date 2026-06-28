module "networking" {

  source = "../../modules/networking"

  project_name = var.project_name
  environment  = var.environment

  vpc_cidr = "10.0.0.0/16"

  public_subnet_1_cidr = "10.0.1.0/24"
  public_subnet_2_cidr = "10.0.2.0/24"

  availability_zone_1 = "ap-south-1a"
  availability_zone_2 = "ap-south-1b"
}

module "iam" {

  source = "../../modules/iam"

  project_name = var.project_name
  environment  = var.environment
}

module "security" {

  source = "../../modules/security"

  project_name = var.project_name
  environment  = var.environment

  vpc_id = module.networking.vpc_id
}


module "ec2" {

  source = "../../modules/ec2"

  project_name = var.project_name
  environment  = var.environment

  subnet_id = module.networking.public_subnet_1

  security_group_id = module.security.security_group_id

  instance_profile_name = module.iam.instance_profile_name
}
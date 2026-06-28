output "vpc_id" {
  value = module.networking.vpc_id
}

output "public_subnet_1" {
  value = module.networking.public_subnet_1
}

output "public_subnet_2" {
  value = module.networking.public_subnet_2
}

output "instance_profile_name" {
  value = module.iam.instance_profile_name
}

output "iam_role_name" {
  value = module.iam.role_name
}


output "security_group_id" {
  value = module.security.security_group_id
}

output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}
provider "aws" {
    region = var.aws_region
}

module "vpc" {
    source = "./modules/vpc"
    vpc_cidr = var.vpc_cidr
    subnet_cidr = var.subnet_cidr
    az = var.az
}

module "ec2" {
    source = "./modules/ec2"
    ami_id = var.ami_id
    instance_type = var.instance_type
    key_name = var.key_name
    vpc_id = module.vpc.vpc_id
    subnet_id = module.vpc.subnet_id
}
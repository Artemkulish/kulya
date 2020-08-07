provider "aws" {
    region = var.region
    access_key = var.aws_access_key
    secret_key = var.aws_secret_key
}

module "aws_network" {
    source = "./modules/aws_network"
}

module "aws_ec2_instance" {
    source = "./modules/ec2_instance"

    public_subnet_id = module.aws_network.public_subnet_id
    private_subnet_id = module.aws_network.private_subnet_id
    security_group_name = module.aws_network.security_group_name
}
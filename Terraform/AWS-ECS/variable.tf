variable "region" {
    description = "AWS region"
    default = "eu-central-1"
}

variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "cidr_block" {
    description = "Main VPC CIDR"
    default = "10.0.0.0/27"
}

variable "http" {
    default = "80"
}

variable "https" {
    default = "443"
}

variable "cpu" {
    description = "Fargate CPU"
    default = "512"
}

variable "memory" {
    description = "Fargate RAM"
    default = "1024"
}

variable "docker_image" {
    description = "Docker image of the application to be started on AWS Fargate"
    default = "artemkulish/zone3000:nodejs"
}

variable "instances" {
    description = "Number of instances to be launched by AWS Fargate"
    default = "4"
}

variable "domain" {
    default = "svagworks.me"
}
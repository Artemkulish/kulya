output "ssl_common_name" {
    value = aws_acm_certificate.nodejs-certificate.domain_name
}

output "nat_public_ip" {
    value = aws_nat_gateway.kulya.public_ip
}

output "number_of_instances" {
    value = aws_ecs_service.kulya.desired_count
}

output "domain_nameservers" {
    value = aws_route53_zone.kulya.name_servers
}

output "load_balancer_dns_name" {
    value = aws_alb.kulya.dns_name
}
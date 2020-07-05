output "public_subnet_id" {
    value = aws_subnet.public.id
}

output "private_subnet_id" {
    value = aws_subnet.private.id
}

output "security_group_name" {
    value = aws_security_group.Zone3000
}
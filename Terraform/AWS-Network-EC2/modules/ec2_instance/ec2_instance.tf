resource "aws_key_pair" "ssh_key" {
 key_name = var.ssh_key
 public_key = "${file("./modules/ec2_instance/key.pub")}"
}

resource "aws_instance" "public" {
 ami = "ami-0d359437d1756caa8"
 instance_type = "t2.micro"
 subnet_id = var.public_subnet_id
 vpc_security_group_ids = [var.security_group_name.id]
 key_name = var.ssh_key
 associate_public_ip_address = true
 count = 2

 tags = {
     Name = "Public-${count.index + 1}"
 }

 depends_on = [
     aws_key_pair.ssh_key,
     var.security_group_name
 ]
}

resource "aws_instance" "private" {
 ami = "ami-0d359437d1756caa8"
 instance_type = "t2.micro"
 subnet_id = var.private_subnet_id
 vpc_security_group_ids = [var.security_group_name.id]
 key_name = var.ssh_key
 associate_public_ip_address = true

 tags = {
     Name = "Private"
 }

 depends_on = [
     aws_key_pair.ssh_key,
     var.security_group_name
 ]
}
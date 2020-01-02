provider "aws" {
 access_key = "AKIA4FVVGUX652VUOVTT"
 secret_key = "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"
 region = "eu-central-1"
}
resource "aws_instance" "aws" {
 ami = "ami-0cc0a36f626a4fdf5"
 key_name   = "${aws_key_pair.ssh_key.key_name}"
 instance_type = "t2.micro"
}
resource "aws_key_pair" "ssh_key" {
 key_name = "ssh_key"
 public_key = "${file("/home/artemkulish123/.ssh/some.pub")}"
}
data "aws_security_group" "default" {
 name = "default"
}
resource "aws_security_group_rule" "allow_ssh" {
    type = "ingress"
    from_port = "22"
    to_port = "22"
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = "${data.aws_security_group.default.id}"
}

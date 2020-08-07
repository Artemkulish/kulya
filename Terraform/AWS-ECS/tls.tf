resource "aws_acm_certificate" "nodejs-certificate" {
  private_key       = "${file("./ssl/nodejs.key")}"
  certificate_body  = "${file("./ssl/nodejs.crt")}"
  certificate_chain = "${file("./ssl/nodejs.ca-bundle")}"
  
  tags = {
    Name = "SSL for nodejs.svagworks.me"
  }
}
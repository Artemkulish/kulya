resource "aws_route53_zone" "kulya" {
  name = var.domain
}

resource "aws_route53_record" "nodejs" {
  zone_id   = "${aws_route53_zone.kulya.zone_id}"
  name      = "nodejs.${data.aws_route53_zone.kulya.name}"
  type      = "A"
  alias {
    name    = aws_alb.kulya.dns_name
    zone_id = aws_alb.kulya.zone_id
  }
}
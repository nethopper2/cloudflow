# #setup a weight (total 100) between prod.mynethopper.net and canary.mynethopper.net
# # change the xxxx below, and then terraform apply to make the switch

provider "aws" {
  shared_credentials_file = "aws-creds.ini"

}

resource "aws_route53_record" "${var.primary-name}-CNAME" {
  zone_id = "Z0099474UE6G1A66LZAQ"
  name    = var.active-url 
  type    = "CNAME"
  ttl     = 5
  weighted_routing_policy {
    weight = var.primary-weight
  }
  set_identifier = var.primary-name 
  records        = [var.primary-url]
}

resource "aws_route53_record" "${var.canary-name}-CNAME" {
  zone_id = "Z0099474UE6G1A66LZAQ"
  name    = var.active-url 
  type    = "CNAME"
  ttl     = 5
  weighted_routing_policy {
    weight = var.canary-weight
  }
  set_identifier = var.canary-name 
  records        = [var.canary-url]
}

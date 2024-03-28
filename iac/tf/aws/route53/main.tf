# #setup a weight (total 100) between prod.mynethopper.net and canary.mynethopper.net
# # change the xxxx below, and then terraform apply to make the switch

provider "aws" {
  region = var.region
  
  # in-cluster tf (e.g. crossplane)
  shared_credentials_files = ["aws-creds.ini"]

  # local tf
  #shared_credentials_files = ["/home/ddonahue/.aws/credentials"]
}

#
# in-cluster tf
#   - both provider & terraform blocks
#
provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
}

terraform {
  backend "kubernetes" {
    secret_suffix     = "providerconfig-default"
    namespace         = "nethopper"
    in_cluster_config = true
  }
}

#
# local tf
#
#terraform {
#  backend "local" {
#  }
#}


#
# primary cluster
# 
resource "aws_route53_record" "primary-A" {
  zone_id = "Z0099474UE6G1A66LZAQ"
  name    = var.active-url 
  type    = "A"
  ttl     = var.primary-ttl
 
  weighted_routing_policy {
    weight = var.primary-weight
  }
 
  set_identifier = var.primary-name 
  records        = [var.primary-ipv4]
}

#
# canary cluster
#
resource "aws_route53_record" "canary-A" {
  zone_id = "Z0099474UE6G1A66LZAQ"
  name    = var.active-url 
  type    = "A"
  ttl     = var.canary-ttl
 
  weighted_routing_policy {
    weight = var.canary-weight
  }
 
  set_identifier = var.canary-name 
  records        = [var.canary-ipv4]
}

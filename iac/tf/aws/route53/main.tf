# #setup a weight (total 100) between prod.mynethopper.net and canary.mynethopper.net
# # change the xxxx below, and then terraform apply to make the switch

provider "aws" {
  region = "us-east-2"
  
  # in-cluster tf (e.g. crossplane)
  shared_credentials_files = ["aws-creds.ini"]

  # local tf
  #shared_credentials_files = ["/home/ddonahue/.aws/credentials"]
}

#
# in-cluster tf
#   - both provider & terraform blocks
#
#provider "kubernetes" {
#  host                   = module.eks.cluster_endpoint
#  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
#}

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
  name    = "*.prod.mynethopper.net"
  type    = "A"
  ttl     = 10
 
  weighted_routing_policy {
    weight = 50
  }
 
  set_identifier = "primary" 
  records        = ["212.75.106.21"]
}

#
# canary cluster
#
resource "aws_route53_record" "canary-A" {
  zone_id = "Z0099474UE6G1A66LZAQ"
  name    = "*.prod.mynethopper.net"
  type    = "A"
  ttl     = 10
 
  weighted_routing_policy {
    weight = 0
  }
 
  set_identifier = "canary" 
  records        = ["212.75.106.22"]
}

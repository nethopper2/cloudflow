variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}
variable "active-url" {
  description = "Active CNAME for canary pair"
  type        = string
  default     = "active.mynethopper.net"
}

variable "primary-name" {
  description = "Primary cluster sub-domain name"
  type        = string
  default     = "primary"
}

variable "primary-ipv4" {
  description = "Primary cluster IP Address"
  type        = string
  default     = "73.47.158.209"
}

variable "primary-weight" {
  description = "Primary cluster LB weight"
  type        = number 
  default     = 1
}

variable "primary-ttl" {
  description = "Primary cluster DNL TTL"
  type        = number 
  default     = 10
}

variable "canary-name" {
  description = "Canary cluster sub-domain name"
  type        = string
  default     = "canary"
}

variable "canary-ipv4" {
  description = "Canary cluster IP Address"
  type        = string
  default     = "73.147.158.207"
}

variable "canary-weight" {
  description = "Canary cluster LB weight"
  type        = number 
  default     = 0
}

variable "canary-ttl" {
  description = "Canary cluster DNL TTL"
  type        = number 
  default     = 10
}





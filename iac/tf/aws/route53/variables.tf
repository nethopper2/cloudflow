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

variable "primary-url" {
  description = "Primary cluster URL"
  type        = string
  default     = "primary.mynethopper.net"
}

variable "primary-weight" {
  description = "Primary cluster LB weight"
  type        = number 
  default     = 1
}

variable "canary-name" {
  description = "Canary cluster sub-domain name"
  type        = string
  default     = "canary"
}

variable "canary-url" {
  description = "Canary cluster URL"
  type        = string
  default     = "canary.mynethopper.net"
}

variable "canary-weight" {
  description = "Canary cluster LB weight"
  type        = number 
  default     = 0
}





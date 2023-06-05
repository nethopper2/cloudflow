variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "cluster-name-suffix" {
  description = "Cluster name suffix"
  type        = string
  default     = "eks"
}

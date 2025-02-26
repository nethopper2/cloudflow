variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-2"
}

variable "cluster-name" {
  description = "Cluster name"
  type        = string
  default     = "eks-hub"
}

variable "k8s-version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.29"
}

variable "aws-cli-profile" {
  description = "AWS CLI profile"
  type        = string
  default     = "default"
}

variable "instance-type" {
  description = "Instance type"
  type        = string
  default     = "m5.2xlarge"
}
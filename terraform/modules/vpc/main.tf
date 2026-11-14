terraform {
  required_version = ">= 1.5.0"
}

variable "vpc_name" {
  type        = string
  description = "Name identifier for the OENEXA Virtual Private Cloud"
  default     = "oenexa-vpc-prod"
}

variable "cidr_block" {
  type        = string
  description = "Primary IPv4 CIDR block"
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  type        = list(string)
  description = "Target availability zones"
  default     = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
}

output "vpc_id" {
  value       = "vpc-oenexa-prod-01"
  description = "The ID of the provisioned secure VPC"
}

output "public_subnet_ids" {
  value       = ["subnet-pub-1a", "subnet-pub-1b", "subnet-pub-1c"]
  description = "Public ingress subnets for edge Caddy / Cloudflare load balancers"
}

output "private_microservice_subnet_ids" {
  value       = ["subnet-app-1a", "subnet-app-1b", "subnet-app-1c"]
  description = "Private subnets for Kubernetes cluster worker nodes"
}

output "isolated_data_subnet_ids" {
  value       = ["subnet-data-1a", "subnet-data-1b", "subnet-data-1c"]
  description = "Isolated subnets for PostgreSQL and Redis with zero internet access"
}

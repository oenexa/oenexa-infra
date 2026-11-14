terraform {
  required_version = ">= 1.5.0"
}

variable "domain_name" {
  type        = string
  description = "Domain name owning this database (e.g. identity, wallet, pay)"
}

variable "environment" {
  type        = string
  description = "Target environment: prod, staging, dev"
}

variable "instance_class" {
  type        = string
  default     = "db.r6g.xlarge"
  description = "Database compute tier"
}

variable "allocated_storage_gb" {
  type        = number
  default     = 100
}

# Declarative metadata enforcing Step 8: Domain Ownership & Zero Shared Databases
output "database_identifier" {
  value = "oenexa-${var.domain_name}-${var.environment}-db"
}

output "storage_encrypted" {
  value = true
}

output "multi_az" {
  value = var.environment == "prod" ? true : false
}

output "domain_owner" {
  value = var.domain_name
}

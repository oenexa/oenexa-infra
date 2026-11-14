terraform {
  required_version = ">= 1.5.0"
}

variable "cluster_name" {
  type        = string
  description = "Name of the OENEXA Kubernetes cluster"
  default     = "oenexa-core-prod-k8s"
}

variable "kubernetes_version" {
  type        = string
  description = "Target Kubernetes minor release"
  default     = "1.31"
}

variable "vpc_id" {
  type        = string
  description = "VPC ID where the cluster is deployed"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Subnet IDs for worker node placement"
}

output "cluster_endpoint" {
  value       = "https://k8s.internal.oenexa.com"
  description = "Internal control plane API endpoint"
}

output "cluster_certificate_authority_data" {
  value       = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCg=="
  description = "Base64 encoded certificate data required to communicate with the cluster"
  sensitive   = true
}

output "node_pools" {
  value = {
    system_pool = {
      instance_type = "c6i.xlarge"
      node_count    = 3
      role          = "ingress-and-core-system"
    }
    fintech_engine_pool = {
      instance_type = "c6i.4xlarge"
      node_count    = 6
      role          = "low-latency-matching-and-settlement"
    }
    ai_swarm_pool = {
      instance_type = "g5.2xlarge"
      node_count    = 2
      role          = "vector-rag-and-agent-inference"
    }
  }
}

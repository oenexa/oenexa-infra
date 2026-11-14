terraform {
  required_version = ">= 1.5.0"
}

module "dns_records" {
  source            = "../../modules/cloudflare-dns"
  zone_id           = "mock_prod_cloudflare_zone_id"
  primary_origin_ip = "62.210.92.60"
}

# Production VPC Network Segmentation
module "production_vpc" {
  source   = "../../modules/vpc"
  vpc_name = "oenexa-vpc-prod"
}

# Production Kubernetes Cluster
module "production_k8s" {
  source     = "../../modules/kubernetes"
  cluster_name = "oenexa-core-prod-k8s"
  vpc_id     = module.production_vpc.vpc_id
  subnet_ids = module.production_vpc.private_microservice_subnet_ids
}

# Domain 1: Identity DB (Isolated)
module "identity_db" {
  source      = "../../modules/database-postgres"
  domain_name = "identity"
  environment = "prod"
}

# Domain 2: Wallet DB (Isolated)
module "wallet_db" {
  source      = "../../modules/database-postgres"
  domain_name = "wallet"
  environment = "prod"
}

# Domain 3: Pay DB (Isolated)
module "pay_db" {
  source      = "../../modules/database-postgres"
  domain_name = "pay"
  environment = "prod"
}

# Domain 4: Exchange DB (Isolated)
module "exchange_db" {
  source      = "../../modules/database-postgres"
  domain_name = "exchange"
  environment = "prod"
}

# Domain 5: OENGO DB (Isolated)
module "oengo_db" {
  source      = "../../modules/database-postgres"
  domain_name = "oengo"
  environment = "prod"
}

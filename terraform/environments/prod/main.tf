terraform {
  required_version = ">= 1.5.0"
}

module "dns_records" {
  source            = "../../modules/cloudflare-dns"
  zone_id           = "mock_prod_cloudflare_zone_id"
  primary_origin_ip = "62.210.92.60"
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

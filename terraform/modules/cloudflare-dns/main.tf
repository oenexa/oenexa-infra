terraform {
  required_version = ">= 1.5.0"
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.0"
    }
  }
}

variable "zone_id" {
  type        = string
  description = "Cloudflare Zone ID for oenexa.com"
}

variable "primary_origin_ip" {
  type        = string
  description = "Primary edge origin IP (e.g. 62.210.92.60)"
  default     = "62.210.92.60"
}

locals {
  canonical_a_records = [
    "@",         # oenexa.com
    "www",       # www.oenexa.com
    "app",       # app.oenexa.com (Unified Portal)
    "id",        # id.oenexa.com (Identity & Auth)
    "api",       # api.oenexa.com (Public API Gateway)
    "ai",        # ai.oenexa.com (AI Studio)
    "explorer",  # explorer.oenexa.com (L1 Explorer)
    "rpc",       # rpc.oenexa.com (L1 JSON-RPC)
    "admin",     # admin.oenexa.com (Admin Console)
    "docs",      # docs.oenexa.com (Developer Documentation)
    "exchange",  # Vanity redirect -> app.oenexa.com/exchange
    "trade",     # Vanity redirect -> app.oenexa.com/trade
    "wallet",    # Vanity redirect -> app.oenexa.com/wallet
    "coin",      # Vanity redirect -> oenexa.com/coins
  ]
}

resource "cloudflare_record" "canonical_subdomains" {
  for_each = toset(locals.canonical_a_records)

  zone_id = var.zone_id
  name    = each.value
  value   = var.primary_origin_ip
  type    = "A"
  proxied = true
  ttl     = 1 # Auto
}

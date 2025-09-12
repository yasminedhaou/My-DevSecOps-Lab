terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 3.0"
    }
  }
  required_version = ">= 1.0"
}

# Provider Vault
provider "vault" { }

# Lecture des secrets Azure dans Vault (KV v2)
data "vault_kv_secret_v2" "azure" {
  mount = "secret"   # Le chemin où ton KV est monté dans Vault
  name  = "azure"    # Chemin du secret, ex: secret/data/azure
}

# Lecture des secrets Jenkins dans Vault (KV v2)
data "vault_kv_secret_v2" "jenkins" {
  mount = "secret"
  name  = "jenkins"
}

# Provider Azure avec subscription_id depuis Vault
provider "azurerm" {
  subscription_id = data.vault_kv_secret_v2.azure.data["subscription_id"]

  features {}   # ✅ bloc vide correct
}

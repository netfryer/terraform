#-----------------------------------------------------------------------------------------------------------------
# Create storage account and file share for bootstrapping

resource "azurerm_storage_account" "main" {
  name                     = "${var.rg_target}-st-01"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  location                 = var.location
  resource_group_name      = var.rg_target
}

module "common_fileshare" {
  source               = "./modules/azure_bootstrap/"
  name                 = "${var.fw_prefix}-bootstrap"
  quota                = 1
  storage_account_name = azurerm_storage_account.main.name
  storage_account_key  = azurerm_storage_account.main.primary_access_key
  local_file_path      = "bootstrap_files/"
}
  

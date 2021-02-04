#-----------------------------------------------------------------------------------------------------------------
# Create storage account and file share for bootstrapping

resource "azurerm_storage_account" "main" {
  name                     = "${var.rg_target}-st-01"
  account_tier             = "Standard"
  account_replication_type = "LRS"
  location                 = azurerm_resource_group.common_fw.location
  resource_group_name      = azurerm_resource_group.common_fw.name
}

module "common_fileshare" {
  source               = "./modules/azure_bootstrap/"
  name                 = "${var.fw_prefix}-bootstrap"
  quota                = 1
  storage_account_name = azurerm_storage_account.main.name
  storage_account_key  = azurerm_storage_account.main.primary_access_key
  local_file_path        = "bootstrap_files/"
}

#-----------------------------------------------------------------------------------------------------------------
# Create Vnet
  
module "vnet" {
  source              = "./modules/vnet/"
  name                = "${var.rg_target}-vnet-01"
  address_space       = var.vnet_cidr
  subnet_names        = var.subnet_names
  subnet_prefixes     = var.subnet_cidrs
  location            = var.location
  resource_group_name = var.rg_target

#-----------------------------------------------------------------------------------------------------------------
# Create VM-Series.  For every fw_name entered, an additional VM-Series instance will be deployed.

module "common_fw" {
  source                    = "./modules/vmseries/"
  name                      = var.fw_prefix
  vm_count                  = var.fw_count
  username                  = var.fw_username
  password                  = var.fw_password
  panos                     = var.fw_panos
  license                   = var.fw_license
  nsg_prefix                = var.fw_nsg_prefix
  avset_name                = "${var.fw_prefix}-avset"
  subnet_mgmt               = module.vnet.vnet_subnets[0]
  subnet_untrust            = module.vnet.vnet_subnets[1]
  subnet_trust              = module.vnet.vnet_subnets[2]
  nic0_public_ip            = true
  nic1_public_ip            = true
  nic2_public_ip            = false
  nic1_backend_pool_ids     = [module.common_extlb.backend_pool_id]
  nic2_backend_pool_ids     = [module.common_intlb.backend_pool_id]
  bootstrap_storage_account = azurerm_storage_account.main.name
  bootstrap_access_key      = azurerm_storage_account.main.primary_access_key
  bootstrap_file_share      = module.common_fileshare.file_share_name
  bootstrap_share_directory = "None"
  location                  = var.location
  resource_group_name       = var.rg_target
  
  dependencies = [
    module.common_fileshare.completion
  ]
}

#-----------------------------------------------------------------------------------------------------------------
# Create public load balancer.  Load balancer uses firewall's untrust interfaces as its backend pool.

module "common_extlb" {
  source                  = "./modules/lb/"
  name                    = var.lb_public_name
  type                    = "public"
  sku                     = "Standard"
  probe_ports             = [22]
  frontend_ports          = [80, 22, 443]
  backend_ports           = [80, 22, 443]
  protocol                = "Tcp"
  location                = var.location
  resource_group_name     = var.rg_target
}

#-----------------------------------------------------------------------------------------------------------------
# Create internal load balancer. Load balancer uses firewall's trust interfaces as its backend pool

module "common_intlb" {
  source                  = "./modules/lb/"
  name                    = var.lb_private_name
  type                    = "private"
  sku                     = "Standard"
  probe_ports             = [22]
  frontend_ports          = [0]
  backend_ports           = [0]
  protocol                = "All"
  subnet_id               = module.vnet.vnet_subnets[2]
  private_ip_address      = var.lb_private_ip
  location                = var.location
  resource_group_name     = var.rg_target
}

#/-----------------------------------------------------------------------------------------------------------------
# Outputs to terminal

output EXT-LB {
  value = "http://${module.common_extlb.public_ip[0]}"
}

output MGMT-FW1 {
  value = "https://${module.common_fw.nic0_public_ip[0]}"
}

output MGMT-FW2 {
  value = "https://${module.common_fw.nic0_public_ip[1]}"
}
  

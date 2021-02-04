#module "vnet" {
#  source              = "./modules/vnet/"
#  name                = "${var.transit_prefix}-vnet"
#  address_space       = var.transit_vnet_cidr
#  subnet_names        = var.transit_subnet_names
#  subnet_prefixes     = var.transit_subnet_cidrs
#  location            = var.location
#  resource_group_name = var.rg_target
#}

fw_license   = "byol"                                                       # Uncomment 1 fw_license to select VM-Series licensing mode

global_prefix = ""                                                           # Prefix to add to all resource groups created.  This is useful to create unique resource groups within a shared Azure subscription
location      = "ncus"
rg_target = "hub-ncus-palofw"

# -----------------------------------------------------------------------
# Resource group variables

fw_prefix               = "${var.rg_target}"
fw_count                = 2
fw_panos                = "9.0.1"
fw_nsg_prefix           = "0.0.0.0/0"
fw_username             = "paloalto"
fw_password             = "Pal0Alt0@123"
fw_internal_lb_ip       = "10.0.2.100"

transit_prefix          = "${var.rg_target}"
transit_vnet_cidr       = "172.31.1.0/24"
transit_subnet_names    = ["${var.rg_target}-sn-01-mgmt", "${var.rg_target}-sn-02-untrust", "${var.rg_target}-sn-03-trust"]
transit_subnet_cidrs    = ["172.31.1.0/26", "172.31.1.64/26", "172.31.1.128/25"]


fw_license              = "byol"

global_prefix           = ""
location                = "ncus"
rg_target               = "hub-ncus-palofw"

# -----------------------------------------------------------------------
# Firewall variables

fw_prefix               = "pan-fw-aznc"
fw_count                = 2
fw_panos                = "9.0.1"
fw_nsg_prefix           = "0.0.0.0/0"
fw_username             = "paloalto"
fw_password             = "Pal0Alt0@123"
fw_internal_lb_ip       = "172.31.1.250"


# Vnet variables

transit_vnet_cidr       = "172.31.1.0/24"
transit_subnet_names    = ["${var.rg_target}-sn-01-mgmt", "${var.rg_target}-sn-02-untrust", "${var.rg_target}-sn-03-trust"]
transit_subnet_cidrs    = ["172.31.1.0/26", "172.31.1.64/26", "172.31.1.128/25"]

# Load balancer variables

lb_public_name          = "${var.rg_target}-lb-public-01"
lb_private_name          = "${var.rg_target}-lb-private-01"

global_prefix           = ""
location                = "ncus"
rg_target               = "hub-ncus-palofw"

# Vnet variables
vnet_cidr               = "172.31.1.0/24"
subnet_names            = ["${var.rg_target}-sn-01-mgmt", "${var.rg_target}-sn-02-untrust", "${var.rg_target}-sn-03-trust"]
subnet_cidrs            = ["172.31.1.0/26", "172.31.1.64/26", "172.31.1.128/25"]

# Firewall variables
fw_license              = "byol"
fw_prefix               = "pan-fw-aznc"
fw_count                = 2
fw_panos                = "9.0.1"
fw_nsg_prefix           = "148.78.66.0/24"
fw_username             = "paloalto"
fw_password             = "Pal0Alt0@123"

# Load balancer variables
lb_public_name          = "${var.rg_target}-lb-public-01"
lb_private_name         = "${var.rg_target}-lb-private-01"
lb_private_ip          = "172.31.1.250"

global_prefix           = ""
location                = "northcentralus"
rg_target               = "hub-ncus-palofw"

# Vnet variables
vnet_cidr               = "172.31.1.0/24"
subnet_names            = ["hub-ncus-palofw-sn-01", "hub-ncus-palofw-sn-02", "hub-ncus-palofw-sn-03"]
subnet_cidrs            = ["172.31.1.0/26", "172.31.1.64/26", "172.31.1.128/25"]

# Firewall variables
fw_license              = "byol"
fw_prefix               = "pan-fw-aznc"
fw_count                = 2
fw_panos                = "9.0.1"
fw_nsg_prefix           = "148.78.66.0/24"
fw_username             = "paloalto"
fw_password             = "Pal0Alt0@123"
fw_internal_lb_ip       = "172.31.1.250"

# Load balancer variables
lb_public_name          = "hub-ncus-palofw-lb-public-01"
lb_private_name         = "hub-ncus-palofw-lb-private-01"
lb_private_ip          = "172.31.1.250"

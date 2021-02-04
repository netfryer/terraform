variable location {
  description = "Enter a location"
}

variable rg_target {
}

variable fw_prefix {
  description = "Prefix to add to all resources added in the firewall resource group"
  default     = ""
}

variable global_prefix {
  description = "Prefix to add to all resource groups created.  This is useful to create unique resource groups within a shared Azure subscription"
}
#-----------------------------------------------------------------------------------------------------------------
# Transit VNET variables

variable transit_prefix {
}

variable vnet_cidr {
}

variable transit_subnet_names {
  type = list(string)
}

variable transit_subnet_cidrs {
  type = list(string)
}

#-----------------------------------------------------------------------------------------------------------------
# VM-Series variables

variable fw_count {
}

variable fw_nsg_prefix {
}

variable fw_panos {
}

variable fw_username {
}

variable fw_password {
}

variable fw_internal_lb_ip {
}

variable fw_license {
}

#-----------------------------------------------------------------------------------------------------------------
# Azure environment variables

variable client_id {
  description = "Azure client ID"
  default = ""
}

variable client_secret {
  description = "Azure client secret"
  default = ""
}

variable subscription_id {
  description = "Azure subscription ID"
  default = ""
}

variable tenant_id {
  description = "Azure tenant ID"
  default = ""
}

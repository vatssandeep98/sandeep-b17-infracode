module "rg" {
  source                  = "../Child Module/RG"
  resource_group_name     = "sandeep-rg55"
  resource_group_location = "North Europe"
}


module "vnet" {
 depends_on = [ module.rg ]
  source                  = "../Child Module/Vnet"
  vnet_name               = "sandeep-vnet"
  resource_group_location = "North Europe"
  resource_group_name     = "sandeep-rg55"
  address_space           = ["10.0.0.0/16"]
}

module "subnet" {
  depends_on = [ module.vnet, module.rg ]
  source              = "../Child Module/subnet"
  subnet_name         = "sandeep-subnet"
  resource_group_name = "sandeep-rg55"
  vnet_name           = "sandeep-vnet"
  address_prefixes    = ["10.0.0.0/24"]
}

module "vm" {
  depends_on              = [module.subnet, module.nic, module.rg]
  source                  = "../Child Module/VM"
  vm_name                 = "sandeep-vm"
  resource_group_name     = "sandeep-rg55"
  resource_group_location = "North Europe"
  admin_username          = "sandeep"
  admin_password          = "Sandeep@113322"
  nic_id                  = module.nic.nic_id
}

module "nic" {
  depends_on              = [module.subnet, module.pip, module.nsg, module.rg]
  source                  = "../Child Module/NIC"
  nic_name                = "sandeep-nic"
  resource_group_name     = "sandeep-rg55"
  resource_group_location = "North Europe"
  subnet_id               = module.subnet.subnet_id
  pip_id                  = module.pip.pip_id
  nsg_id                 = module.nsg.nsg_id

}

#pip
module "pip" {
  depends_on = [ module.rg ]
  source                  = "../Child Module/PIP"
  pip_name                = "sandeep-pip"
  resource_group_location = "North Europe"
  resource_group_name     = "sandeep-rg55"
}

module "nsg" {
  depends_on = [ module.rg ]
source                  = "../Child Module/NSG"
nsg_name                = "sandeep-nsg"
resource_group_location = "North Europe"
resource_group_name     = "sandeep-rg55"
}     
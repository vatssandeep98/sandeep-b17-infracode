module "rg" {
  source                  = "../Child Module/RG"
  resource_group_name     = "sandeep-rg"
  resource_group_location = "East US"
}


module "vnet" {
 depends_on = [ module.rg ]
  source                  = "../Child Module/Vnet"
  vnet_name               = "sandeep-vnet"
  resource_group_location = "East US"
  resource_group_name     = "sandeep-rg"
  address_space           = ["10.0.0.0/16"]
}


module "subnet" {
  depends_on = [ module.vnet ]
  source              = "../Child Module/subnet"
  subnet_name         = "sandeep-subnet"
  resource_group_name = "sandeep-rg"
  vnet_name           = "sandeep-vnet"
  address_prefixes    = ["10.0.0.0/24"]
}

module "vm" {
  depends_on              = [module.subnet, module.nic]
  source                  = "../Child Module/VM"
  vm_name                 = "sandeep-vm"
  resource_group_name     = "sandeep-rg"
  resource_group_location = "East US"
  admin_username          = "sandeep"
  admin_password          = "Sandeep@113322"
  nic_id                  = module.nic.nic_id
}

module "nic" {
  depends_on              = [module.subnet, module.pip, module.nsg]
  source                  = "../Child Module/NIC"
  nic_name                = "sandeep-nic"
  resource_group_name     = "sandeep-rg"
  resource_group_location = "East US"
  subnet_id               = module.subnet.subnet_id
  pip_id                  = module.pip.pip_id
  nsg_id                 = module.nsg.nsg_id

}

#pip
module "pip" {
  source                  = "../Child Module/PIP"
  pip_name                = "sandeep-pip"
  resource_group_location = "East US"
  resource_group_name     = "sandeep-rg"
}

module "nsg" {
source                  = "../Child Module/NSG"
nsg_name                = "sandeep-nsg"
resource_group_location = "East US"
resource_group_name     = "sandeep-rg"
}     
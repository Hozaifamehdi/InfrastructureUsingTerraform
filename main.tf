terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0.2"
    }
  }
  required_version = ">= 1.1.0"
}

provider "azurerm" {
  features {}
}

#Resource group 
resource "azurerm_resource_group" "Testing" {
    name = var.Resource_Name
    location = var.location
    tags = {
      Enviroment = "Testing"
      Tool = "Terraform"
    }
}

# Virtual Networking 
resource "azurerm_virtual_network" "v-netTesting" {
    name= "v-net${var.Resource_Name}"
    location = var.location
    resource_group_name = azurerm_resource_group.Testing.name

    address_space = ["192.0.0.0/16"]
  tags = {
    Enviroment = "Testing"
    Tool = "Terraform"
  }
}

resource "azurerm_subnet" "v-netTestingSubnet" {
    name = "Testing"
    virtual_network_name = azurerm_virtual_network.v-netTesting.name
    resource_group_name = azurerm_resource_group.Testing.name
    address_prefixes = ["192.0.1.0/24"]
}

# resource "azurerm_subnet" "AzureBastion" {
#     name = "AzureBastionSubnet"
#     virtual_network_name = azurerm_virtual_network.v-netTesting.name
#     resource_group_name = azurerm_resource_group.Testing.name
#     address_prefixes = ["192.0.2.0/27"]
# }


#Network Interface 
resource "azurerm_network_interface" "network_interface" {
  name = "nic${var.Resource_Name}"
  resource_group_name = azurerm_resource_group.Testing.name
  location = var.location

  #IP Configuration 
  ip_configuration {
    name = "pip${var.Resource_Name}"
    subnet_id = azurerm_subnet.v-netTestingSubnet.id //   This will associate IP address to virtual machine 
    # subnet_id = azurerm_subnet.AzureBastion           // This will associate IP address to AzureBastion
    private_ip_address_allocation = "Dynamic"
  public_ip_address_id = azurerm_public_ip.PIP.id        // To assign IP address to Virtual Machine
  }
}


# Network Security Group 
resource "azurerm_network_security_group" "Network_Security_Group" {
  name = "NSG-${var.Resource_Name}"
  resource_group_name = azurerm_resource_group.Testing.name
  location = var.location

    security_rule {
    name                       = "test123"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    Enviroment = "Testing"
  }
}

# Public IP address 
resource "azurerm_public_ip" "PIP" {
    name = "PIP-${var.Resource_Name}"
    resource_group_name = azurerm_resource_group.Testing.name
    location = var.location
    allocation_method = "Static"
    sku = "Standard"

    tags = {
      Enviroment = "Testing"
    }
}

# Network Interface Security Group Association
resource "azurerm_network_interface_security_group_association" "interfaceSecurityGroupAssociation" {
    network_interface_id = azurerm_network_interface.network_interface.id
    network_security_group_id = azurerm_network_security_group.Network_Security_Group.id
}

# Window Virtual Machine 
resource "azurerm_windows_virtual_machine" "VirtualMachine" {

    name = "VM-${var.Resource_Name}"
    location = var.location
    resource_group_name = azurerm_resource_group.Testing.name
    admin_username = "hozaifa.mehdi"
    admin_password = "Bold&*(321mehdi"
    network_interface_ids = [azurerm_network_interface.network_interface.id]
    size = "Standard_F2"

    source_image_reference {
    publisher = "MicrosoftWindowsServer"
    offer     = "WindowsServer"
    sku       = "2019-Datacenter"
    version   = "latest"
  }
    os_disk {
        name = "VM-Disk"
        storage_account_type = "Standard_LRS"
        caching = "ReadWrite"
    }
}

# Install IIS web server to the virtual machine
resource "azurerm_virtual_machine_extension" "web_server_install" {
  name                       = "IIs-wsi"
  virtual_machine_id         = azurerm_windows_virtual_machine.VirtualMachine.id
  publisher                  = "Microsoft.Compute"
  type                       = "CustomScriptExtension"
  type_handler_version       = "1.8"
  auto_upgrade_minor_version = true

  settings = <<SETTINGS
    {
      "commandToExecute": "powershell -ExecutionPolicy Unrestricted Install-WindowsFeature -Name Web-Server -IncludeAllSubFeature -IncludeManagementTools"
    }
  SETTINGS
}


// Active Directory Domain Service


# resource "azurerm_active_directory_domain_service" "active_directory_domain_service" {
#   name = "AzureActiveDirectoryDomainService"
#   resource_group_name = azurerm_resource_group.Testing.name
#   domain_name = "Mashroob.com"
#   location = var.location
#   sku = "Standard"

#     filtered_sync_enabled = false

#   initial_replica_set {
#     subnet_id = azurerm_subnet.deploy.id
#   }

#   notifications {
#     additional_recipients = ["notifyA@mashroob.com", "notifyB@mashroob.com"]
#     notify_dc_admins      = true
#     notify_global_admins  = true
#   }

#   security {
#     sync_kerberos_passwords = true
#     sync_ntlm_passwords     = true
#     sync_on_prem_passwords  = true
#   }

#   tags = {
#     Environment = "prod"
#   }

#   depends_on = [
#     azuread_service_principal.example,
#     azurerm_subnet_network_security_group_association.deploy,
#   ]

# }



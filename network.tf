resource "azurerm_public_ip" "myterraformpublicip" {
  name                = "PublicIP_20190780"
  location            = var.region
  resource_group_name = "devops-TP2"
  allocation_method   = "Dynamic"
}

# Create Network Security Group and rule
resource "azurerm_network_security_group" "myterraformnsg" {
  name                = "NetworkSecurityGroup_20190780"
  location            = var.region
  resource_group_name = "devops-TP2"

  security_rule {
    name                       = "SSH_20190780"
    priority                   = 1001
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Create network interface
resource "azurerm_network_interface" "myterraformnic" {
  name                = "NIC_20190780"
  location            = var.region
  resource_group_name = data.azurerm_resource_group.tp4.name

  ip_configuration {
    name                          = "NicConfiguration_20190780"
    subnet_id                     = data.azurerm_subnet.tp4.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.myterraformpublicip.id
  }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "example" {
  network_interface_id      = azurerm_network_interface.myterraformnic.id
  network_security_group_id = azurerm_network_security_group.myterraformnsg.id
}

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = data.azurerm_resource_group.tp4.name
  }

  byte_length = 8
}


# Create (and display) an SSH key
resource "tls_private_key" "example_ssh" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "myterraformvm" {
  name                  = "VM_20190780"
  location              = data.azurerm_resource_group.tp4.location
  resource_group_name   = data.azurerm_resource_group.tp4.name
  network_interface_ids = [azurerm_network_interface.myterraformnic.id]
  size                  = "Standard_D2s_V3"

  os_disk {
    name                 = "OsDisk_20190780"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  computer_name                   = "devops-20190780"
  admin_username                  = "azureuser"
  disable_password_authentication = true

  admin_ssh_key {
    username   = "azureuser"
    public_key = tls_private_key.example_ssh.public_key_openssh
  }

}


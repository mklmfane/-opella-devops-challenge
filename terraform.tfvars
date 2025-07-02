vnet_name     = "demo-vnet-first"
address_space = ["10.0.0.0/16"]

subnets = [
  {
    name             = "subnet-1"
    address_prefixes = ["10.0.1.0/24"]
  },
  {
    name             = "subnet-2"
    address_prefixes = ["10.0.2.0/24"]
  }
]

username = "devops-test"
public_key = "ssh-rsa DDDDM3PzaC1yc0EAAAADAQABAAACAQDSMg sadsd@myhost.com"

tags = {
  environment = "dev"
  project     = "opella-test"
  owner       = "devops"
}
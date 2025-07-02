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

username       = "devops-test"
ssh_public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDSMgn1iGOksghwCrnuXAMXKtAk/TwAw/pTJb9mC+q6v9Clo+yVizRwQ+kGsDAtZUUkQfIr3Ep5MUSOtyfyeLQkiC55iD4JvEpWbiwCrbma17z9hPDiEUu8cYBZhQIpXnVkTdtoRRSejNlAfgb1OJDjyG5tAv/QF7Bvq8+MsxEHYlb7NewSe8Fh/AFTCFVkixyYhjXEHOrX9naBzNyYRqkGpQ9dJd9USsGEIgku3VkI2jNNCLtJIlli3TTy726vtAJ713TXfzbcYtlkXmcDRk3r7Y1934DfRSwenlad8O5ElcnYgeLPo50SVUnEufmbz0OV/rIb1WBL1KWuIcPdKkRRTz7X+uGdSGj24FTTrtAWajpEyvFemtN2ViZpqUJ+L/oJEKObc/ZP1pNX2a53Y9MJIDQ+mtzFvA1p//1p5FSe9yoBtzLurP0MiLdLJZJcjVAGv+p6jYCk2XPOFqaMV59j2qz978Ky65LycJ5L8SAyvUqoqoDS0eB9ckxnjhlR6j+f6mWOQ8gW7bYEDTvRQJr45LWtuyW61hC7Xp0E9MuG0Sr5/YKS6cSqppNsgCuOiWK74z+lKmTwkw3xXMhM8VRO67TVthRIdbEhvL8pHSiS02iLHl7aIcmou5XZIUwE0KQW3TKurxcA1wiibWC++n/oGX95IKOjskxnt/ce/cQsoQ== devops-test@staff-fddggfgd.myhost.com"

tags = {
  environment = "dev"
  project     = "opella-test"
  owner       = "devops"
}
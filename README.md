## Requirements

It should be created credentials for github actions to be authenticate to to Azure subscription 
az ad sp create-for-rbac --name "my-gh-terraform-sp" --role="Contributor"\ 
--scopes="/subscriptions subscription_id_that_you_used" --sdk-auth

AZURE_CLIENT_ID=$(az ad sp list --display-name "my-gh-terraform-sp" --query '[0].appId' -o tsv)

az ad app federated-credential create --id "$AZURE_CLIENT_ID"  \
  --parameters '{
    "name": "github-oidc-federation",
    "issuer": "https://token.actions.githubusercontent.com",
    "subject": "repo:mklmfane/-opella-devops-challenge:ref:refs/heads/master",
    "audiences": ["api://AzureADTokenExchange"]
  }'
{
  "@odata.context": "https://graph.microsoft.com/v1.0/$metadata#applications('e45a5fed-0af0-4fbc-9a84-73ceccdb2dac')/federatedIdentityCredentials/$entity",
  "audiences": [
    "api://AzureADTokenExchange"
  ],
  "description": null,
  "id": "xxxxx-xxxx-xxxx-xxx-xxxxx",
  "issuer": "https://token.actions.githubusercontent.com",
  "name": "github-oidc-federation",
  "subject": "repo:mklmfane/-opella-devops-challenge:ref:refs/heads/master"
}


Create the following secrets with each own value by accesing in github repository Settings->Security->Actions->Repository secret
1. First secrets 
Name:ARM_CLIENT_ID
Value: What you you get from "echo $AZURE_CLIENT_ID"

2. Second secret
Name:ARM_TENANT_ID
Value: What you get from this command "az account show --query tenantId --output tsv"
    
3. Third secret
Name: ARM_SUBSCRIPTION_ID
Value: What you get as an output from this command "az account show --query id --output tsv"

### 1. Reusable Module Creation

**Task**: Create a Terraform module for provisioning an Azure VNET that can be reused across different setups.
@@ -32,21 +71,197 @@ Expect to spend about 2-4 hours on this.
  - What information would someone need in order to use this module? Bonus points if you automate documentation! (indicate how)
  - Super extra points if your module is tested

  The modules is provided in the folder modules/vnet.
  I crated moduels inside folder structure modules/vnet.

  module "vnet" {
    source              = "./modules/vnet"
    resource_group_name = azurerm_resource_group.rg.name
    location            = var.location
    vnet_name           = local.vnet_name
    address_space       = var.address_space
    subnets             = var.subnets
    tags                = var.tags
  }


### 2. Infrastructure Setup

**Task**: Create a repository and a GitHub pipeline to deploy multiple environments in Azure using your VNET module, plus a couple of additional resources.

- **Folder Structure**: Set up your code to handle a `dev` environment in one Azure region (e.g., `eastus`), with an eye toward scaling to other environments and regions later.

Instead of creating folders, I preferred creating terraform workflows in github actions
  deploy:
    needs: build
    runs-on: ubuntu-latest
    strategy:
      matrix:
        environment: [dev, test, prod]

    - name: Select/Create Workspace
      run: terraform workspace select -or-create ${{ matrix.environment }}


- **Hints**:
  - Argument why would you use Resource Groups or Subscriptions for multiple environments.
    I decided to use terraform workflows for each individual environment
    
    In your case, you run multi-environment deployment via GitHub Actions workflows, each deploying into its own workspace (dev, test, prod), with environment set via:

hcl
locals {
  environment = var.workflow
}

  - Keeps it flexible, avoids extra manual setup.
    Resource Groups can be used in most of the cases for the environments such as development, testing, and staging.
    It will be easier to have the resource groups in the same subscription becas it easy to assign RBAC role with particular permissions.
    Using separated Subscriptions are useful for production for isolation issues, separated billing and apply separated policies 

  - Include a virtual machine and one other resources (your choice—think about what’s useful in a dev setup).
  
  - Name and label resources to make the environment and region clear.
    This can be performed by using variable 
    variable "tags" {
      description = "Tags"
      type        = map(string)
      default     = {}  
    }
    
    Tags are define in maintf as local variable
    hcl
    locals {
     
      tags = {
        environment = local.environment
        project     = "multi-env-demo"
     }
    }


    This is the default value defined in terrafrom.tfvars
    tags = {
      environment = "dev"
      project     = "opella"
    }
 

  - Avoid repeating values—how can you make this flexible?
    That is why I decided to use local variable
    
  hcl
    locals {
      environment = var.workflow
  
      resource_group_name = "${local.environment}-rg"
      vnet_name           = "${local.environment}-vnet"
      storage_account_name = "${substr(replace("${local.environment}storage${replace(uuid(), "-", "")}", "-", ""), 0, 24)}"

      tags = {
        environment = local.environment
        project     = "multi-env-demo"
      }
    }  

  - How might you label resources for better tracking? How would you enforce this?

    You can tag resources consistently for:

    - environment
    - project
    - cost center
    - owner
    - securtity compliance for security audit like PCI DSS
    
    How to enforce?
    There are two ways of enfocing tags for better tracking
     - Use one of choice fora applying  Terraform policies like Open policy agent or Terrafrom Sentinel.
     - Use Azure Policy to stop deployment in cae the tags are not applied

  
  - What outputs might be useful and why?
    Terraform used the selected providers to generate the following execution
    plan. Resource actions are indicated with the following symbols:
    + create

    Terraform will perform the following actions:

  # azurerm_resource_group.rg will be created
  + resource "azurerm_resource_group" "rg" {
      + id       = (known after apply)
      + location = "westeurope"
      + name     = "dev-rg"
    }

  # module.vnet.azurerm_subnet.subnet["subnet-1"] will be created
  + resource "azurerm_subnet" "subnet" {
      + address_prefixes                               = [
          + "10.0.1.0/24",
        ]
      + default_outbound_access_enabled                = true
      + enforce_private_link_endpoint_network_policies = (known after apply)
      + enforce_private_link_service_network_policies  = (known after apply)
      + id                                             = (known after apply)
      + name                                           = "subnet-1"
      + private_endpoint_network_policies              = (known after apply)
      + private_endpoint_network_policies_enabled      = (known after apply)
      + private_link_service_network_policies_enabled  = (known after apply)
      + resource_group_name                            = "dev-rg"
      + virtual_network_name                           = "dev-vnet"
    }

  # module.vnet.azurerm_subnet.subnet["subnet-2"] will be created
  + resource "azurerm_subnet" "subnet" {
      + address_prefixes                               = [
          + "10.0.2.0/24",
        ]
      + default_outbound_access_enabled                = true
      + enforce_private_link_endpoint_network_policies = (known after apply)
      + enforce_private_link_service_network_policies  = (known after apply)
      + id                                             = (known after apply)
      + name                                           = "subnet-2"
      + private_endpoint_network_policies              = (known after apply)
      + private_endpoint_network_policies_enabled      = (known after apply)
      + private_link_service_network_policies_enabled  = (known after apply)
      + resource_group_name                            = "dev-rg"
      + virtual_network_name                           = "dev-vnet"
    }

  # module.vnet.azurerm_virtual_network.virtual_network_one will be created
  + resource "azurerm_virtual_network" "virtual_network_one" {
      + address_space       = [
          + "10.0.0.0/16",
        ]
      + dns_servers         = (known after apply)
      + guid                = (known after apply)
      + id                  = (known after apply)
      + location            = "westeurope"
      + name                = "dev-vnet"
      + resource_group_name = "dev-rg"
      + subnet              = (known after apply)
      + tags                = {
          + "environment" = "dev"
          + "project"     = "opella"
        }
    }

Plan: 4 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + subnet_ids = {
      + subnet-1 = (known after apply)
      + subnet-2 = (known after apply)
    }
  + vnet_id    = (known after apply)

─────────────────────────────────────────────────────────────────────────────

Note: You didn't use the -out option to save this plan, so Terraform can't
guarantee to take exactly these actions if you run "terraform apply" now.
  - Bonus points if you build a GitHub pipeline and explain the release lifecycle.

---

Good luck—we’re excited to see your work!
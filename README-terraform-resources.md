<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~> 3.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | ~> 3.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.117.1 |
| <a name="provider_random"></a> [random](#provider\_random) | 3.7.2 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_vm"></a> [vm](#module\_vm) | ./modules/vm | n/a |
| <a name="module_vnet"></a> [vnet](#module\_vnet) | ./modules/vnet | n/a |

## Resources

| Name | Type |
|------|------|
| [azurerm_resource_group.rg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_storage_account.sa](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [random_string.suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | Address space for the virtual network | `list(string)` | n/a | yes |
| <a name="input_admin_password"></a> [admin\_password](#input\_admin\_password) | Admin password for Windows VM (required only if os\_type is windows) | `string` | `null` | no |
| <a name="input_linux_source_image_reference"></a> [linux\_source\_image\_reference](#input\_linux\_source\_image\_reference) | Map of source image reference for the virtual machine | `map(string)` | <pre>{<br/>  "offer": "0001-com-ubuntu-server-jammy",<br/>  "publisher": "Canonical",<br/>  "sku": "22_04-lts",<br/>  "version": "latest"<br/>}</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | Azure region to deploy resources in | `string` | `"westeurope"` | no |
| <a name="input_os_type"></a> [os\_type](#input\_os\_type) | Operating system type for the VM. Allowed values: linux or windows | `string` | `"linux"` | no |
| <a name="input_prefix_vnet"></a> [prefix\_vnet](#input\_prefix\_vnet) | Prefix of the VNET | `string` | n/a | yes |
| <a name="input_size_vm"></a> [size\_vm](#input\_size\_vm) | The size of the virtual machine | `string` | `"Standard_B1s"` | no |
| <a name="input_ssh_public_key"></a> [ssh\_public\_key](#input\_ssh\_public\_key) | SSH public key for VM authentication | `string` | n/a | yes |
| <a name="input_subnets"></a> [subnets](#input\_subnets) | List of subnets for the VNet | <pre>list(object({<br/>    name             = string<br/>    address_prefixes = list(string)<br/>  }))</pre> | n/a | yes |
| <a name="input_subscription_id"></a> [subscription\_id](#input\_subscription\_id) | The Azure Subscription ID to use | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to apply to resources | `map(string)` | <pre>{<br/>  "owner": "devops",<br/>  "project": "multi-env-demo"<br/>}</pre> | no |
| <a name="input_username"></a> [username](#input\_username) | Username for the virtual machine | `string` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the virtual network | `string` | n/a | yes |
| <a name="input_windows_image_reference"></a> [windows\_image\_reference](#input\_windows\_image\_reference) | Windows image reference | `map(string)` | <pre>{<br/>  "offer": "WindowsServer",<br/>  "publisher": "MicrosoftWindowsServer",<br/>  "sku": "2022-datacenter-azure-edition",<br/>  "version": "latest"<br/>}</pre> | no |
| <a name="input_workflow"></a> [workflow](#input\_workflow) | Workflow environment: dev, test, or prod | `string` | `"dev"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | n/a |
| <a name="output_vnet_id"></a> [vnet\_id](#output\_vnet\_id) | n/a |
<!-- END_TF_DOCS -->
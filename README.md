# terraform-azurerm-key-vault

The module can be used to provision an Azure Key Vault.

## Usage

Examples for this module along with various configurations can be found in the [examples/](examples/) folder.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0, < 2.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.15, < 4.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.15, < 4.0 |
| <a name="provider_random"></a> [random](#provider\_random) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_azure_resource_names"></a> [azure\_resource\_names](#module\_azure\_resource\_names) | git::https://github.com/gccloudone-aurora-iac/terraform-aurora-azure-resource-names.git | v2.0.0 |
| <a name="module_key_vault_name"></a> [key\_vault\_name](#module\_key\_vault\_name) | git::https://github.com/gccloudone-aurora-iac/terraform-aurora-azure-resource-names-global.git | v2.0.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azure_resource_attributes"></a> [azure\_resource\_attributes](#input\_azure\_resource\_attributes) | Attributes used to describe Azure resources | <pre>object({<br>    project     = string<br>    environment = string<br>    location    = optional(string, "Canada Central")<br>    instance    = number<br>  })</pre> | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | The name of the resource group in which resources will be created | `string` | n/a | yes |
| <a name="input_sku_name"></a> [sku\_name](#input\_sku\_name) | The Name of the SKU used for this Key Vault. Possible values are standard and premium. | `string` | n/a | yes |
| <a name="input_user_defined"></a> [user\_defined](#input\_user\_defined) | The user-defined segment that describes the purpose of the Key Vault name. | `string` | n/a | yes |
| <a name="input_default_network_access_action"></a> [default\_network\_access\_action](#input\_default\_network\_access\_action) | The Default Action to use when no rules match from ip\_rules / virtual\_network\_subnet\_ids. Possible values are Allow and Deny. | `string` | `"Deny"` | no |
| <a name="input_enable_rbac_authorization"></a> [enable\_rbac\_authorization](#input\_enable\_rbac\_authorization) | Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. The alternative is using vault access policy for authorization. | `bool` | `false` | no |
| <a name="input_ip_rules"></a> [ip\_rules](#input\_ip\_rules) | One or more IP Addresses, or CIDR Blocks which should be able to access the Key Vault. | `list(string)` | `[]` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | The name of an existing subnet to deploy and allocate private IP addresses from a virtual network. It is used to create a private endpoint between the keyvault the module creates and the specified subnet. | <pre>list(object({<br>    sub_resource_name   = string<br>    subnet_id           = optional(string)<br>    private_dns_zone_id = string<br>  }))</pre> | `[]` | no |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | Whether public network access is allowed for this Key Vault. If false, only private endpoints can be created. | `bool` | `false` | no |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | Is Purge Protection enabled for this Key Vault? | `bool` | `true` | no |
| <a name="input_resource_access"></a> [resource\_access](#input\_resource\_access) | Determines what kind of resources can access secrets. | <pre>object({<br>    enabled_for_deployment          = bool<br>    enabled_for_template_deployment = bool<br>    enabled_for_disk_encryption     = bool<br>  })</pre> | <pre>{<br>  "enabled_for_deployment": false,<br>  "enabled_for_disk_encryption": false,<br>  "enabled_for_template_deployment": false<br>}</pre> | no |
| <a name="input_service_endpoint_subnet_ids"></a> [service\_endpoint\_subnet\_ids](#input\_service\_endpoint\_subnet\_ids) | The service endpoints to configure on the key vault. | `list(string)` | `[]` | no |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | The number of days that items should be retained for once soft-deleted. This field can't be updated. | `number` | `7` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags to set on the Azure Key Vault | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The Azure assigned ID generated after the KeyVault resource is created and available. |
| <a name="output_name"></a> [name](#output\_name) | The name of the key vault. |
| <a name="output_private_endpoint_ids"></a> [private\_endpoint\_ids](#output\_private\_endpoint\_ids) | The Azure resource IDs of the private endpoints created. |
| <a name="output_private_endpoint_ip_config"></a> [private\_endpoint\_ip\_config](#output\_private\_endpoint\_ip\_config) | The IP configuration of the private endpoints. |
| <a name="output_uri"></a> [uri](#output\_uri) | The URI of the Key Vault, used for performing operations on keys and secrets. |
<!-- END_TF_DOCS -->

## History

| Date       | Release     | Change                                                                        |
| -----------| ------------| ----------------------------------------------------------------------------- |
| 2025-01-25 | v1.0.0      | Initial commit                                                                |

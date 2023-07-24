<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.ingress-nginx](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ingress_name"></a> [ingress\_name](#input\_ingress\_name) | Default name prefix to be used for all resources without specific naming requirements (VMs, azure container instances, application gateways, etc.) | `string` | n/a | yes |
| <a name="input_ingress_pubip"></a> [ingress\_pubip](#input\_ingress\_pubip) | Public ip for ingress controller | `string` | n/a | yes |
| <a name="input_namespace_name"></a> [namespace\_name](#input\_namespace\_name) | k8s namespace | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nginx_ingress_name"></a> [nginx\_ingress\_name](#output\_nginx\_ingress\_name) | n/a |
<!-- END_TF_DOCS -->
# Purrfect Match Terraform Module

Deploy [Purrfect Match](https://purrfectproductions.com) to any Kubernetes cluster using Terraform.

## Usage

```hcl
module "purrfect_match" {
  source = "github.com/PlotNotes/purrfect-terraform"

  registry_username = var.license_id
  registry_password = var.license_id

  # Optional: use external database
  embedded_database    = false
  external_db_host     = "db.example.com"
  external_db_user     = "purrfect"
  external_db_password = var.db_password
  external_db_name     = "purrfect"
}
```

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 1.5.0 |
| helm | >= 2.12.0 |
| kubernetes | >= 2.25.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|----------|
| registry_username | Registry username (license ID) | string | - | yes |
| registry_password | Registry password (license ID) | string | - | yes |
| namespace | Kubernetes namespace | string | `"purrfect"` | no |
| chart_version | Helm chart version | string | `"1.0.8"` | no |
| embedded_database | Deploy embedded PostgreSQL | bool | `true` | no |
| external_db_host | External DB host | string | `""` | no |
| external_db_port | External DB port | string | `"5432"` | no |
| external_db_user | External DB username | string | `""` | no |
| external_db_password | External DB password | string | `""` | no |
| external_db_name | External DB name | string | `"purrfect"` | no |
| service_type | K8s service type | string | `"ClusterIP"` | no |
| ingress_enabled | Enable ingress | bool | `false` | no |
| allow_add_cats | Allow adding cats | bool | `true` | no |
| dark_mode | Enable dark mode | bool | `false` | no |
| max_cats_per_page | Cats per page | number | `12` | no |

## Outputs

| Name | Description |
|------|-------------|
| namespace | Deployment namespace |
| release_name | Helm release name |
| release_version | Deployed chart version |
| service_endpoint | In-cluster service endpoint |

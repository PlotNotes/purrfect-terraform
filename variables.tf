# --- Required ---

variable "registry_endpoint" {
  description = "Container registry endpoint for pulling Purrfect Match images"
  type        = string
  default     = "proxy.replicated.com"
}

variable "registry_username" {
  description = "Registry username (use license ID for Replicated proxy)"
  type        = string
  sensitive   = true
}

variable "registry_password" {
  description = "Registry password (use license ID for Replicated proxy)"
  type        = string
  sensitive   = true
}

  description = "Admin email address for Purrfect Match notifications"
  type        = string

  validation {
    error_message = "Must be a valid email address."
  }
}

# --- Deployment ---

variable "namespace" {
  description = "Kubernetes namespace for the Purrfect Match deployment"
  type        = string
  default     = "purrfect"
}

variable "release_name" {
  description = "Helm release name"
  type        = string
  default     = "purrfect-match"
}

variable "helm_repository" {
  description = "Helm chart repository URL"
  type        = string
  default     = "oci://registry.replicated.com/purrfect/stable"
}

variable "chart_version" {
  description = "Purrfect Match Helm chart version to deploy"
  type        = string
  default     = "1.0.8"
}

variable "image_repository" {
  description = "Container image repository"
  type        = string
  default     = "proxy.replicated.com/proxy/purrfect/ghcr.io/noahecampbell/purrfect"
}

variable "image_tag" {
  description = "Container image tag"
  type        = string
  default     = "latest"
}

# --- Networking ---

variable "service_type" {
  description = "Kubernetes service type (ClusterIP, NodePort, LoadBalancer)"
  type        = string
  default     = "ClusterIP"

  validation {
    condition     = contains(["ClusterIP", "NodePort", "LoadBalancer"], var.service_type)
    error_message = "Must be one of: ClusterIP, NodePort, LoadBalancer."
  }
}

variable "service_port" {
  description = "Service port for the Purrfect Match application"
  type        = number
  default     = 8000
}

variable "ingress_enabled" {
  description = "Enable ingress for external access"
  type        = bool
  default     = false
}

variable "ingress_class" {
  description = "Ingress class name"
  type        = string
  default     = ""
}

variable "ingress_host" {
  description = "Ingress hostname"
  type        = string
  default     = ""
}

# --- Database ---

variable "embedded_database" {
  description = "Deploy embedded PostgreSQL (set to false to use an external database)"
  type        = bool
  default     = true
}

variable "external_db_host" {
  description = "External PostgreSQL host (required when embedded_database is false)"
  type        = string
  default     = ""
}

variable "external_db_port" {
  description = "External PostgreSQL port"
  type        = string
  default     = "5432"
}

variable "external_db_user" {
  description = "External PostgreSQL username"
  type        = string
  default     = ""
}

variable "external_db_password" {
  description = "External PostgreSQL password"
  type        = string
  default     = ""
  sensitive   = true
}

variable "external_db_name" {
  description = "External PostgreSQL database name"
  type        = string
  default     = "purrfect"
}

# --- Features ---

variable "allow_add_cats" {
  description = "Allow users to add new cats to the adoption catalog"
  type        = bool
  default     = true
}

variable "dark_mode" {
  description = "Enable dark mode theme"
  type        = bool
  default     = false
}

variable "max_cats_per_page" {
  description = "Maximum number of cats displayed per page"
  type        = number
  default     = 12

  validation {
    condition     = var.max_cats_per_page >= 1 && var.max_cats_per_page <= 100
    error_message = "Must be between 1 and 100."
  }
}

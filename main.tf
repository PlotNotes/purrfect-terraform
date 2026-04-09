terraform {
  required_version = ">= 1.5.0"

  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = ">= 2.12.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.25.0"
    }
  }
}

resource "kubernetes_namespace" "purrfect" {
  metadata {
    name   = var.namespace
    labels = {
      "app.kubernetes.io/managed-by" = "terraform"
      "app.kubernetes.io/part-of"    = "purrfect-match"
    }
  }
}

resource "kubernetes_secret" "registry_credentials" {
  metadata {
    name      = "purrfect-registry"
    namespace = kubernetes_namespace.purrfect.metadata[0].name
  }

  type = "kubernetes.io/dockerconfigjson"

  data = {
    ".dockerconfigjson" = jsonencode({
      auths = {
        (var.registry_endpoint) = {
          auth = base64encode("${var.registry_username}:${var.registry_password}")
        }
      }
    })
  }
}

resource "helm_release" "purrfect_match" {
  name       = var.release_name
  namespace  = kubernetes_namespace.purrfect.metadata[0].name
  repository = var.helm_repository
  chart      = "purrfect-match"
  version    = var.chart_version

  values = [
    yamlencode({
      image = {
        repository = var.image_repository
        tag        = var.image_tag
      }

      imagePullSecrets = [
        { name = kubernetes_secret.registry_credentials.metadata[0].name }
      ]

      service = {
        type = var.service_type
        port = var.service_port
      }

      ingress = {
        enabled   = var.ingress_enabled
        className = var.ingress_class
        host      = var.ingress_host
      }

      postgresql = {
        enabled = var.embedded_database
      }

      externalDatabase = {
        enabled  = !var.embedded_database
        host     = var.external_db_host
        port     = var.external_db_port
        user     = var.external_db_user
        password = var.external_db_password
        database = var.external_db_name
      }

      redis = {
        enabled = true
      }

      features = {
        allowAddCats   = var.allow_add_cats
        darkMode       = var.dark_mode
        maxCatsPerPage = var.max_cats_per_page
      }

      adminEmail = var.admin_email
    })
  ]

  depends_on = [kubernetes_namespace.purrfect]
}

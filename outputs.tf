output "namespace" {
  description = "Kubernetes namespace where Purrfect Match is deployed"
  value       = kubernetes_namespace.purrfect.metadata[0].name
}

output "release_name" {
  description = "Helm release name"
  value       = helm_release.purrfect_match.name
}

output "release_version" {
  description = "Deployed chart version"
  value       = helm_release.purrfect_match.version
}

output "service_endpoint" {
  description = "In-cluster service endpoint"
  value       = "${var.release_name}.${kubernetes_namespace.purrfect.metadata[0].name}.svc.cluster.local:${var.service_port}"
}

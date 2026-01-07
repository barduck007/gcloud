output "cluster_id" {
    description = "ID du cluster GKE"
    value       = module.gke_cluster.cluster_id
}

output "cluster_name" {
    description = "Nom du cluster GKE"
    value       = module.gke_cluster.name
}

output "cluster_endpoint" {
    description = "Endpoint du cluster pour se connecter"
    value       = module.gke_cluster.endpoint
    sensitive   = true
}

output "cluster_ca_certificate" {
    description = "Certificat CA du cluster"
    value       = module.gke_cluster.ca_certificate
    sensitive   = true
}

output "service_account_email" {
    description = "Email du service account utilisé par les nodes"
    value       = google_service_account.gke_sa.email
}

output "location" {
    description = "Localisation du cluster"
    value       = module.gke_cluster.location
}


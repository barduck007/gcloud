output "cloudsql_instance_connection_name" {
    description = "Nom de connexion de l'instance Cloud SQL"
    value       = module.cloudsql_blog.instance_connection_name
}

output "cloudsql_instance_ip_address" {
    description = "Adresse IP publique de l'instance"
    value       = module.cloudsql_blog.instance_ip_address
}

output "cloudsql_service_account_email" {
    description = "Email du service account Cloud SQL"
    value       = module.cloudsql_blog.service_account_email
}

output "database_name" {
    description = "Nom de la base de données"
    value       = module.cloudsql_blog.database_name
}

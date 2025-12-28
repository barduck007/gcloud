output "instance_name" {
  description = "Nom de l'instance Cloud SQL"
  value       = google_sql_database_instance.instance.name
}

output "instance_connection_name" {
  description = "Nom de connexion de l'instance (format: project:region:instance)"
  value       = google_sql_database_instance.instance.connection_name
}

output "instance_ip_address" {
  description = "Adresse IP publique de l'instance"
  value       = google_sql_database_instance.instance.public_ip_address
}

output "database_name" {
  description = "Nom de la base de données"
  value       = google_sql_database.database.name
}

output "service_account_email" {
  description = "Email du service account Cloud SQL"
  value       = google_service_account.cloudsql_sa.email
}

output "write_user_name" {
  description = "Nom de l'utilisateur en écriture"
  value       = google_sql_user.write_user.name
}

output "read_user_name" {
  description = "Nom de l'utilisateur en lecture"
  value       = google_sql_user.read_user.name
}
variable "instance_name" {
  description = "Nom de l'instance Cloud SQL"
  type        = string
}



output "cloudsql_instance_connection_name" {
  value = google_sql_database_instance.blog_instance.connection_name
}

output "cloudsql_service_account_email" {
  value = google_service_account.cloudsql_sa.email
}

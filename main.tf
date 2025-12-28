resource "google_service_account" "cloudsql_sa" {
  account_id   = "cloudsql-sa"
  display_name = "Service Account pour Cloud SQL"
}

resource "google_sql_database_instance" "blog_instance" {
  name             = var.db_instance_name
  region           = var.region
  database_version = "POSTGRES_15"

  settings {
    tier = "db-f1-micro"
    ip_configuration {
      ipv4_enabled = true
      # authorized_networks = [] # à compléter si besoin
    }
  }
}

resource "google_sql_database" "blog_db" {
  name     = var.db_name
  instance = google_sql_database_instance.blog_instance.name
}

resource "google_sql_user" "blog_write" {
  name     = var.db_write_user
  instance = google_sql_database_instance.blog_instance.name
  password = var.db_write_password
}

resource "google_sql_user" "blog_read" {
  name     = var.db_read_user
  instance = google_sql_database_instance.blog_instance.name
  password = var.db_read_password
}

# Pour restreindre les droits de blog_read à la lecture uniquement,
# il faut exécuter un script SQL via un provisioner ou un outil externe,
# car Terraform ne gère pas les rôles PostgreSQL natifs.
# Exemple d'utilisation d'un null_resource avec un local-exec (à adapter selon votre workflow) :
resource "null_resource" "grant_read_only" {
  provisioner "local-exec" {
    command = <<EOT
      PGPASSWORD=${var.db_write_password} psql -h $(google_sql_database_instance.blog_instance.connection_name) -U ${var.db_write_user} -d ${var.db_name} -c "GRANT SELECT ON ALL TABLES IN SCHEMA public TO ${var.db_read_user};"
    EOT
  }
  depends_on = [google_sql_user.blog_read, google_sql_user.blog_write, google_sql_database.blog_db]
}

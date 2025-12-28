resource "google_service_account" "cloudsql_sa" {
  account_id   = "${var.instance_name}-sa"
  display_name = "Service Account pour Cloud SQL ${var.instance_name}"
}

resource "google_sql_database_instance" "instance" {
  name             = var.instance_name
  region           = var.region
  database_version = var.database_version

  settings {
    tier = var.tier
    ip_configuration {
      ipv4_enabled        = var.ipv4_enabled
      #authorized_networks = var.authorized_networks
    }
  }

  deletion_protection = var.deletion_protection
}

resource "google_sql_database" "database" {
  name     = var.database_name
  instance = google_sql_database_instance.instance.name
}

resource "google_sql_user" "write_user" {
  name     = var.write_user_name
  instance = google_sql_database_instance.instance.name
  password = var.write_user_password
}

resource "google_sql_user" "read_user" {
  name     = var.read_user_name
  instance = google_sql_database_instance.instance.name
  password = var.read_user_password
}

resource "null_resource" "grant_read_only" {
  count = var.enable_read_only_grants ? 1 : 0

  provisioner "local-exec" {
    command = <<EOT
      echo "GRANT SELECT ON ALL TABLES IN SCHEMA public TO ${var.read_user_name};" > grant_read_${var.database_name}.sql
      echo "ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT ON TABLES TO ${var.read_user_name};" >> grant_read_${var.database_name}.sql
    EOT
  }

  depends_on = [
    google_sql_user.read_user,
    google_sql_user.write_user,
    google_sql_database.database
  ]
}

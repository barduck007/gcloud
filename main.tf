module "cloudsql_blog" {
  source = "./modules/cloudsql"

  instance_name       = var.db_instance_name
  region              = var.region
  database_version    = "POSTGRES_15"
  tier                = "db-f1-micro"
  ipv4_enabled        = true
  deletion_protection = false  # Mettre à true en production

  database_name = var.db_name

  write_user_name     = var.db_write_user
  write_user_password = var.db_write_password

  read_user_name     = var.db_read_user
  read_user_password = var.db_read_password

  enable_read_only_grants = true
}

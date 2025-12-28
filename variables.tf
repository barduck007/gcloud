variable "project_id" {
  description = "ID du projet Google Cloud"
  type        = string
}

variable "region" {
  description = "Région GCP"
  type        = string
  default     = "europe-west1"
}

variable "db_instance_name" {
  description = "Nom de l'instance Cloud SQL"
  type        = string
  default     = "blog-sql"
}

variable "db_name" {
  description = "Nom de la base de données"
  type        = string
  default     = "blog"
}

variable "db_write_user" {
  description = "Utilisateur avec droits d'écriture"
  type        = string
  default     = "blog_write"
}

variable "db_write_password" {
  description = "Mot de passe de l'utilisateur blog_write"
  type        = string
  sensitive   = true
}

variable "db_read_user" {
  description = "Utilisateur avec droits de lecture"
  type        = string
  default     = "blog_read"
}

variable "db_read_password" {
  description = "Mot de passe de l'utilisateur blog_read"
  type        = string
  sensitive   = true
}

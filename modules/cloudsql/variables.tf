variable "region" {
  description = "Région GCP"
  type        = string
}

variable "database_version" {
  description = "Version de PostgreSQL"
  type        = string
  default     = "POSTGRES_15"
}

variable "tier" {
  description = "Type d'instance (db-f1-micro, db-n1-standard-1, etc.)"
  type        = string
  default     = "db-f1-micro"
}

variable "ipv4_enabled" {
  description = "Activer l'accès IPv4 public"
  type        = bool
  default     = true
}

#variable "authorized_networks" {
# description = "Liste des réseaux autorisés à se connecter"
#  type = list(object({
#   name  = string
#    value = string
#  }))
#  default = []
#}

variable "deletion_protection" {
  description = "Activer la protection contre la suppression"
  type        = bool
  default     = true
}

variable "database_name" {
  description = "Nom de la base de données"
  type        = string
}

variable "write_user_name" {
  description = "Nom de l'utilisateur avec droits d'écriture"
  type        = string
}

variable "write_user_password" {
  description = "Mot de passe de l'utilisateur en écriture"
  type        = string
  sensitive   = true
}

variable "read_user_name" {
  description = "Nom de l'utilisateur avec droits de lecture"
  type        = string
}

variable "read_user_password" {
  description = "Mot de passe de l'utilisateur en lecture"
  type        = string
  sensitive   = true
}

variable "enable_read_only_grants" {
  description = "Générer le script SQL pour les droits en lecture seule"
  type        = bool
  default     = true
}

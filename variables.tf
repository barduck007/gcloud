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

variable "gke_cluster_name" {
    description = "Nom du cluster GKE"
    type        = string
    default     = "blog-cluster"
}

variable "gke_node_machine_type" {
    description = "Type de machine pour les nodes GKE"
    type        = string
    default     = "e2-medium"
}

variable "gke_node_min_count" {
    description = "Nombre minimum de nodes"
    type        = number
    default     = 1
}

variable "gke_node_max_count" {
    description = "Nombre maximum de nodes"
    type        = number
    default     = 3
}

variable "vpc_network_name" {
    description = "Nom du réseau VPC"
    type        = string
    default     = "default"
}

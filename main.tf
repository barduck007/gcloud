module "cloudsql_blog" {
    source = "./modules/cloudsql"

    instance_name    = var.db_instance_name
    region           = var.region
    database_version = "POSTGRES_15"
    tier             = "db-f1-micro"
    ipv4_enabled     = true
    deletion_protection = false  # Mettre à true en production

    database_name = var.db_name

    write_user_name     = var.db_write_user
    write_user_password = var.db_write_password

    read_user_name     = var.db_read_user
    read_user_password = var.db_read_password

    enable_read_only_grants = true
}

# Récupérer les informations du réseau VPC par défaut
data "google_compute_network" "default" {
    name    = var.vpc_network_name
    project = var.project_id
}

# Récupérer les informations du sous-réseau par défaut
data "google_compute_subnetwork" "default" {
    name    = var.vpc_network_name
    region  = var.region
    project = var.project_id
}

module "kubernetes_engine" {
    source = "./modules/kubernetesEngine"

    instance_name = var.gke_cluster_name
    project_id    = var.project_id
    region        = var.region
    network       = data.google_compute_network.default.name
    subnetworks = {
        "${var.region}" = data.google_compute_subnetwork.default
    }

    # Configuration optionnelle (utilise les valeurs par défaut du module si non spécifié)
    node_machine_type = var.gke_node_machine_type
    node_min_count    = var.gke_node_min_count
    node_max_count = var.gke_node_max_count

    # Plages IP pour les pods et services (doivent être configurées dans votre VPC)
    pod_ip_range     = "gke-pods"
    service_ip_range = "gke-services"
}

# Le module networks n'est pas encore complet, on le commente pour l'instant
# module "networks" {
#   source = "./modules/network"
# }

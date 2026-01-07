resource "google_service_account" "gke_sa" {
    account_id   = "${var.instance_name}-sa"
    display_name = "Service Account pour Kubernetes Engine ${var.instance_name}"
}

# Ajout des permissions IAM nécessaires pour le service account
resource "google_project_iam_member" "k8s_sa_roles" {
    for_each = toset([
        "roles/logging.logWriter",
        "roles/monitoring.metricWriter",
        "roles/monitoring.viewer",
        "roles/stackdriver.resourceMetadata.writer"
    ])

    project = var.project_id
    role    = each.value
    member  = "serviceAccount:${google_service_account.gke_sa.email}"
}

module "gke_cluster" {
    source  = "terraform-google-modules/kubernetes-engine/google"
    version = "~> 30.0"

    project_id        = var.project_id
    name              = var.instance_name
    region            = var.region
    network           = var.network
    subnetwork        = var.subnetworks[var.region].self_link
    ip_range_pods     = var.pod_ip_range
    ip_range_services = var.service_ip_range

    kubernetes_version = var.kubernetes_version

    node_pools = [
        {
            name            = "mon-pool"
            machine_type    = var.node_machine_type
            min_count       = var.node_min_count
            max_count       = var.node_max_count
            disk_size_gb    = var.node_disk_size_gb
            disk_type       = "pd-standard"
            image_type      = "COS_CONTAINERD"
            preemptible     = var.node_preemptible
            service_account = google_service_account.gke_sa.email
            auto_upgrade    = true
            auto_repair     = true
        }
    ]

    node_pools_oauth_scopes = {
        all = ["https://www.googleapis.com/auth/cloud-platform"]
    }

    enable_private_endpoint = true
    enable_private_nodes    = true

    master_ipv4_cidr_block = var.master_ipv4_cidr_block

    # Autoriser l'accès au master depuis le réseau VPC
    master_authorized_networks = [
        {
            cidr_block   = "10.0.0.0/8"
            display_name = "VPC"
        }
    ]

    network_policy             = true
    horizontal_pod_autoscaling = true
    http_load_balancing        = true

    remove_default_node_pool = true

    depends_on = [
        google_service_account.gke_sa,
        google_project_iam_member.k8s_sa_roles
    ]
}

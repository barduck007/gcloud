variable "instance_name" {
    description = "Nom de l'instance Kubernetes Engine"
    type        = string
    default     = "mon_cluster"
}

variable "project_id" {
    description = "ID du projet GCP"
    type        = string
}

variable "region" {
    description = "Région GCP pour le cluster"
    type        = string
}

variable "network" {
    description = "Nom du réseau VPC"
    type        = string
}

variable "subnetworks" {
    description = "Map des sous-réseaux par région"
    type        = map(any)
}

variable "pod_ip_range" {
    description = "Nom de la plage IP secondaire pour les pods"
    type        = string
    default     = "pods"
}

variable "service_ip_range" {
    description = "Nom de la plage IP secondaire pour les services"
    type        = string
    default     = "services"
}

variable "kubernetes_version" {
    description = "Version de Kubernetes"
    type        = string
    default     = "latest"
}

variable "master_ipv4_cidr_block" {
    description = "CIDR block pour le master GKE"
    type        = string
    default     = "172.16.0.0/28"
}

variable "node_machine_type" {
    description = "Type de machine pour les nodes"
    type        = string
    default     = "e2-medium"
}

variable "node_min_count" {
    description = "Nombre minimum de nodes"
    type        = number
    default     = 1
}

variable "node_max_count" {
    description = "Nombre maximum de nodes"
    type        = number
    default     = 3
}

variable "node_disk_size_gb" {
    description = "Taille du disque des nodes en GB"
    type        = number
    default     = 10
}

variable "node_preemptible" {
    description = "Utiliser des nodes preemptible (moins chers mais peuvent être interrompus)"
    type        = bool
    default     = false
}

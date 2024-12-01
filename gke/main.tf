resource "google_container_cluster" "gke_cluster" {
  name     = "gke-cluster"
  location = var.region
  network  = var.network_vpc
  subnetwork = var.subnet_vpc
  node_locations = [
    "us-east1-b"
  ]
  ip_allocation_policy {
    services_secondary_range_name = var.subnet_vpc_ip_range_1
    cluster_secondary_range_name  = var.subnet_vpc_ip_range_2
  }
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "general_pool" {
  name       = "general-pool"
  cluster    = google_container_cluster.gke_cluster.name
  location   = var.region
  node_count = var.general_pool_node_count
  node_config {
    preemptible  = false
    machine_type = var.general_pool_machine_type
    disk_size_gb  = 10
    local_ssd_count = 0
    disk_type = "pd-standard"
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

resource "google_container_node_pool" "cpu_pool" {
  name       = "cpu-pool"
  cluster    = google_container_cluster.gke_cluster.name
  location   = var.region
  node_count = var.cpu_pool_node_count
  node_config {
    preemptible = false
    disk_size_gb  = 10
    local_ssd_count = 0
    disk_type = "pd-standard"
    machine_type = var.cpu_pool_machine_type
    oauth_scopes = ["https://www.googleapis.com/auth/cloud-platform"]
  }
}

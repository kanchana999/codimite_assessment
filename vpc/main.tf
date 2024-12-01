resource "google_compute_network" "vpc_network" {
  name = "gke-vpc"
  auto_create_subnetworks = false  
  routing_mode            = "GLOBAL"  
  description             = "VPC network"
  mtu                     = 1460 

}

resource "google_compute_subnetwork" "public_subnet" {
  name          = "public-subnet"
  ip_cidr_range = var.public_subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.10.0.0/16"
  }

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = "10.11.0.0/16"
  }
  depends_on    = [google_compute_network.vpc_network]
}

resource "google_compute_subnetwork" "private-subnet" {
  name          = "private-subnet"
  ip_cidr_range = var.private_subnet_cidr
  region        = var.region
  network       = google_compute_network.vpc_network.id
  secondary_ip_range {
    range_name    = "services-range"
    ip_cidr_range = "10.12.0.0/16"
  }

  secondary_ip_range {
    range_name    = "pod-ranges"
    ip_cidr_range = "10.13.0.0/16"
  }
  depends_on    = [google_compute_network.vpc_network]
}

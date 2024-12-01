output "vpc_network" {
  value = google_compute_network.vpc_network.id
}
output "vpc_subnetwork" {
  value = google_compute_subnetwork.public_subnet.id
}



output "gke_endpoint" {
  value = module.gke.endpoint
}

output "vpc_network_name" {
  value = module.vpc.vpc_network
}

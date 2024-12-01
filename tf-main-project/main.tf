module "vpc" {
  source              = "./vpc"
  public_subnet_cidr    = "10.0.1.0/24"
  private_subnet_cidr   = "10.0.2.0/24"
  region              = var.region
}

module "gke" {
  source                      = "./gke"
  general_pool_node_count     = var.general_pool_node_count
  general_pool_machine_type   = var.general_pool_machine_type
  cpu_pool_node_count         = var.cpu_pool_node_count
  cpu_pool_machine_type       = var.cpu_pool_machine_type
  subnet_vpc                  = module.vpc.vpc_subnetwork
  network_vpc                 = module.vpc.vpc_network
}

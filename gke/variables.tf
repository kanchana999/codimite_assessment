variable "general_pool_node_count" {
  description = "Number of nodes for the general workload pool"
  default     = 1
}

variable "general_pool_machine_type" {
  description = "Machine type for general workloads"
  default     = "e2-micro"
}

variable "cpu_pool_node_count" {
  description = "Number of nodes for the CPU-intensive workload pool"
  default     = 1
}

variable "cpu_pool_machine_type" {
  description = "Machine type for CPU-intensive workloads"
  default     = "n2-highcpu-2"
}

variable "subnet_vpc_ip_range_1" {
  description = "subnetwork from vpc"
  default     = "services-range"
}
variable "subnet_vpc_ip_range_2" {
  description = "subnetwork from vpc"
  default     = "pod-ranges"
}
variable "network_vpc" {
  description = "vpc name for gke"
}
variable "subnet_vpc" {
  description = "subnet name for gke"
}
variable "region" {
  description = "region"
  default     = "us-east1"
}






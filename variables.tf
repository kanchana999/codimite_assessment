variable "project_id" {
  default = "poetic-hawk-443309-u2"
  description = "Google Cloud Project ID"
}

variable "region" {
  description = "Region for resources"
  default     = "us-east1"
}
variable "general_pool_node_count" {
  description = "Number of nodes for the general workload pool"
  default     = 1
}

variable "general_pool_machine_type" {
  description = "Machine type for general workloads"
  default     = "e2-medium"
}

variable "cpu_pool_node_count" {
  description = "Number of nodes for the CPU-intensive workload pool"
  default     = 1
}

variable "cpu_pool_machine_type" {
  description = "Machine type for CPU-intensive workloads"
  default     = "n2-highcpu-4"
}

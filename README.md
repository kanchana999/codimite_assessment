# codimite_assessment

# GKE Terraform Setup

This Terraform code provisions a Google Kubernetes Engine (GKE) cluster along with its networking infrastructure on Google Cloud Platform (GCP). Below is a detailed explanation of the structure and functionality of the code:

---

## **1. Overview**

This setup includes:
- A custom Virtual Private Cloud (VPC) with public and private subnets.
- A GKE cluster with two node pools for general workloads and CPU-intensive workloads.
- Configurations for Terraform state storage using Google Cloud Storage (GCS).

---

## **2. Modules**

### **`main.tf`**
This is the main entry point for Terraform, which invokes the following modules:

#### **VPC Module**
- **Path**: `./vpc`
- **Purpose**: Creates a custom VPC network with specific CIDR ranges for public and private subnets.

#### **GKE Module**
- **Path**: `./gke`
- **Purpose**: Deploys a GKE cluster with two node pools:
  - **General Pool**: For general workloads.
  - **CPU Pool**: For CPU-intensive workloads.
  
Dependencies between the modules ensure that the GKE cluster is created within the VPC.

---

## **3. VPC Module**

The `vpc` module provisions the networking layer for the GKE cluster. 

### **Resources**
- **VPC Network**:
  - **Resource**: `google_compute_network`
  - **Name**: `gke-vpc`
  - **Description**: A custom VPC network with no default subnetworks.

- **Public Subnet**:
  - **Resource**: `google_compute_subnetwork`
  - **CIDR Range**: `10.0.1.0/24`
  - **Secondary Ranges**:
    - **Services Range**: `10.10.0.0/16`
    - **Pod Range**: `10.11.0.0/16`

- **Private Subnet**:
  - **Resource**: `google_compute_subnetwork`
  - **CIDR Range**: `10.0.2.0/24`
  - **Secondary Ranges**:
    - **Services Range**: `10.12.0.0/16`
    - **Pod Range**: `10.13.0.0/16`

### **Outputs**
- **`vpc_network`**: The ID of the VPC network.
- **`vpc_subnetwork`**: The ID of the public subnet.

---

## **4. GKE Module**

The `gke` module provisions a GKE cluster and its associated resources.

### **Resources**
- **GKE Cluster**:
  - **Resource**: `google_container_cluster`
  - **Name**: `gke-cluster`
  - **Network**: VPC created in the `vpc` module.
  - **Subnetwork**: Public subnet from the `vpc` module.
  - **IP Allocation Policy**:
    - **Services Secondary Range**: `services-range`
    - **Cluster Secondary Range**: `pod-ranges`
  - Default node pool is disabled to allow custom node pools.

- **Node Pools**:
  - **General Pool**:
    - **Resource**: `google_container_node_pool`
    - **Node Count**: `1`
    - **Machine Type**: `e2-medium`
    - **Disk Size**: `10GB`
  - **CPU Pool**:
    - **Resource**: `google_container_node_pool`
    - **Node Count**: `1`
    - **Machine Type**: `n2-highcpu-4`
    - **Disk Size**: `10GB`

### **Outputs**
- **`endpoint`**: The endpoint of the GKE cluster.

---

## **5. Variables**

The following variables allow customization of the setup:

| Variable Name                | Description                                  | Default Value      |
|------------------------------|----------------------------------------------|--------------------|
| `project_id`                 | GCP Project ID                              | `poetic-hawk-443309-u2` |
| `region`                     | GCP Region                                  | `us-east1`         |
| `general_pool_node_count`    | Number of nodes in the general pool          | `1`                |
| `general_pool_machine_type`  | Machine type for general pool nodes          | `e2-medium`        |
| `cpu_pool_node_count`        | Number of nodes in the CPU-intensive pool    | `1`                |
| `cpu_pool_machine_type`      | Machine type for CPU-intensive pool nodes    | `n2-highcpu-4`     |
| `public_subnet_cidr`         | CIDR range for the public subnet             | `10.0.1.0/24`      |
| `private_subnet_cidr`        | CIDR range for the private subnet            | `10.0.2.0/24`      |

---

## **6. Backend Configuration**

Terraform state is stored remotely in a GCS bucket for centralized state management.

### **Configuration**
- **Bucket Name**: `tf_state_bucket_99`
- **Prefix**: `gke-cluster/terraform/state`

---

## **7. Outputs**

The following outputs are generated after successful execution:
- **`gke_endpoint`**: The endpoint URL of the GKE cluster.
- **`vpc_network_name`**: The name of the VPC network.

---

## **8. Usage**

1. Initialize Terraform:
   ```bash
   terraform init


# GCP Concepts & Networking

1.high-level architecture diagram showing the networking setup
![alt text](https://github.com/kanchana999/codimite_assessment/blob/main/img/gcp_diagram.png?raw=true)


2.Summary Explanation
- Securing the Setup:
All GKE nodes are hosted within a private subnet to ensure they are not directly exposed to the internet.
Cloud SQL and Redis Security: VPC Service Controls to enforce boundaries and prevent unauthorized access to Cloud SQL and Redis.
Apply firewall rules and only allow nessary traffic (eg: http/https):
Allow ingress traffic only from the GCP Load Balancer to the GKE nodes.
Enable HTTPS with TLS certificates for the load balancer to secure external traffic.
Cloud Armor to protect against DDoS attacks and other vulnerabilities.

- Cost Optimization While Maintaining High Availability:
Configure Cluster Autoscaler to dynamically scale the node pool based on traffic.
Enable caching at the GCP Load Balancer level to reduce backend load and optimize performance.
Distribute the node group across multiple zones within the region to maintain high availability while using cost-efficient zonal resources.
Use the standard tier in Redis Memory for high availability but optimize instance size based on actual workload requirements.

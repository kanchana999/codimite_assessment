# codimite_assessment


# GCP Concepts & Networking

1.high-level architecture diagram showing the networking setup
![alt text](https://github.com/kanchana999/codimite_assessment/blob/main/gcp_diagram.png?raw=true)


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
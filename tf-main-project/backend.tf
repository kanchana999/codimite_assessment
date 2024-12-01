
terraform {
  backend "gcs" {
    bucket  = "tf_state_bucket_99"
    prefix  = "gke-cluster/terraform/state"
  }
}

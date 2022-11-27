# these could go into the module files themselves but this is a bit cleaner
variable "project_id" {
  description = "project id"
}

variable "service_account" {
  description = "name of the SA"
}

variable "bucket_name" {
  description = "the name of the GCP bucket to create to hold remote tf state"
}

variable "region" {
  description = "region"
}

variable "zone" {
  description = "zone"
}

variable "cluster_name" {
  description = "the gke cluster name"
}

variable "node_count" {
  description = "the amount of worker nodes"
}

variable "machine_type" {
  description = "the amount of worker nodes"
}

variable "gcp_auth_file" {
  description = "our creds file for the SA"
}

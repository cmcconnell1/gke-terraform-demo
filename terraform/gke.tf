#
# Note1: 
#   for H/A deployments consider basing your terraform/IAC on the community supported 
#   terraform-google-modules/terraform-google-kubernetes-engine
#   https://github.com/terraform-google-modules/terraform-google-kubernetes-engine
#
# Note2:
#   This project is just for simple demo purposes.
#   ref: https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster#example-usage---with-a-separately-managed-node-pool-recommended
#   It is recommended that node pools be created and managed as separate resources as in the example above. 
#   This allows node pools to be added and removed without recreating the cluster. 
#   Node pools defined directly in the google_container_cluster resource cannot be removed without re-creating the cluster.

resource "google_service_account" "default" {
  account_id   = "service-account-id"
  display_name = "Service Account"
}

# https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/container_cluster#argument-reference
resource "google_container_cluster" "primary" {
  name     = var.cluster_name
  # If you specify a zone, the cluster will be a zonal cluster with a single cluster master.
  location = var.zone
  # If we specify a region (us-west1), this cluster will be a regional cluster 
  # with multiple masters spread across zones in the region, and with default node locations in those zones as well
  # we cant create a cluster with no node pool defined, but we want to only use
  # separately managed node pools. So we create the smallest possible default
  # node pool and immediately delete it.
  remove_default_node_pool = true
  initial_node_count       = 1
}

resource "google_container_node_pool" "primary_preemptible_nodes" {
  name       = "nodepool1"
  location   = var.zone
  cluster    = var.cluster_name
  node_count = var.node_count

  node_config {
    preemptible  = true
    machine_type = var.machine_type
    tags         = ["env", "develop"]

    # Google recommends custom service accounts that have cloud-platform scope and permissions granted via IAM Roles.
    service_account = google_service_account.default.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}

data "google_container_cluster" "primary" {
  name     = var.cluster_name
  location = var.zone
}

# could go in a separate outputs file but for this demo keeping it here
output "endpoint" {
  value = data.google_container_cluster.primary.endpoint
}

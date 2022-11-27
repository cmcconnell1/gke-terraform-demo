provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
  credentials = file(var.gcp_auth_file)
}

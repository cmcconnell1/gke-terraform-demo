terraform {
  backend "gcs" {
    credentials = "../secrets/terraform-gke-keyfile.json"
    bucket      = "demox-4567999"
    prefix      = "terraform/state"
  }
}

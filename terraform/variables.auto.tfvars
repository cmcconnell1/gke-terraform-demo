project_id          = "demox-4567999"
bucket_name         = "demox-4567999"
service_account     = "gke-demo"
region              = "us-west1"
zone                = "us-west1-a"
machine_type        = "e2-medium"
node_count          = 2
cluster_name        = "gke-demo"
# required for authenticating using the service account we create in `create-gcp-prereqs`
gcp_auth_file       = "../secrets/terraform-gke-keyfile.json"

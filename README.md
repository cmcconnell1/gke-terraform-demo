# demo

### TL;DR 
- Create pre-requisites: GCP project, service account, creds, and infrastructure `./scripts/create-gcp-prereqs`

- Deploy GKE cluster and infra via Terraform `./scripts/deploy-terraform`
  - Installs GKE cluster and then deploys a simple [kuard demo app for k8s up and running](https://github.com/kubernetes-up-and-running/kuard#demo-application-for-kubernetes-up-and-running).

### Notes
- We wouldn't be running command-line terraform or using wrapper scripts for most environments.
  - Instead we would probably use Github Actions, Atlantis, etc.
  - I.e.: see the example Github Actions workflow file here:
    - `./.github/workflows/workflow.yaml`



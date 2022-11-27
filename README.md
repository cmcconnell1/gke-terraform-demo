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

- This module within this project is for simple demo purposes only. For H/A deployments, consider basing your terraform/IAC on the community supported instead: 
  - [Terraform Kubernetes Engine Module](https://github.com/terraform-google-modules/terraform-google-kubernetes-engine)

  - TODO: resolve issue with the google pub/sub terraform module, infra deploys and we can publish messages to queue, but look into error
```console
Error: Error creating Subscription: googleapi: Error 400: You have passed an invalid argument to the service (argument=PushConfig::oidc_token::service_account_email).
│
│   with module.pubsub.google_pubsub_subscription.push_subscriptions["push"],
│   on .terraform/modules/pubsub/main.tf line 118, in resource "google_pubsub_subscription" "push_subscriptions":
│  118: resource "google_pubsub_subscription" "push_subscriptions" {
```

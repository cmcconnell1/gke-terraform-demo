# demo

### TL;DR 
- Create pre-requisites: GCP project, service account, creds, and infrastructure 
  - `./scripts/create-gcp-prereqs`

- Deploy GKE cluster and infra via Terraform
  - `./scripts/deploy-terraform`
  - Installs GKE cluster and then deploys a simple [kuard demo app for k8s up and running](https://github.com/kubernetes-up-and-running/kuard#demo-application-for-kubernetes-up-and-running).
  - The GKE module within this project is for simple demo purposes only. 
    - For H/A deployments, consider basing your terraform/IAC on the community supported instead: 
      - [Terraform Kubernetes Engine Module](https://github.com/terraform-google-modules/terraform-google-kubernetes-engine)
- Regarding leveraging OSS/community Terraform modules, 
  - we have also included a GCP pub/sub (kafka'ish) module which leverages the community supported module: [https://github.com/terraform-google-modules/terraform-google-pubsub/tree/v4.0.1](https://github.com/terraform-google-modules/terraform-google-pubsub/tree/v4.0.1)

- Note that the benefits of using OSS (community supported modules) are significant and allows us to leverage the SME's for that infrastructure--in this case, we leverage the Google community Pub/Sub developers.  
  - Leveraging the OSS community ensures that our modules will continue to receive attention, upgrades, etc. as time progresses.  
  - Note that when/if we _do_ decide to _roll our own_, then we must commit constant time and resources to maintaining our modules.  
    - Supporting our own modules continues to increase the costs and resources as our code base and projects continue to evolve.
    - Leveraging OSS modules reduces time required to test, validate and upgrade our own in-house code. Teams can instead spend more time focusing on their business objectives.
      - i.e.: 
        - [Terraform Registry find modules for quickly deploying common infrastructure configurations](https://registry.terraform.io/browse/modules?provider=google)

### Notes
- We shouldn't be running command-line terraform or using wrapper scripts for anything but ephemeral test environments.
  - For all other environments--develop, stage, production, etc., we should instead drive Terraform state via Github Actions, Atlantis, etc.
  - I.e.: see the example Terraform Github Actions workflow files here:
    - 1.) A simple basic terraform workflow
      - `.github/workflows/workflow.yaml`
    - 2.) An advanced and real-lfe Azure cloud workflow requiring:
      - multiple environments (i.e.: develop, test, stage, prod) and
      - multiple azure tenants (i.e.: develop, production tenant) and
      - support for vars in terraform configs while still using secure azure remote state storage for distributed teams, etc.
      - `.github/workflows/azure-terraform-deploy-AKS.yml`

- TODO: resolve issue with the google pub/sub terraform module--wherein infra deploys and we can publish messages to queue, but we need to look into the error
  ```console
  Error: Error creating Subscription: googleapi: Error 400: You have passed an invalid argument to the service (argument=PushConfig::oidc_token::service_account_email).
  │
  │   with module.pubsub.google_pubsub_subscription.push_subscriptions["push"],
  │   on .terraform/modules/pubsub/main.tf line 118, in resource "google_pubsub_subscription" "push_subscriptions":
  │  118: resource "google_pubsub_subscription" "push_subscriptions" {
  ```

### Improvements 
- add pub/sub test/validation scripts
- configure with let's encrypt or install self-signed cert for GKE/k8s cluster to configure TLS for demo app/services
- add full lifecycle application and docker container/image build, tag, push, and deploy to gke
  - github actions workflow for this:
    - `.github/workflows/build-deploy-service.yml`

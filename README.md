### GCP Infrastructure for small-scale data pipeline

- The purpose of this code is to provide infrastructure for a smallscale data pipeline uding the google cloud platform.
- The build contains provisioning for two debian virtual machines and associated networking. 
- SSH keys are automatically provisioned into a hidden .ssh folder and deleted on destroy. Commands to connect to each vm are automatically provided. 
- Startup scripts are automatically pushed and run on the virtual machines including code to start cron jobs (scripts are commented out to allow testing of infrastructure before taking on a lengthly build process.)
- The build will also automatically provision topics in confluent-kafka after initial setup. 

### Installs
Terraform: [https://learn.hashicorp.com/tutorials/terraform/install-cli](https://learn.hashicorp.com/tutorials/terraform/install-cli)
Google-CLI [https://cloud.google.com/sdk/docs/install](https://cloud.google.com/sdk/docs/install)
### Setup
1. Create a google cloud account.
2. Follow instructions [HERE](https://cloud.google.com/docs/terraform/get-started-with-terraform) to create a google cloud project, set up permissions, and enable the APIs. Stop once these are complete.
3. In google cloud click the link in the side panel to set up a confluent kafka account. Get an API key and secret from a new kafka cluster. These will be used in variables.tf.
4. Fill in the variables.tf file with appropriate information.
5. Edit script files as desired. It may be worth testing the build overall before adding scripts. If the scripts error the build will fail.

### Notes
- The vms are configured to start and stop at designated times to conserve resources. This has not yet been fully tested.
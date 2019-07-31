# Overview

The idea of this demo is to show a typical command line workflow using open source Terraform.  Next is to show how to adopt Terraform Enterprise into that workflow without an interruption for developers.  In addition, the code-writing (Dev), pipeline-management (Ops), and policy (Sec) roles can be separated.

# Requirements

* AWS credentials
* [TFE user token](https://www.terraform.io/docs/enterprise/users-teams-organizations/users.html#api-tokens)

# Pre-demo

* Make your AWS credentials available through ENV variables
* Setup a credentials file with your [TFE user token](https://www.terraform.io/docs/enterprise/users-teams-organizations/users.html#api-tokens)
* Set a `TFE_TOKEN` environment variable to your token also
* Set a `TFE_ORG` environment variable to your example organization
* Set a `TFE_WORKSPACE` environment variable to an example new workspace
* [Add the example Sentinel policy](https://www.terraform.io/docs/enterprise/sentinel/manage-policies.html) 

# Steps

## Open-source

```
# Developer role
terraform init
terraform plan
terraform apply -auto-approve
```

## Move to Enterprise

```
# Security role
# Configure Sentinel policy in UI or VCS

# Ops role
tfe workspace new -name "${TFE_ORG}/${TFE_WORKSPACE}"
tfe pushvars \
-senv-var "AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID" \
-senv-var "AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY" \
-env-var 'CONFIRM_DESTROY=1'

# Developer role
mv workspace.tf.example workspace.tf
# edit workspace.tf with your org and workspace name
terraform init
# say yes to copy existing state to the new backend
mv terraform.tfstate terraform.tfstate.local
terraform plan

```

# Outcomes

* Developer maintains an `init`, `plan`, `apply` workflow
* Credentials and variables are now supplied by Ops, instead of issued to every Developer
* Policy can be enforced by Security teams without changing Developer workflow

# Example CI/CD Workflow

Instead of asking Developers to configure the remote backend in each repository, a common configuration of the CI/CD pipeline could drop this configuration.

* TravisCI: https://travis-ci.org/WhatsARanjit/remote_backend
* Repository is [configured](https://github.com/WhatsARanjit/remote_backend/blob/master/.travis.yml#L7) to fire off `pipeline.sh`
* `pipeline.sh` essentially does [what we did](https://github.com/WhatsARanjit/remote_backend/blob/master/pipeline.sh)
* One thing to point out is the `master` branch will run an `apply` but any other branches will simply run a `plan`; [this is very customizable](https://github.com/WhatsARanjit/remote_backend/blob/master/pipeline.sh#L36-L40)
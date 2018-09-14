# k8s-si-phosphore

k8s-si-phosphore stands for Kubernetes IS (SI in French) for PHOSPHORE.

De ploy as **infraascode** kubernets cluster(s)

## What?

Purpose of this project is to deploy as Kubernetes cluster that will host PHOSPHORE.si SI apps

    - Gitlab
    - AWX
    - Prometheus
    - ...

Currently cluster is deployed on Google Cloud platform

Main tools used are [Terraform](https://www.terraform.io) and [Ansible AWX](https://github.com/ansible/awx)


## How?

### Prerequisite

#### Google cloud platform

K8s is deployed in GCP (Google Cloud Platform)

We need to create manually:

- For k8s
    - project for Test env
    - project for Prod env
    - compute service account for Test project
    - compute service account for Prod project

For terraform backend
    - bucket for Test in test project
    - bucket for Prod in prod project
    - storage service account for Test
    - storage service account for Prod


##### Project

You need to manually create a GCP Project for Test and Prod env.
You can set this up in the [Google Cloud Console](https://console.cloud.google.com/)

Set properly Gitlab variables `GKE_PROJECT_*` and `GKE_REGION_*`


##### API account GCE (Compute)

We need to set up a few things to have access via the API. First, enable the GKE API in the [Google Developer’s Console](https://console.developers.google.com/apis/api/container.googleapis.com/overview).
Then, we’ll need service account credentials to use the API. Create a new key in [Google Cloud service account file](https://console.cloud.google.com/apis/credentials/serviceaccountkey)
You should then be asked to select which account to use. If GKE API access is setup correctly, you’ll see “Compute Engine default service account”. That’ll do fine for our requirements, so select that and “JSON” as the type.

You need to copy the content of the file to Gitlab project variable `GCE_JSON_TEST` or `GCE_JSON_PROD`

##### API account GCS (Storage)

Go to [IAM and administration/Service account](ttps://console.cloud.google.com/iam-admin/serviceaccounts) and create a new service account. Do not add any role.

TODO remove and use `GCE_JSON_TEST`
You need to copy the content of the file to Gitlab project variable `GCS_TERRAFORM_JSON_TEST` or `GCS_TERRAFORM_JSON_PROD`

###### bucket terraform

We use [GCS bucket as backend in order that terraform store its state](https://www.terraform.io/docs/backends/types/gcs.html)

Create the buckets and set GCS serive account as `Storage Object Admin`.

Put details of bucket in `GCS_TERRAFORM_BUCKET_*`

### OVH DNS

We need to update OVH DNS, then we need to create manually:

- Credential to connect to OVH API

#### Create token

We want to restrict the token to the domain we will update.
In lastpass there are already tokens to update `phosphoresi.net` and `phosphore.si` domain

You need to put details in `OVH_DNS_*` variables

If not created onnect to https://api.ovh.com/createToken/index.cgi?GET=/*&POST=/*&PUT=/*&DELETE=/* to create the token

TODO: Token creation need to be in another doc. Screenshot [OVH_API_createtoken.png]

## Usage

### Gitlab group variables

Below variables need to be defined for CI/CD.
Normally the shoud be defined in Gitlab infrascode group

- `DOMAIN_PROD` : DNS domain used for Prod `phosphore.si`
- `DOMAIN_TEST` : DNS domain used for Test `phosphoresi.net`
- `OVH_DNS_KEY_TEST` : Key to update Test domain
- `OVH_DNS_SECRET_TEST` : Secret to update Test domain
- `OVH_DNS_CONSUMER_KEY_TEST` : Consumer key to update Test domain
- `OVH_DNS_CONSUMER_KEY_PROD` : Consumer key to update Prod domain
- `OVH_DNS_KEY_PROD` : Key to update Prod domain
- `OVH_DNS_SECRET_PROD` : Secret to update Prod domain


### Gitlab project variables

- `GKE_PROJECT_TEST` : GKE project where k8s Test is deployed
- `GKE_PROJECT_PROD` : GKE project where k8s Prod is deployed
TODO - `GKE_REGION_TEST` : GKE Region where k8s Test is deployed
TODO - `GKE_REGION_PROD` : GKE Region where k8s Prod is deployed
- `GCE_JSON_TEST` : Content of json private key downloaded from Google Compute Engine cf [Google cloud platform section](Google cloud platform) for Test environment
- `GCE_JSON_PROD` : Content of json private key downloaded from Google Compute Engine cf [Google cloud platform section](Google cloud platform) for Prod environment
TODO - `GCS_TERRAFORM_JSON_TEST` : Content of json private key downloaded from Google Cloud Storage for Test environment
TODO - `GCS_TERRAFORM_JSON_PROD` : Content of json private key downloaded from Google Cloud Storage for Prod environment
- `GCS_TERRAFORM_BUCKET_TEST` : Bucket name for terraform state for Test environment
- `GCS_TERRAFORM_BUCKET_PROD` : Bucket name for terraform state for Prod environment

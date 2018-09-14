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

- a project for Test env
- a project for Prod env
- a compute API account for Test project
- a compute API account for Prod project

##### Project

You need to manually create a GCP Project for Test and Prod env.

Here is procedure for test env. The project currently uses `k8s-si-test` project.
You can set this up in the [Google Cloud Console](https://console.cloud.google.com/)

##### API account

Next, we need to set up a few things to have access via the API. First, enable the GKE API in the [Google Developer’s Console](https://console.developers.google.com/apis/api/container.googleapis.com/overview).
Then, we’ll need service account credentials to use the API. Create a new key in [Google Cloud service account file](https://console.cloud.google.com/apis/credentials/serviceaccountkey)
You should then be asked to select which account to use. If GKE API access is setup correctly, you’ll see “Compute Engine default service account”. That’ll do fine for our requirements, so select that and “JSON” as the type.

You need to copy the content of the file to Gitlab project variable `GOOGLE_ACCOUNT_JSON_TEST` or `GOOGLE_ACCOUNT_JSON_PROD`


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
- `OVH_DNS_KEY_PROD` : Key to update Prod domain
- `OVH_DNS_SECRET_PROD` : Secret to update Prod domain


### Gitlab project variables

- `GOOGLE_ACCOUNT_JSON_TEST` : Content of json private key downloaded from GCP cf [Google cloud platform section](Google cloud platform) for Test environment
- `GOOGLE_ACCOUNT_JSON` : Content of json private key downloaded from GCP cf [Google cloud platform section](Google cloud platform) for Prod environment
-

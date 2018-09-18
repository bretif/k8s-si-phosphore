terraform {
  backend "gcs" {
    bucket = "{{ GCS_TERRAFORM_BUCKET }}"
    prefix = "{{ TERRAFORM_PREFIX }}"
  }
}

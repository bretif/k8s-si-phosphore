
# Configuring the OVH provider from environment variables
 provider "ovh-dns-test" {
   endpoint           = "ovh-eu"
   application_key    = "{{ OVH_DNS_KEY }}"
   application_secret = "{{ OVH_DNS_SECRET }}"
   consumer_key       = "{{ OVH_CONSUMER_KEY }}"
 }

# Configure the Google Cloud provider
 provider "google" {
   project     = "{{ GKE_PROJECT }}"
   region      = "{{ GKE_REGION }}"
 }

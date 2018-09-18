resource "google_container_cluster" "k8s_si_cluster" {
  provider           = "google"
  name               = "k8s-si-{{ BRANCH_SHORT }}"
  description        = "PHOSPHORE.si Information System (SI) k8s cluster"
  zone               = "{{ GKE_REGION_TEST }}"
  min_master_version = "1.10.7-gke.1"

  node_pool = [{
    name       = "default-pool"
    node_count = 0
  }]
}

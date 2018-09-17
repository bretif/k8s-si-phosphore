# Create k8s cluster
resource "google_container_cluster" "primary" {
  provider           = "google"
  name               = "k8s-si-{{ BRANCH_SHORT }}"
  description        = "PHOSPHORE.SI Information System (SI) k8s cluster"
  zone               = "{{ GKE_REGION_TEST }}"
  initial_node_count = 2
}

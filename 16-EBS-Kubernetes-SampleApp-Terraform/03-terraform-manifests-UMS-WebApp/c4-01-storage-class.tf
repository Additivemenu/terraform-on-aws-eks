# Resource: Kubernetes Storage Class https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class_v1

# basically replicating what we had in section15, but now using terraform
resource "kubernetes_storage_class_v1" "ebs_sc" {  
  metadata {
    name = "ebs-sc"
  }
  storage_provisioner = "ebs.csi.aws.com"
  volume_binding_mode = "WaitForFirstConsumer"
}
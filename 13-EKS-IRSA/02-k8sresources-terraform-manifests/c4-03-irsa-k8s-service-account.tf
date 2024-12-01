# Resource: Kubernetes Service Account

# yeah, you note k8s component has a version number suffix in the resource name if we try to use TF to create it
resource "kubernetes_service_account_v1" "irsa_demo_sa" {
  depends_on = [ aws_iam_role_policy_attachment.irsa_iam_role_policy_attach ] # ! only when the IAM Role Policy Attachment is created, then we can create the Service Account
  metadata {
    name = "irsa-demo-sa"
    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.irsa_iam_role.arn
      }
  }
}


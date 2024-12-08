# Install EBS CSI Driver using HELM
# Resource: Helm Release  https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release
# ! helm release resource is just like executing helm CLI, you can ask gpt to convert below code to helm CLI
resource "helm_release" "ebs_csi_driver" {
  depends_on = [aws_iam_role.ebs_csi_iam_role]   # this explicit dependency ensures that the IAM Role is created before the Helm Release is attempted
  name       = "${local.name}-aws-ebs-csi-driver" # ! needs to match IAM Role Condition in c4-02
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver" 
  chart      = "aws-ebs-csi-driver"
  namespace = "kube-system"      # ! needs to match IAM Role Condition in c4-02

  set {
    name = "image.repository"
    value = "602401143452.dkr.ecr.ap-southeast-2.amazonaws.com/eks/aws-ebs-csi-driver" # ! Changes based on Region - This is for ap-southeast-2 Additional Reference: https://docs.aws.amazon.com/eks/latest/userguide/add-ons-images.html
  }       

  set {
    name  = "controller.serviceAccount.create"
    value = "true"
  }

  set {
    name  = "controller.serviceAccount.name"
    value = "ebs-csi-controller-sa"
  }

  set {
    name  = "controller.serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = "${aws_iam_role.ebs_csi_iam_role.arn}"
  }
    
}



# Resource: EBS CSI Driver AddOn
# Install EBS CSI Driver using EKS Add-Ons (aws_eks_addon) https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon
resource "aws_eks_addon" "ebs_eks_addon" {
  depends_on = [ aws_iam_role_policy_attachment.ebs_csi_iam_role_policy_attach] #! important to attach the policy before addon installation
  cluster_name = data.terraform_remote_state.eks.outputs.cluster_id 
  addon_name   = "aws-ebs-csi-driver"
  service_account_role_arn = aws_iam_role.ebs_csi_iam_role.arn  #! this is the role that will be used by the addon
}


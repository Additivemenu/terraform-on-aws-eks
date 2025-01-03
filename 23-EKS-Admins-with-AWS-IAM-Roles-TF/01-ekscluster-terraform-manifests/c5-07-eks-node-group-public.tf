# Create AWS EKS Node Group - Public
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group
resource "aws_eks_node_group" "eks_ng_public" {
  cluster_name    = aws_eks_cluster.eks_cluster.name

  node_group_name = "${local.name}-eks-ng-public"
  node_role_arn   = aws_iam_role.eks_nodegroup_role.arn   # ! important
  subnet_ids      = module.vpc.public_subnets # !which makes the node group public
  #version = var.cluster_version #(Optional: Defaults to EKS Cluster Kubernetes version)    
  
  ami_type = "AL2_x86_64"  
  capacity_type = "ON_DEMAND"
  disk_size = 20
  instance_types = ["t3.medium"] # remember k8s worker nodes needs a minimum of 2 vCPUs and 4GB of memory
  
  
  remote_access {
    ec2_ssh_key = "eks-terraform-key"
  }

  scaling_config {
    desired_size = 1
    min_size     = 1    
    max_size     = 2
  }

  # Desired max percentage of unavailable worker nodes during node group update.
  update_config {
    max_unavailable = 1    # (Optional) Desired max number of unavailable worker nodes during node group update.
    #max_unavailable_percentage = 50    # ANY ONE TO USE (Optional) Desired max percentage of unavailable worker nodes during node group update.
  }

  # !Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # !Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-AmazonEC2ContainerRegistryReadOnly,
    kubernetes_config_map_v1.aws_auth # !important, the creation sequence is: EKS Cluster -> aws-auth configMap -> Node Group
  ] 

  tags = {
    Name = "Public-Node-Group"
  }
}

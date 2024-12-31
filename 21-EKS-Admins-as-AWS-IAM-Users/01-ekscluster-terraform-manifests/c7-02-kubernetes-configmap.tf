#! Get AWS Account ID
data "aws_caller_identity" "current" {}

output "account_id" {
  value = data.aws_caller_identity.current.account_id
}

# Sample Role Format: arn:aws:iam::180789647333:role/hr-dev-eks-nodegroup-role
# Locals Block
locals {
  configmap_roles = [
    {
      #rolearn = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:role/${aws_iam_role.eks_nodegroup_role.name}"
      rolearn = "${aws_iam_role.eks_nodegroup_role.arn}"
      username = "system:node:{{EC2PrivateDNSName}}"
      groups = ["system:bootstrappers", "system:nodes"]
    },
  ]
  configmap_users = [
    {
      userarn = "${aws_iam_user.admin_user.arn}"
      username = "${aws_iam_user.admin_user.name}"
      groups = ["system:masters"]
    },
    {
      userarn = "${aws_iam_user.basic_user.arn}"
      username = "${aws_iam_user.basic_user.name}"
      groups = ["system:masters"]
    },
  ]
}

# Resource: Kubernetes Config Map
resource "kubernetes_config_map_v1" "aws_auth" {
  depends_on = [aws_eks_cluster.eks_cluster] #! important: this is required to ensure the config map is created after the EKS cluster is created
  metadata {
    name = "aws-auth"
    namespace = "kube-system"
  }

  data = {
    mapRoles = yamlencode(local.configmap_roles)
    mapUsers = yamlencode(local.configmap_users)
  }

}


/*
aws-auth config map in yaml format: 

apiVersion: v1
data:
  mapRoles: |
    - groups:
      - system:bootstrappers
      - system:nodes
      rolearn: arn:aws:iam::180789647333:role/hr-dev-eks-nodegroup-role
      username: system:node:{{EC2PrivateDNSName}}
  mapUsers: |
    - userarn: arn:aws:iam::180789647333:user/eksadmin1
      username: eksadmin1
      groups:
        - system:masters
    - userarn: arn:aws:iam::180789647333:user/eksadmin2
      username: eksadmin2
      groups:
        - system:masters
kind: ConfigMap
metadata:
  creationTimestamp: "2022-03-12T01:19:22Z"
  name: aws-auth
  namespace: kube-system
  resourceVersion: "16741"
  uid: e082bd27-b580-4e52-933b-63c56f06c99b

*/

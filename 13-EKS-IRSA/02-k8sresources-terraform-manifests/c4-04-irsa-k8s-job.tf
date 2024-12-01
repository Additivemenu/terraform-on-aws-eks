# Resource: Kubernetes Job https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/job
# Yes, Kubernetes (K8s) has a Job component. 
# It is one of the built-in Kubernetes workload resources designed to manage and run short-lived, one-off tasks or batch jobs.
resource "kubernetes_job_v1" "irsa_demo" {
  metadata {
    name = "irsa-demo"
  }
  spec {
    template {
      metadata {
        labels = {
          app = "irsa-demo"
        }
      }
      spec {
        service_account_name = kubernetes_service_account_v1.irsa_demo_sa.metadata.0.name  # ! this k8s job will use the service account we created
        container {
          name    = "irsa-demo"
          image   = "amazon/aws-cli:latest"
          args = ["s3", "ls"]
          #args = ["ec2", "describe-instances", "--region", "${var.aws_region}"] # Should fail as we don't have access to EC2 Describe Instances for IAM Role
        }
        restart_policy = "Never"
      }
    }
  }
}
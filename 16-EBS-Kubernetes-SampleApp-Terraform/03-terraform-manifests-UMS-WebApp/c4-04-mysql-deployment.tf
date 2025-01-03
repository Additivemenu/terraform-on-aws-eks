# Resource: MySQL Kubernetes Deployment
resource "kubernetes_deployment_v1" "mysql_deployment" {
  metadata {
    name = "mysql"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "mysql"
      }          
    }
    strategy {
      type = "Recreate" #! Important: Recreate strategy is used to avoid data corruption, as we are using persistent volume. 
    }  
    template {
      metadata {
        labels = {
          app = "mysql"
        }
      }
      spec {
        # we mount 2 volumes to the container
        volume {
          name = "mysql-persistent-storage"
          persistent_volume_claim {
            #claim_name = kubernetes_persistent_volume_claim_v1.pvc.metadata.0.name # THIS IS NOT GOING WORK, WE NEED TO GIVE PVC NAME DIRECTLY OR VIA VARIABLE, direct resource name reference will fail.
            claim_name = "ebs-mysql-pv-claim" #! reference to the PVC name, but we hardcoding it here
          }
        }
        volume {
          name = "usermanagement-dbcreation-script"
          config_map {
            name = kubernetes_config_map_v1.config_map.metadata.0.name  #! reference to config map name
          }
        }
        container {
          name = "mysql"
          image = "mysql:5.6"
          port {
            container_port = 3306
            name = "mysql"
          }
          env {
            name = "MYSQL_ROOT_PASSWORD"
            value = "dbpassword11"
          }
          volume_mount { #! consume the volume
            name = "mysql-persistent-storage"
            mount_path = "/var/lib/mysql"
          }
          volume_mount { #! consume the volume
            name = "usermanagement-dbcreation-script"
            mount_path = "/docker-entrypoint-initdb.d" #https://hub.docker.com/_/mysql Refer Initializing a fresh instance                                            
          }
        }
      }
    }      
  }
  
}
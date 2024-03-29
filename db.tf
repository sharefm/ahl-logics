
resource "kubernetes_deployment" "ahl-mysql" {
  metadata {
    name = "ahl-mysql"
  }

  spec {
    replicas = 1

    selector {
      match_labels = {
        app = "ahl-mysql"
      }
    }

    template {
      metadata {
        labels = {
          app = "ahl-mysql"
        }
      }

      spec {
        container {
          name  = ""
          image = "public.ecr.aws/ubuntu/mysql:8.0-22.04_edge"

          port {
            container_port = 3306
          }

          env {
            name  = "MYSQL_ROOT_PASSWORD"
            value = "$ecret"
          }
        }
      }
    }
  }
}

resource "kubernetes_service" "ahl-mysql-service" {
  metadata {
    name = "ahl-mysql-service"
    annotations = {
      "service.beta.kubernetes.io/aws-load-balancer-type" = "nlb"
    }
  }

  spec {
    selector = {
      app = "ahl-mysql"
    }

    port {
      port        = 3306
      target_port = 3306
    }

    type = "LoadBalancer"
    #load_balancer_subnet_ids = [ aws_subnet.public-a.id, aws_subnet.public-b.id, ]
  }
}




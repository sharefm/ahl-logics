
resource "kubernetes_namespace" "ahl-db-namespace" {
  metadata {    
    labels = {
      app = "ahl-db"
    }
    name = "ahl-db"
  }
}


resource "kubernetes_deployment" "ahl-db-deployment" {
  metadata {
    name = "ahl-db-deployment"
    namespace = kubernetes_namespace.ahl-db-namespace.metadata.0.name
    labels = {
      app = "ahl-db"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "ahl-db"
      }
    }
    template {
      metadata {
        labels = {
          app = "ahl-db"
        }
      }
      spec {
        container {
          image = "public.ecr.aws/ubuntu/mysql:8.0-22.04_edge"
          name  = "mysql"
        }
      }
    }
  }
}


resource "kubernetes_service" "ahl-app" {
  metadata {
    name = "ahl-app"
  }
  spec {
    selector = {
      App = kubernetes_deployment.ahl-app-deployment.spec.0.template.0.metadata[0].labels.app
    }
    #session_affinity = "ClientIP"
    port {
      port        = 3306
      target_port = 3306
    }
    type = "LoadBalancer"
  }
}


variable "MYSQL_ROOT_PASSWORD" {  
  type        = string
  default = "$ecret"
}
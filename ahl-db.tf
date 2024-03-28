


resource "kubernetes_namespace" "ahl-db" {
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
    namespace = kubernetes_namespace.ahl-db.metadata.0.name
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
          env {
            name = "MYSQL_ROOT_PASSWORD"
            value = var.MYSQL_ROOT_PASSWORD
          }
        }
      }
    }
  }
}


resource "kubernetes_service" "ahl-db" {
  metadata {
    name = "ahl-db"
  }
  spec {
    selector = {
      App = kubernetes_deployment.ahl-db-deployment.spec.0.template.0.metadata[0].labels.app
    }
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
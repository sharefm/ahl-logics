


resource "kubernetes_namespace" "ahl-app" {
  metadata {    
    labels = {
      app = "ahl-app"
    }
    name = "ahl-app"
  }
}


resource "kubernetes_deployment" "ahl-app-deployment" {
  metadata {
    name = "ahl-app-deployment"
    namespace = kubernetes_namespace.ahl-app.metadata.0.name
    labels = {
      app = "ahl-app"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "ahl-app"
      }
    }
    template {
      metadata {
        labels = {
          app = "ahl-app"
        }
      }
      spec {
        container {
          image = "registry.gitlab.com/architect-io/artifacts/nodejs-hello-world:latest"
          name  = "hello-world"
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
      port        = 80
      target_port = 80
    }
    type = "LoadBalancer"
  }
}
provider "kubernetes" {
    config_path = "/Users/D067229/.kube/config"
}

resource "kubernetes_namespace" "client" {
  metadata {
        name = "client"
  }
}

resource "kubernetes_namespace" "client2" {
  metadata {
        name = "client2"
  }
}
resource "kubernetes_service" "tcp-service" {
  metadata {
    name = "tcp-service"
  }
  spec {
    selector = {
      app = "tcp-server"
    }
    session_affinity = "ClientIP"
    port {
      port        = 6000
      target_port = 5000
    }

    type = "ClusterIP"
  }
}

resource "kubernetes_deployment" "server" {
  metadata {
    name = "tcp-server-app"
    labels = {
      app = "server"
    }
  }

  spec {
    selector{
        match_labels = {
          app = "tcp-server"
        }
    }
    template{
        metadata {
            labels= {  app = "tcp-server" }
        }
       spec {
            dns_policy = "ClusterFirst"
            restart_policy =  "Always"
            container {
              image = "tcp-server:latest"
              name  = "tcp-server-container"
              image_pull_policy = "Never"
              port {
                    container_port = 5000
              }

            }
        }
    }
  }
}

resource "kubernetes_deployment" "client" {
  metadata {
    name = "tcp-client"
    namespace = "client"
    labels = {
      app = "client"
    }
  }

  spec {
    selector{
        match_labels = {
          app = "tcp-client"
        }
    }
    replicas = 1
    template{
        metadata {
            labels= {  app = "tcp-client" }
        }
       spec {
            dns_policy = "ClusterFirst"
            restart_policy =  "Always"
            container {
              image = "tcp-client:latest"
              name  = "tcp-client-container"
              image_pull_policy = "Never"
              port {
                    container_port = 6000
              }

            }
        }
    }
  }
}

resource "kubernetes_deployment" "client2" {
  metadata {
    name = "tcp-client-second"
    namespace = "client2"
    labels = {
      app = "client"
    }
  }

  spec {
    selector{
        match_labels = {
          app = "tcp-client-second"
        }
    }
    replicas = 1
    template{
        metadata {
            labels= {  app = "tcp-client-second" }
        }
       spec {
            dns_policy = "ClusterFirst"
            restart_policy =  "Always"
            container {
              image = "tcp-client:latest"
              name  = "tcp-client-container"
              image_pull_policy = "Never"
              port {
                    container_port = 6000
              }
              env{
                     name  = "HOST_URL"
                     value = "tcp-service.default.svc.cluster.local"
              }
              env{
                     name  = "HOST_PORT"
                     value = 6000
              }
            }
        }
    }
  }
}


resource "kubernetes_network_policy" "server-default-deny-all" {
  count    = 1

  metadata {
    name      = "server-default-deny-all"
    namespace = "default"
  }

  spec {
    pod_selector {}
    ingress {} # single empty rule to allow all egress traffic

    policy_types = ["Ingress", "Egress"]
  }

}

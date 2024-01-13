terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "2.25.2"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

resource "kubernetes_ingress_v1" "vertex_ingress" {
  metadata {
    name = "vertex-ingress"
    annotations = {
      "kubernetes.io/ingress.class" = "traefik"
    }
  }

  spec {
    rule {
      host = var.vertex_urls.admin
      http {
        path {
          backend {
            service {
              name = "vertex-admin-vertex-admin-service"
              port {
                number = 7000
              }
            }
          }
          path = "/"
        }
      }
    }

    rule {
      host = var.vertex_urls.auth
      http {
        path {
          backend {
            service {
              name = "vertex-auth-vertex-auth-service"
              port {
                number = 7002
              }
            }
          }
          path = "/"
        }
      }
    }

    rule {
      host = var.vertex_urls.containers
      http {
        path {
          backend {
            service {
              name = "vertex-containers-vertex-containers-service"
              port {
                number = 7004
              }
            }
          }
          path = "/"
        }
      }
    }

    rule {
      host = var.vertex_urls.monitoring
      http {
        path {
          backend {
            service {
              name = "vertex-monitoring-vertex-monitoring-service"
              port {
                number = 7006
              }
            }
          }
          path = "/"
        }
      }
    }

    rule {
      host = var.vertex_urls.reverseproxy
      http {
        path {
          backend {
            service {
              name = "vertex-reverseproxy-vertex-reverseproxy-service"
              port {
                number = 7008
              }
            }
          }
          path = "/"
        }
      }
    }

    rule {
      host = var.vertex_urls.sql
      http {
        path {
          backend {
            service {
              name = "vertex-sql-vertex-sql-service"
              port {
                number = 7012
              }
            }
          }
          path = "/"
        }
      }
    }

    rule {
      host = var.vertex_urls.tunnels
      http {
        path {
          backend {
            service {
              name = "vertex-tunnels-vertex-tunnels-service"
              port {
                number = 7014
              }
            }
          }
          path = "/"
        }
      }
    }

    rule {
      host = var.vertex_urls.client
      http {
        path {
          backend {
            service {
              name = "vertex-client-vertex-client-service"
              port {
                number = 7018
              }
            }
          }
          path = "/"
        }
      }
    }
  }
}

resource "helm_release" "vertex_admin" {
  chart      = "vertex-admin"
  name       = "vertex-admin"
  repository = var.vertex_repo
}

resource "helm_release" "vertex_auth" {
  chart      = "vertex-auth"
  name       = "vertex-auth"
  repository = var.vertex_repo
}

resource "helm_release" "vertex_containers" {
  chart      = "vertex-containers"
  name       = "vertex-containers"
  repository = var.vertex_repo
}

resource "helm_release" "vertex_logs" {
  chart      = "vertex-logs"
  name       = "vertex-logs"
  repository = var.vertex_repo
}

resource "helm_release" "vertex_monitoring" {
  chart      = "vertex-monitoring"
  name       = "vertex-monitoring"
  repository = var.vertex_repo
}

resource "helm_release" "vertex_reverseproxy" {
  chart      = "vertex-reverseproxy"
  name       = "vertex-reverseproxy"
  repository = var.vertex_repo
}

resource "helm_release" "vertex_sql" {
  chart      = "vertex-sql"
  name       = "vertex-sql"
  repository = var.vertex_repo
}

resource "helm_release" "vertex_tunnels" {
  chart      = "vertex-tunnels"
  name       = "vertex-tunnels"
  repository = var.vertex_repo
}

resource "helm_release" "vertex_client" {
  chart      = "vertex-client"
  name       = "vertex-client"
  repository = var.vertex_repo

  set {
    name  = "configmap.VERTEX_AUTH_ADDR"
    value = "http://${var.vertex_urls.auth}/api"
  }

  set {
    name  = "configmap.VERTEX_CONTAINERS_ADDR"
    value = "http://${var.vertex_urls.containers}/api"
  }

  set {
    name  = "configmap.VERTEX_MONITORING_ADDR"
    value = "http://${var.vertex_urls.monitoring}/api"
  }

  set {
    name  = "configmap.VERTEX_SQL_ADDR"
    value = "http://${var.vertex_urls.sql}/api"
  }

  set {
    name  = "configmap.VERTEX_TUNNELS_ADDR"
    value = "http://${var.vertex_urls.tunnels}/api"
  }

  set {
    name  = "configmap.VERTEX_ADMIN_ADDR"
    value = "http://${var.vertex_urls.admin}/api"
  }

  set {
    name  = "configmap.VERTEX_REVERSEPROXY_ADDR"
    value = "http://${var.vertex_urls.reverseproxy}/api"
  }
}

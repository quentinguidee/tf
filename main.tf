provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
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
    value = var.vertex_urls.auth
  }

  set {
    name  = "configmap.VERTEX_CONTAINERS_ADDR"
    value = var.vertex_urls.containers
  }

  set {
    name  = "configmap.VERTEX_MONITORING_ADDR"
    value = var.vertex_urls.monitoring
  }

  set {
    name  = "configmap.VERTEX_SQL_ADDR"
    value = var.vertex_urls.sql
  }

  set {
    name  = "configmap.VERTEX_TUNNELS_ADDR"
    value = var.vertex_urls.tunnels
  }

  set {
    name  = "configmap.VERTEX_ADMIN_ADDR"
    value = var.vertex_urls.admin
  }

  set {
    name  = "configmap.VERTEX_REVERSEPROXY_ADDR"
    value = var.vertex_urls.reverseproxy
  }
}

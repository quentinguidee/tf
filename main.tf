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

resource "helm_release" "vertex_client" {
  chart      = "vertex-client"
  name       = "vertex-client"
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

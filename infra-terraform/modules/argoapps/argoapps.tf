resource "kubectl_manifest" "argoproject" {
    yaml_body = file("${path.module}/argoapps_files_files/argoproject.yml")
}


resource "kubectl_manifest" "cluster-autoscaler" {
    yaml_body = templatefile("${path.module}/argoapps_files/cluster-autoscaler.yml", { env = var.env })
}


resource "kubectl_manifest" "ebs-csi" {
    yaml_body = templatefile("${path.module}/argoapps_files/ebs-csi.yml", { env = var.env })
}

resource "kubectl_manifest" "external-dns" {
    yaml_body = templatefile("${path.module}/argoapps_files/external-dns.yml", { env = var.env })
}

resource "kubectl_manifest" "loadbalancercontroller" {
    yaml_body = templatefile("${path.module}/argoapps_files/loadbalancercontroller.yml", { env = var.env })
}

resource "kubectl_manifest" "metric-server" {
    yaml_body = templatefile("${path.module}/argoapps_files/metric-server.yml", { env = var.env })
}

resource "kubectl_manifest" "istio-base" {
    yaml_body = templatefile("${path.module}/argoapps_files/istio-base.yml", { env = var.env })
}

resource "kubectl_manifest" "istiod" {
    yaml_body = templatefile("${path.module}/argoapps_files/istiod.yml", { env = var.env })
}

resource "kubectl_manifest" "istio-ingress" {
    yaml_body = templatefile("${path.module}/argoapps_files/metric-server.yml", { env = var.env })
}



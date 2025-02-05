terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
    kubectl = {
      source  = "gavinbunney/kubectl"
      #version = ">= 1.7.0"
    }
  }
}

provider "aws" {
  region = var.region
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.controlplane.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.controlplane.certificate_authority.0.data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", data.aws_eks_cluster.controlplane.name]
    command     = "aws"
  }
}

provider "kubectl" {
  
}

variable "cluster_name" {}
variable "env" {}
variable "region" {}


module "foundationlayer" {
  source                               = "git::https://github.com/celigo/infra-terraform.git//modules/argoapps"
  cluster_name                         = var.cluster_name
  env                                  = var.env
  region                               = var.region
}
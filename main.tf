module "neha_vpc" {
  source = "./modules/network"
  vpc_name = var.vpc_name
}

module "neha_cluster_dev" {
  source = "./modules/k8s"

  env = var.env
  region = var.region
  project = var.project
}
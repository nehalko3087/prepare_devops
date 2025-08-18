 terraform {
  backend "gcs" {
    bucket  = "neha_terraform_state"
    prefix  = "terraform/state"
  }
}
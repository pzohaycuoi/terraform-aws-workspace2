provider "aws" {
  region = var.region
}

data "terraform_remote_state" "vpc" {
  backend = "remote"

  config = {
    organization = "nambeotest"
    workspaces = {
      name = "terraform-aws-workspace1"
    }
  }
}

module "namebeoec2" {
  source       = "app.terraform.io/nambeotest/nambeoec2/aws"
  region       = data.terraform_remote_state.vpc.outputs.region
  subnet       = data.terraform_remote_state.vpc.outputs.public_subnet
  project_name = data.terraform_remote_state.vpc.outputs.project_name
}

terraform {
  cloud {
    organization = "nambeotest"
    hostname = "app.terraform.io"

    workspaces {
      name = "terraform-aws-workspace2"
    }
  }
}

provider "aws" {
  region = var.region
}

data "terraform_remote_state" "network" {
  backend = "remote"

  config = {
    organization = "nambeotest"
    workspaces = {
          name = "terraform-aws-workspace1"
    }
  }
}

module "namebeovpc" {
  source = "app.terraform.io/nambeotest/nambeoec2/aws"
  subnet = data.terraform_remote_state.network.public_subnet
}
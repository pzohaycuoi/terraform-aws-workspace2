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

data "terraform_remote_state" "vpc" {
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
  region = var.region
  subnet = data.terraform_remote_state.vpc.outputs.public_subnet
  ec2_name = var.ec2_name
}
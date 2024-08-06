provider "aws" {
  region = "us-eest-1"
}

data "terraform_remote_state" "network" {
  backend = "remote"
  config = {
    organization = "knjoroge-org"
    workspaces = {
      name = "aws-0-network"
    }
  }
}

resource "aws_cloudwatch_log_group" "monitoring" {
  name = "network-monitoring"

  tags = {
    NetworkID = data.terraform_remote_state.network.outputs.vpc_id
  }
}

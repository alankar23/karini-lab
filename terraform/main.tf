provider "aws" {
  region  = var.provider_config["region"]
  profile = var.provider_config["profile"]
}

module "vpc" {
source = "./vpc"
}

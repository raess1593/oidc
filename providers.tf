terraform {
  backend "s3" {
    bucket = "raess1593-tfstate-central-bucket"
    key    = "oidc/terraform.tfstate"
    region = "us-east-1"
    dynamodb_table = "tfstate-lock-table"
    encrypt = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 6.47"
    }
  }
  required_version = ">= 0.14"
}

provider "aws" {
  region = "us-east-1"
}